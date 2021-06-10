![alt text](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/aus.png?raw=true)
# EDA-Australian-Road-Fatalities
I have analysed the Road Accidents data to answer questions over the Road Fatalities over years.

### Abstract :

Over the last 50 years Australia has implemented a variety of successful interventions for reducing the number of fatalities and serious injuries on our roads including: seatbelts, licensing schemes, and targeted campaigns against drink driving and speeding. Along with safer vehicles and improved roads, these interventions have been shown to be effective1 in reducing road fatalities over time despite our growing population.
National data on fatal crashes on Australian roads are recorded in the Australian Road Deaths Database (ARDD) maintained by the Bureau of Infrastructure and Transport Research Economics (BITRE).
In this study I will investigate data on fatal crashes from January 1989 to October 2020.

### Data Understanding :

- **_A2C road crashes.csv_** : This dataset contains details on the timing, location, and setting of crashes involving at least one fatality
- **_A2C road fatalities.csv_** : This dataset contains basic demographic information on people killed on roads
- **_A2C ARDD data dictionary.pdf_** : This is a data dictionary for the variables in the road crashes and fatalities datasets
- **_A2C ABS population data.xls_** : Quarterly population data for Australian states from June 1981 to March 2020 from the Australian Bureau of Statistics


### Problem Solving :

**_1. Merge the crashes and fatalities datasets. Describe the relationship between these datasets and what checks you need to make to ensure the merge performs correctly._**

Data Profiling of Crash and Fatalities

![1a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/1a.png)

The Crash data has all the unique crashes while fatalities has multiple records per crashes.
Relationship Description
The fatalities dataset has multiple records or casualties for some crashes.
This is going to be One-to-Many relationship. One Crash getting mapped to Multiple casualties.

Make sure there are no duplicates, which i have checked above
Since the attribute crashid has different names in each dataset, it needs to be renamed and both the datasets need to be sorted before merging.

![1b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/1b.png)

![1c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/1c.png)

The merge is implemented correctly.


**_2. Complete the following table with appropriate counts and percentages. Are there any associations between gender and crash factors such as location, timing, type, or vehicle involvement?_**

![2a1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2a1.png)
![2a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2a.png)

We can infer that Males tend to indulge in more Single accident.

![2b1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2b1.png)
![2b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2b.png)

Very few crashes have bus involvement irrespective of gender.

![2c1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2c1.png)
![2c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2c.png)

Heavy truck involvement in crash is less and there are many crashes without this information.
Approximately 2% of accidents involving male is with heavy truck, which is more than female.

![2d1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2d1.png)
![2d](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2d.png)

![2e1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2e1.png)
![2e](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2e.png)

Female tend to have more accidents during Daytime. One of the reason maybe Because Female avoid travelling at Night time. And hence there is a bigger gap between day and night for female in compared to male, who have almost similar rate across day and night.

![2f1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2f1.png)
![2f](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2f.png)

It is observed more crashes happen in weekday as it constitutes 5 days as compared to 2 days of weekends.
Another reason is people tend to stay at home in contrast to the office/work travelling in weekdays.
It applies for both the gender.


![2g](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2g.PNG)

The numbers for first part of the table are obtained from these results by PROC FREQ. and for second part the above charts are used.

![2h](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2h.png)
![2i](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/2i.png)

**_3. Using the provided ABS time series data for the state populations, compare the number of fatalities and fatality rates per capita (deaths per 100,000 persons) by state over time. Are Australian State roads becoming safer according to these statistics? Include appropriate graphs to support your answer._**

![3a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/3a.png)

The Crashes has decreased over time and is clearly visible from this time series graph. But there is a huge drop for New South Whales, Victoria and Queensland, while for other the count has been more of constant.

![3b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/3b.png)

The fatality rate has decreased drastically for NT, while there is a consistent drop for other states also over these years.

These are individual plots of Fatality Rate across states over time and In All the states it has decreased.
![3c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/3c.png)

![3d](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/png/3d.png)

### Conclusion :

Click [here](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Australian-Road-Fatalities/AnalysisResult/AnalysisDocument.docx) to find the analysis of Road Fatalities over years.
