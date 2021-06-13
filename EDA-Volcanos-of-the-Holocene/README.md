![alt text](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/volcano.jpg?raw=true)
# EDA-Volcanoes-of-the-Holocene
The Exploratory Data Analysis is performed to understand the volcanoes that have erupted in the last 10,000 years.

### Abstract :

The Global Volcanism Program (GVP) at the Smithsonian Institution maintains documentation on global volcanic activity. We will use the GVP’s database that catalogues volcanoes that have erupted in the last 10,000 years.

### Data Understanding :

1. **_Number_** :
2. **_Name_** :
3. **_Country_** :
4. **_Region_** :
5. **_Type_** :
6. **_Activity Evidence_** :
7. **_Last_Known_Eruption_** :
8. **_Latitude_** :
9. **_Longitude_** :
10. **_Elevation_** :
11. **_Rock_Type_** :
12. **_Tectonic_Setting_** :


### Problem Solving :

**_1. Mount Vesuvius is a stratovolcano located in Italy that has erupted dozens of times. Does this dataset contain a list of all eruptions in the Holocene epoch and how do you know?_**

No, it does not contain all 12 records. There is only one record for it.

![1a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/1a.png)
![1b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/1b.png)

**_2. Examine the variables Latitude, Longitude, Elevation, and Last Eruption Date and comment on whether there are any range errors or missing data._**

There is no null in s Latitude, Longitude, Elevation, shown by NullPct

![2a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/2a.png)

But Last Known Eruption has many missing values which are represented by ‘Unknown’. This is cleaned at a later stage.

![2b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/2b.png)

**_3. Create a numeric variable for last eruption date with negative values for BCE dates and positive values for CE dates. Show your code._**

![3](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/3.png)

**_4. Examine the frequency distribution of the numeric date variable that you created in 3._**

We can observe that over each bin as we move towards present, the Volcanic Eruptions is on a rise. Here the Number of bins is 20.

![4](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/4.png)

**_5. Categorise the variable tectonic setting into two new variables:_**
  - **_Platetype: Intraplate, Rift zone, Subduction zone_**
  - **_Crusttype: Continental crust, Intermediate crust, Ocean crust_**

**_The new variables to be coded numeric variables with custom formats applied. Show the frequency tables._**

The most common type is ‘Subduction Zone Platetype with Continental Crust”

![5](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/5.png)

**_What are the most common types of tectonic setting for volcanic eruptions?_**

![5b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/5b.png)

**_6. Use an appropriate graph to show the frequency of tectonic settings (crust type and plate type)._**

![6](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/6.png)

**_7. Describe the distribution of elevation with appropriate summary statistics and a histogram._**

![7a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/7a.png)

![7b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/7b.png)

We can observe the majority of volcanic eruption is in Interquartile range with values between 686 and 2500 m.

**_8. Compare the distribution of elevation by plate type with summary statistics and a boxplot. Is there a difference in elevation by plate type?_**

The subduction zone has high number of Volcanoes with high Elevations.

![8a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/8a.png)

![8b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/8b.png)

We can clearly see, the number of volacoes with Platetype = 3 is very high with maximum elevation.

**_9. Inter-plate earthquakes are responsible for around 90% of the total seismic energy produced globally each year. Is our data consistent with this value? Why/why not?_**

![9](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/png/9.png)

Inter-plate earthquakes are responsible for around 90% of the total seismic energy produced globally each year.
This is clearly visible with the chart above. And hence our data is consistent with the analysis.

### Conclusion :

Click [here](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Volcanos-of-the-Holocene/AnalysisResult/AnalysisDocument.docx) to find the analysis of the volcanoes.
