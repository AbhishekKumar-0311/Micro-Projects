# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.6.0
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---



# +
# To get multiple outputs in the same cell

from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = "all"

# +
# Supress Warnings

import warnings
warnings.filterwarnings('ignore')

# +
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# %matplotlib inline

# +
# Set the required global options

# To display all the columns in dataframe
pd.set_option( "display.max_columns", None)
# -

# #### fn to read and merge dfs
# import os
# root_folder = "co2_prediction/"
#
# def read_and_merge_files(root_folder, year="2010"):
#     dfs = []
#     for subdir, dirs, files in os.walk(root_folder):
#         for file in files:
#             filename = file.split(".")[0]
#             df = pd.read_csv(root_folder+str(file))
#             # include only datasets having more than 50 countries' data
#             if year in df.columns and df.shape[0] > 50: 
#                 df = df[["geo", year]]
#                 df.columns = ["geo", filename]
#                 dfs.append(df)
#     
#     # merge all files using the key 'geo'
#     master_df = dfs[0]
#     for i in range(len(dfs)-1):
#         master_df = pd.merge(master_df, dfs[i+1], how="inner", 
#                              left_on="geo", right_on="geo")
#     return master_df

# master_df = read_and_merge_files(root_folder, year="2014")
# master_df.head()

# master_df.shape





# ### Fetching all the csv files in the directory

from os import listdir
from os.path import isfile, join
mypath = './co2_prediction'
onlyfiles = [f for f in listdir(mypath) if isfile(join(mypath, f)) & f.endswith('.csv')]
onlyfiles
fnm = [f[:-4] for f in onlyfiles]
fnm
len(fnm)

# ### Iterating through the list of files to read and merge

# +
co2_indicator = None
year = '2014'
for j,i in enumerate(onlyfiles):
    df = pd.read_csv(join(mypath, i))
    if year in df.columns and df.shape[0] > 50:
        #print('yes')
        fnm[j] = df[['geo',year]].rename(columns={year:i[:-4]})
        #fnm[j]
        if co2_indicator is None:
            co2_indicator = fnm[j].copy()
        else:
            co2_indicator = co2_indicator.merge(fnm[j],on='geo',how='inner')             
    else:
        #print('no')
        pass

#co2_indicator

# +
#co2_indicator
# -

co2_indicator.shape

co2_indicator.info()

# +
co2_indicator.isnull().sum()

# co2_indicator.isnull().sum().any()
# -

co2_indicator.describe()

geo = co2_indicator.pop('geo')

co2_indicator

# +
# co2_indicator.corr()

sns.pairplot(co2_indicator)
# -

# - The pairplot looks very messy and does not provide clear details.
# - We will plot heatmap to get correlation values.

plt.figure(figsize=(12,8));
sns.heatmap(co2_indicator.corr(), annot = True);

# - CO2 emissions are faily correlated with 
#     - oil consumption
#     - industry percent
#     - income per capita
#     - electricity use per capita
#     - electricity generation



# ## Linear Regression

# ### Splitting train and test set

# +
from sklearn.model_selection import train_test_split

co2_train, co2_test = train_test_split(co2_indicator, train_size=0.75, test_size=0.25, random_state=100)
# -

co2_train.shape
co2_test.shape

# ### Scaling the features
#
# Machine learning algorithm just sees number — if there is a vast difference in the range say few ranging in thousands and few ranging in the tens, and it makes the underlying assumption that higher ranging numbers have superiority of some sort. So these more significant number starts playing a more decisive role while training the model.

# +
# Aplying StandardScaler Scaler

from sklearn.preprocessing import StandardScaler

# Creating scaler object
scaler = StandardScaler()
# -

co2_train[co2_train.columns] = scaler.fit_transform(co2_train[co2_train.columns])

# ### Splitting X (predictor) and y (target) in train set

y_train = co2_train.pop('co2_emissions_tonnes_per_person')
y_train.shape
X_train = co2_train
X_train.shape

co2_train.head()

# ### Model Building

# +
# Importing LinearRegression and RFE

from sklearn.linear_model import LinearRegression
from sklearn.feature_selection import RFE
# -

# cReating the linear regression object
lr = LinearRegression()

lr.fit(X_train, y_train)

lr.intercept_
lr.coef_

# ### The Model Parameters - All the Features

# +
# list(zip(X_train.columns,lr.coef_))

# model_parameters
model_parameters = list(lr.coef_)
model_parameters.insert(0, lr.intercept_)

# model coefficients
cols = X_train.columns
cols = cols.insert(0, "constant")
list(zip(cols, model_parameters))
# -

# ### Predict the training set

pred_train = lr.predict(X_train)

# ### Model Evaluation

from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score


