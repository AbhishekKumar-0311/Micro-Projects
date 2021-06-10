![alt text](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/happiness2.png?raw=true)
# EDA-Global-Happiness-Index
I have explored, visualised and interpreted global happiness scores over the period 2015—2019.

### Abstract :

The World Happiness Report ranks countries on the perceived happiness of their citizens. The happiness scores are based partly on data from the Gallup World Poll which is a nationally representative annual survey of each country’s population aged 15 and over.
There are five domains of happiness: social support, healthy life expectancy at birth, freedom to make life choices, perceptions of corruption, and generosity. Another strong predictor of happiness is a country’s GDP per capita (Global Domestic Product per one hundred thousand population).
In this study I will explore, visualise and interpret global happiness scores over the period 2015—2019.

### Data Understanding :

The supplied datasets are:
A2B happiness_2015.csv
A2B happiness_2016.csv
A2B happiness_2017.csv
A2B happiness_2018.csv
A2B happiness_2019.csv

Attributes are :-
1. **_Year_** : Year of Survey
2. **_Country_** : Country Name
3. **_Happiness_rank_** : Rankings of the country
4. **_Happiness_score_** : Score
5. **_GDP_per_capita_** : GDP per Capita
6. **_Social_support_** : Family
7. **_Healthy_life_expectancy_** : Expected Healthy Life
8. **_Freedom_to_make_life_choices_** : Freedom and Progressiveness
9. **_Perceptions_of_corruption_** : Trust in Government
10. **_Generosity_** : Metric of Helping Nature


### Problem Solving :

**_0. Data Preparation_**

   a) I have harmonised the variable names since they are named differently in the older datasets (2015—2017) than in the newer ones (2018—2019). For example, the variable ‘Family’ is the same as ‘Social support’.   
![0a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/0a.png)

   b) Also edited some country names. For example, “Macedonia” is now called “North Macedon”. And checked that each country only has one observation per year.

![0b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/0b.png)

![0c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/0c.png)

All the year have almost equal countries and have uniform distribution.

**_1. List the happiness ranks and happiness scores for Australia and the countries that were in the top 5 or the bottom 5 in 2019._**

![1](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/1.png)

**_2. Create graphs for the change in happiness index over time for the two groupings identified in part (a): the top 5 plus Australia and then the bottom 5. Let SAS choose the natural scale for the vertical axis._**

Top 5 countries with Australia

![2a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/2a.png)

Bottom 5 countries

![2b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/2b.png)


**_Now show all 11 countries on the same graph. How do we interpret what these two types of plots are telling us in terms of the scale?_**

All the 11 countries : top 5 , Australia and Bottom 5

![2c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/2c.png)

The top5 countries have higher Happiness score which is consistenstly high while for the bottom 5 the deviation is quite high but consistently remains in the lower side.
Due to this differencec, the series lines have a huge gap among the two groups.

**_3. Create a scatterplot of life expectancy by GDP per capita for the year 2019. How do we interpret the position of Saudi Arabia relative to Hong Kong in the scatterplot?_**

The Life Expectancy as well GDP_per_Capita of Hong-Kong is better than Saudi Arabia.

![3](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/3.png)

**_4. How well does economy (measured in terms of GDP per capita) correlate with the other four measures in the happiness index?_**

Pairplot of other parameters with GDP per Capita

![4](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/4.png)

Heatmap with each parameter

![4b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/4b.png)

![4c](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/4c.png)

![4d](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/4d.png)

![4e](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/4e.png)

**_5. Use the geographical region variable from the 2015 dataset and merge this information into the stacked dataset. Show a frequency table of region by year._**

![5a](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/5a.png)

![5b](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/5b.png)

This is the frequency region by year which shows sub Saharan Africa region have the highest records.

**_6. Create a single plot that shows the distribution of happiness score by region. Only include regions in Asia, Europe, and Africa and make sure the regions appear grouped within these three super regions._**

The Happiness score Middle east and northern Africa is far better than the other parts in Africa.
Similarly, East Asia has much better Happiness Index in Asia and Western Europe in Europe

![6](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/png/6.png)


### Conclusion :

Click [here](https://github.com/AbhishekKumar-0311/Micro-Projects/blob/main/EDA-Global-Happiness-Index/AnalysisResult/AnalysisDocument.docx) to find the analysis of global happiness scores over the period 2015—2019.
