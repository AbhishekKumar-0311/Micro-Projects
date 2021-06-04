libname ip "\Folder\03062021";

%macro repeat();

%do i=2015 %to 2019;
proc import datafile = "\Folder\03062021\A2B happiness_&i..csv"
out = ip.happiness_&i.
dbms = CSV;
guessingrows=200;
run;
%end;

%mend;
%repeat();

%let rename1 = rename = (Economy__GDP_per_Capita_ = GDP_per_Capita Family = Social_Support Health__Life_Expectancy_ = Healthy_Life_Expectancy Freedom = Freedom_to_make_life_choices Trust__Government_Corruption_ = Perceptions_of_corruption );
%let rename2 = rename = (Country_or_region = Country Overall_Rank = Happiness_Rank Score = Happiness_Score );
%let keeping = keep = Year Country Happiness_rank Happiness_score GDP_per_capita Social_support Healthy_life_expectancy Freedom_to_make_life_choices Perceptions_of_corruption Generosity;

/*1a*/
data ip.happiness (&keeping.);
set ip.happiness_2015 (&rename1.) ip.happiness_2016 (&rename1.) ip.happiness_2017 (&rename1.) ip.happiness_2018 (&rename2.) ip.happiness_2019 (&rename2.) indsname = source;
Year = input(scan(source,2,'_'), 8.);
run;

proc contents data = ip.happiness;
run;


/*1b*/
data ip.happy;
set ip.happiness;
if country in ( 'Macedonia','North Macedonia') then country = 'North Macedon';
if country = 'Trinidad and Tobago' then country = 'Trinidad & Tobago';
if country = 'Taiwan' then country = 'Taiwan Province of China';
/*if country = 'Sudan' then country = 'South Sudan';*/
/*if country = 'Somaliland region' then country = 'Somalia';*/
if country = 'North Cyprus' then country = 'Northern Cyprus';
run;


proc sql;
title 'Duplicates Analysis';
select Year, Country, count(country) as TotCnt
from ip.happy
group by Year, Country
having calculated TotCnt > 1;
/*title 'Data with Count in each year for each country';*/
/*select Year, Country, count(country) as TotCnt*/
/*from ip.happy*/
/*group by Year, Country*/
/*order by calculated TotCnt desc;*/
quit;


/*1c*/
/*I have renamed the columnss using rename dataset option and kept them using keep option.*/
/*The sql query is used to list the duplicates country  within each year.*/
/*We do not have nay duplictaes here, which is confirmed by the output.*/

Ods graphics on;Proc freq data=ip.happy order=freq;
Tables Year/ plots=freqplot (type=bar );
Run;
Ods graphics off;
title 'Distribution Analysis by Year';
proc freq data=ip.happy;
   tables Year / nocum;
run;


/*2a*/
proc sort data = ip.happy (where = (Year=2019)) out = ip.happy_2019 ;
by Happiness_Rank;
run;

title 'List of Top 5 , Australia and Bottom 5'; 
proc sql;
select count(*) into : cnt from ip.happy_2019;
create table ip.selectedhappy as
select Country , Happiness_Rank, Happiness_Score from ip.happy_2019 (obs=5)
union all
select Country , Happiness_Rank, Happiness_Score from ip.happy_2019
where Country = 'Australia'
union all
select Country , Happiness_Rank, Happiness_Score from ip.happy_2019 (firstobs=%eval(&cnt-4));
quit;
proc print data=ip.selectedhappy;
run;

/*2b*/
proc sql noprint;
select quote(strip(country)) into: country separated by ',' from ip.happy_2019  (obs=5);
quit;
proc sgplot data=ip.happy (where = (country in  (&country , 'Australia')));
 title "Change over time";
 series x=year y=Happiness_Score / group=Country;
run;
proc sql noprint;
select quote(strip(country)) into: country separated by ',' from ip.happy_2019 (firstobs=%eval(&cnt-4));
quit;
proc sgplot data=ip.happy (where = (country in  (&country)));
 title "Change over time";
 series x=year y=Happiness_Score / group=Country;
