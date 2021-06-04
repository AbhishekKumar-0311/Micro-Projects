libname ip "\Folder\03062021";


proc import datafile = '\Folder\03062021\A2C road crashes.csv'
            out = ip.crashes
            dbms = CSV
            ;
            guessingrows=1000;
run;
proc import datafile = '\Folder\03062021\A2C road fatalities.csv'
            out = ip.fatalities
            dbms = CSV
            ;
            guessingrows=1000;
run;

data ip.crash;
set ip.crashes;
run;

data ip.fatal;
set ip.fatalities;
run;

/*Question 1*/

proc sql;
title 'Crash : Basic Data Profiling';
select count(*) as Tot, count(crashid) as NonNullCnt, count(distinct(crashid)) as UniqCrashID
from ip.crash;
title 'Fatatlities : Basic Data Profiling';
select count(*)as Tot, count(Crash_Id) as NonNullCnt, count(distinct(Crash_Id)) as UniqCrashID
from ip.fatal;
quit;

/*Relationship Description*/
/*The fatalities dataset has multiple records or casualities for some crashes.*/
/*This is going to be One-to-Many relationship. One Crash getting mapped to Multiple Casualities*/

/*Make sure there are no duplicates, which i have checked above*/
/*SInce the attribute crashid has different names in each dataset, it neede to be renamed na d both the dataseets need to be sorted before merging*/

proc sort data = ip.crash;
by crashid;
run;
proc sort data = ip.fatal;
by Crash_Id;
run;

data ip.accident_details;
merge ip.fatal(rename = (Crash_Id = crashid)) ip.crash;
by crashid;
run;

proc sql;
title 'Merged Data : Basic Data Profiling';
select count(*) as Tot, count(crashid) as NonNullCnt, count(distinct(crashid)) as UniqCrashID
from ip.accident_details;
title 'First 5 records of Merged Data';
select * from ip.accident_details (obs=5);
quit;

/*The merge is implemented correctly*/


/*Question 2*/

%let vars = crashtype businvolvement heavyrigidtruckinvolvement articulatedtruckinvolvement timeofday dayofweek;
%macro repeatplot();

%do i=1 %to 6;
%let var = %sysfunc(propcase(%scan(&vars.,&i.)));
title "Bivariate Analysis of &var by Gender";
proc freq data = ip.accident_details;
tables  &var * Gender;
run;

PROC SGPLOT DATA = ip.accident_details;;
 VBAR Gender / GROUP = &var GROUPDISPLAY = CLUSTER datalabel stat=percent;
title "Bivariate Analysis of &var by Gender";
RUN;

%end;

%mend;
%repeatplot();


%let vars = crashtype businvolvement heavyrigidtruckinvolvement articulatedtruckinvolvement timeofday dayofweek;
%macro repeatplot();

%do i=1 %to 6;
%let var = %sysfunc(propcase(%scan(&vars.,&i.)));
title "Univariate Analysis of &var";
proc freq data = ip.crash;
tables &var;
run;
%end;

%mend;
%repeatplot();

/*To create stacked bar chart */
/*PROC SGPLOT DATA = ip.accident_details;;*/
/*VBAR Gender / GROUP = crashtype datalabel stat=percent;*/
/*title "Bivariate Analysis of &var by Gender";*/
/*RUN;*/


/*Question 3*/

/*Data Reading*/
proc import datafile = '\Folder\03062021\A2C ABS population.xls'
            out = ip.seriesdata
            dbms = xls
            ;
            guessingrows=1000;
run;

/*Data Display*/
proc sql;
title 'First 5 records of Series Data';
select * from ip.seriesdata (obs=5);
quit;


/*Data Preparation for Time series Analysis*/
proc sql noprint;
create table ip.longseries as
select Date, 'NSW' as State, NSW as Population from ip.seriesdata
union all
select Date, 'Vic' as State, Vic as Population from ip.seriesdata
union all
select Date, 'Qld' as State, Qld as Population from ip.seriesdata
union all
select Date, 'SA' as State, SA as Population from ip.seriesdata
union all
select Date, 'WA' as State, WA as Population from ip.seriesdata
union all
select Date, 'Tas' as State, Tas as Population from ip.seriesdata
union all
select Date, 'NT' as State, NT as Population from ip.seriesdata
union all
select Date, 'ACT' as State, ACT as Population from ip.seriesdata
;
quit;

data ip.longseries2;
set ip.accident_details;

Qtrdt_b = intnx('month',intnx('qtr',mdy(month,1,year),0,'e'),0,'b');
format Qtrdt_b mmddyy10.;

run;

proc sql;
create table ip.longseries_agg as
select Qtrdt_b, State, count(crashid) as Fatality
from ip.longseries2
group by Qtrdt_b, State
order by Qtrdt_b, State;


create table ip.longseries_merged as 
select a.*,b.Fatality as Fatalities, (b.Fatality/a.Population) * 100000 as Fatality_Rate
from ip.longseries(where = (year(Date) >= 1989)) as a left join ip.longseries_agg as b
on a.Date = b.Qtrdt_b and a.State=b.State;
quit;

/*Time Series Chart*/
proc sgplot data=ip.longseries_merged;
 title "Analysis of Fatalities across States over Time";
 series x=Date y=Fatalities / group=State;
run;

proc sgplot data=ip.longseries_merged;
 title "Analysis of Fatality_Rate across States over Time";
 series x=Date y=Fatality_Rate / group=State;
run;

proc sgpanel data=ip.longseries_merged;
 title "Analysis of Fatality_Rate across States over Time"; 
 panelby State;
 series x=Date y=Fatality_Rate /*/ group=State;*/;
run;