#     # Root Mean Squared Error  
#     rmse = np.sqrt(mean_squared_error(y_train,pred_train))
#     rmse
#     
#     # R2 score   
#     r2 = r2_score(y_train,pred_train)
#     r2
#     
#     # Adjusted R2 score   
#     adj_r2 = 1-((1-r2)*((len(X_train)-1)/(len(X_train)-(X_train.shape[1])-1)))
#     adj_r2

# +
# User defined function for RMSE, R2 and Adj R2 score

def evaluate(act_X,act_y,pred):
    # Root Mean Squared Error
    
    rmse = np.sqrt(mean_squared_error(act_y,pred))
    print('RMSE is  ', rmse)
    
    # R2 score
    
    r2 = r2_score(act_y,pred)
    print('R2 is    ', r2)
    
    # Adjusted R2 score
    
    adj_r2 = 1-((1-r2)*((len(act_X)-1)/(len(act_X)-(act_X.shape[1])-1)))
    print('Adj R2 is ', adj_r2)
    


# -

evaluate(X_train,y_train,pred_train)

# ### Processing the test set

# +
# Scaling the test set - only Transform

co2_test[co2_test.columns] = scaler.transform(co2_test[co2_test.columns])

# +
# Splitting the X and y variables

y_test = co2_test.pop('co2_emissions_tonnes_per_person')
y_test.shape
X_test = co2_test
X_test.shape

# +
# X_test
# -

# ### Predict the test set

pred_test = lr.predict(X_test)

# ### Evaluating the model

r2_score(y_true=y_test, y_pred=pred_test)

evaluate(X_test,y_test,pred_test)

# Plotting y_test and y_pred to understand the spread.
plt.figure(figsize=(8,5))
sns.scatterplot(x = y_train, y = pred_train, color='#d62728')
plt.title('y_train vs pred_train', fontsize=25, pad = 25)              # Plot heading 
plt.xlabel('y_train', fontsize=16)                          # X-label
plt.ylabel('pred_train', fontsize=16);   

# Plotting y_test and y_pred to understand the spread.
plt.figure(figsize=(8,5))
sns.scatterplot(x = y_test, y = pred_test, color='#d62728')
plt.title('y_test vs pred_test', fontsize=25, pad = 25)              # Plot heading 
plt.xlabel('y_test', fontsize=16)                          # X-label
plt.ylabel('pred_test', fontsize=16);      

# +
# Calculating the residuals
residuals = (y_train - pred_train)

# Visualizing the residuals and predicted value on train set
# plt.figure(figsize=(25,12))
sns.jointplot(x = pred_train, y = residuals, kind='reg', color='#d62728')
plt.title('Residuals of Linear Regression Model', fontsize = 20, pad = 100) # Plot heading 
plt.xlabel('Predicted Value', fontsize = 12)                     # X-label
plt.ylabel('Residuals', fontsize = 12);   

# +
# Calculating the residuals
residuals = (y_test - pred_test)

# Visualizing the residuals and predicted value on train set
# plt.figure(figsize=(25,12))
sns.jointplot(x = pred_test, y = residuals, kind='reg', color='#d62728')
plt.title('Residuals of Linear Regression Model', fontsize = 20, pad = 100) # Plot heading 
plt.xlabel('Predicted Value', fontsize = 12)                     # X-label
plt.ylabel('Residuals', fontsize = 12);   
# -



# ### RECURSIVE FEATURE ELIMINATION -  RFE Method

# +
# Running RFE

# Create the RFE object
rfe = RFE(lr, n_features_to_select = 5)

rfe = rfe.fit(X_train, y_train)

# +
# Features with rfe.support_ values

list(zip(X_train.columns,rfe.support_,rfe.ranking_))

# +
# Creating a list of rfe supported features
feats = X_train.columns[rfe.support_]
feats

# Creating a list of non-supported rfe features
drop_feats = X_train.columns[~rfe.support_]
drop_feats
# -

# Creating a dataframe with only important features, ranked by RFE method
X_train_2 = X_train[feats]


lr.fit(X_train_2,y_train)

pred_train = lr.predict(X_train_2)

evaluate(X_train_2,y_train,pred_train)

# ### Processing the test set

X_test_2 = X_test[feats]

pred_test = lr.predict(X_test_2)

evaluate(X_test_2,y_test,pred_test)

# ### The Model Parameters - RFE Method

# +
# list(zip(X_train.columns,lr.coef_))

# model_parameters
model_parameters = list(lr.coef_)
model_parameters.insert(0, lr.intercept_)

# model coefficients
cols = X_train_2.columns
cols = cols.insert(0, "constant")
list(zip(cols, model_parameters))
# -
# ## Lasso - Regularized Linear Regression