run;
proc sql noprint;
select quote(strip(country)) into: country separated by ',' from ip.selectedhappy;
quit;
%put &=country;
proc sgplot data=ip.happy (where = (country in  (&country)));
 title "Change over time";
 series x=year y=Happiness_Score / group=Country;
run;

/*The top5 countries have higher Happiness score which is consistenstly high while for the bottom 5 the deviation is quite high but consistently remains in the lower side.*/
/*Due to this differencec, the series lines have a huge gap among the two groups.*/

/*2c*/

title 'Scatterplot - Bivariate Analysis';
proc sgscatter  data = ip.happy_2019;
   plot GDP_per_Capita*Healthy_Life_Expectancy 
   / datalabel = Country grid;
   title 'GDP_per_Capita vs Healthy_Life_Expectancy';
run; 
/*The Life Expectancy as well GDP_per_Capita of Hong-Kong is better than Saudi Arabia.*/



/*2d*/
title 'Scatterplot - MultiVariate Analysis';
proc sgscatter  data = ip.happy_2019;
   matrix GDP_per_Capita Social_Support Freedom_to_make_life_choices Perceptions_of_corruption Generosity;
   title 'GDP_per_Capita vs Other Parameters';
run; 

/*Heatmap across other parameters*/
%let vars = Social_Support Freedom_to_make_life_choices Perceptions_of_corruption Generosity;
%macro repeatplot();

%do i=1 %to 4;
%let var = %scan(&vars.,&i.);
proc sgplot data=ip.happy_2019;
 heatmap x=GDP_per_Capita y=&var;
 title "GDP_per_Capita vs &var.";
run;
%end;

%mend;
%repeatplot();


/*2e*/
data ip.happiness_2015;
set ip.happiness_2015;
if country = 'Macedonia' then country = 'North Macedon';
if country = 'Trinidad and Tobago' then country = 'Trinidad & Tobago';
if country = 'Taiwan' then country = 'Taiwan Province of China';
/*if country = 'Sudan' then country = 'South Sudan';*/
/*if country = 'Somaliland region' then country = 'Somalia';*/
if country = 'North Cyprus' then country = 'Northern Cyprus';
run;

proc sort data=ip.happy;
by country;
run;
proc sort data=ip.happiness_2015;
by country;
run;

data ip.happy_region;
merge ip.happy ip.happiness_2015;
by country;
run;
proc sql;
select distinct country
from ip.happy_region
where region = ' ';
quit;

title 'Frequency table of region by year';
proc freq data=ip.happy_region;
   tables Region * Year / nocum nopercent;
run;
/*Ods graphics on;*/
/*proc freq data=ip.happy_region order=freq;*/
/*   tables region*Year / */
/*       plots=freqplot(twoway=stacked orient=vertical);*/
/*run;*/
/*Ods graphics off;*/


proc freq data=ip.happy_region order=freq noprint;
   tables Region*Year / out=FreqOut(where=(percent^=.));
run;
ods graphics /height=500px width=800px;
title "Frequency table of region by year";
proc sgplot data=FreqOut;
  hbarparm category=Region response=count / group=Year  
      seglabel seglabelfitpolicy=none seglabelattrs=(weight=bold);
  keylegend / opaque across=1 position=bottomright location=inside;
  xaxis grid;
  yaxis labelpos=top;
run;

/*2f*/
data ip.happy_region_mini;
set ip.happy_region;
if indexw(Region,'Africa') > 0 then SuperRegion = 'Africa';
if indexw(Region,'Asia') > 0 then SuperRegion = 'Asia';
if indexw(Region,'Europe') > 0 then SuperRegion = 'Europe';
if SuperRegion in ('Africa','Asia','Europe');
run;

PROC SGPANEL  DATA = ip.happy_region_mini;
PANELBY SuperRegion;
   HBOX Happiness_score   / category = Region;

   title 'Happiness Score by region';
RUN; 
