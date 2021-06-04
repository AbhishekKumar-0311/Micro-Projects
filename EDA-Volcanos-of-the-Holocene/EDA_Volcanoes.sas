libname ip "\Folder\03062021";


proc import datafile = '\Folder\03062021\A2A volcanos.csv'
 out = ip.volcano_0
 dbms = CSV
 ;
run;


data ip.volcano;
set ip.volcano_0;
rename Elevation__Meters_ = Elevation;
run;

/*1a*/

%let f1 = Country = 'Italy' and Name = 'Vesuvius';
%put &=f1;

proc sql;

select count(*) as Count_of_Vesuvius
from ip.volcano
where &f1.;

select *
from ip.volcano
where &f1.;

quit;


/*1b*/

proc contents data=ip.volcano;
run;

proc sql;

select count(*) into :cnt from ip.volcano;

create table ip.describe as
select 'Latitude' as Attribute, count(*) as TotCount, count(Latitude) as NonNullCount, (calculated TotCount - calculated NonNullCount)/ calculated TotCount  * 100 as NullPct, min(Latitude) as MinVal,  max(Latitude) as MaxVal from ip.volcano
union
select 'Longitude' as Attribute, count(*) as TotCount, count(Longitude) as NonNullCount, (calculated TotCount - calculated NonNullCount)/ calculated TotCount  * 100 as NullPct, min(Longitude) as MinVal,  max(Longitude) as MaxVal from ip.volcano
union
select 'Elevation' as Attribute, count(*) as TotCount, count(Elevation) as NonNullCount, (calculated TotCount - calculated NonNullCount)/ calculated TotCount  * 100 as NullPct, min(Elevation) as MinVal,  max(Elevation) as MaxVal from ip.volcano
;

title 'Data Profiling';
select * from ip.describe;

title 'Analysis for Last_Known_Eruption';
select Last_Known_Eruption, count(Last_Known_Eruption) as dups
from ip.volcano
group by Last_Known_Eruption
order by calculated dups desc;

quit;

/*1c*/

data ip.volcano;
set ip.volcano;

if scan(Last_Known_Eruption, 2) = 'BCE' then Last_Eruption_Date = input(scan(Last_Known_Eruption, 1), 8.) * -1;
else if scan(Last_Known_Eruption, 2) = 'CE' then Last_Eruption_Date = input(scan(Last_Known_Eruption, 1), 8.);
else Last_Eruption_Date = .;

run;


/*1d*/

/*Deafulat : Equal no of bins*/
proc hpbin data=ip.volcano output=ip.volcano_bin ;
   input Last_Eruption_Date;
run;

/* No of bins specified 20*/
proc hpbin data=ip.volcano output=ip.volcano_bin ;
   input Last_Eruption_Date / numbin = 20;                 /* override global NUMBIN= option */
run;

/*1e*/
proc format library=work;
value $plttype
    "Rift Zone" = 1
    "Intraplate" = 2
    "Subduction Zone" = 3
    other = ''
    ;
run;
proc format library=work;
value $crsttype
    "Continental Crust" = 1
    "Intermediate Crust" = 2
    "Oceanic Crust" = 3
    other = ''
    ;
run;

data ip.volcano;
set ip.volcano;

Platetypec = strip(scan(Tectonic_Setting, 1,'/'));
Crusttypec = strip(scan(Tectonic_Setting, 2,'/('));

Platetype = input(put(strip(scan(Tectonic_Setting, 1,'/')), $plttype. ),8.);
Crusttype = input(put(strip(scan(Tectonic_Setting, 2,'/(')), $crsttype.),8.);

run;

title 'Analysis of Platetype and Crusttype';
proc freq data=ip.volcano;
   tables Platetype Crusttype / nocum;
run;


title 'Common Tectonic setting';
proc freq data=ip.volcano;
   tables Platetype * Crusttype / nocum nocol norow;
   output out = ip.crosstab
run;

Ods graphics on;Proc freq data=ip.volcano order=freq;
Tables Platetype * Crusttype/ plots=freqplot (type=bar scale=percent);
Run;
Ods graphics off;
/*1f*/
Ods graphics on;Proc freq data=ip.volcano order=freq;
Tables Platetype * Crusttype/ plots=freqplot (type=bar scale=percent);
Run;
Ods graphics off;


/*1g*/
title 'Distribution of Elevation';
PROC UNIVARIATE DATA = ip.volcano;
HISTOGRAM Elevation / normal;
var Elevation;
RUN;

/*1h*/
PROC SGPLOT  DATA = ip.volcano;
   VBOX Elevation
   / category = Platetype;

   title 'Bivariate Analysis of Elevation by Platetype';
RUN;

PROC MEANS data = ip.volcano MIN MAX MEAN STD MEDIAN SKEWNESS MEDIAN Q1 Q3;
    class Platetype;
    var Elevation;
RUN;

/* Another way to visualize 1h*/
PROC SGPLOT DATA = ip.volcano (where = (Platetypec ne 'Unknown'));
   VBOX Elevation
   / category = Platetypec;

   title 'Bivariate Analysis of Elevation by Platetype';
RUN;

PROC MEANS data = ip.volcano(where = (Platetypec ne 'Unknown')) MIN MAX MEAN STD MEDIAN SKEWNESS MEDIAN Q1 Q3;
    class Platetypec;
    var Elevation;
RUN;

/*1i*/
title 'Comparison of InterPlate and Intraplate Earthquakes';
proc sql;
select case when Platetypec ne 'Intraplate' then 'InterPlate'
            else Platetypec end as Platetypec , count(Number) as Count, calculated Count/&cnt. format= PERCENT5.2 as '% Share'n
from ip.volcano
group by calculated Platetypec;

quit;



