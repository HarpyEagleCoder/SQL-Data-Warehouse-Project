import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns 
import numpy as np


dataset = pd.read_excel("D:\\my personal things\\VS code\\PYTHON PRACTICE\\New Folder Vs code\\Superstore_USA.xlsx")
dataset.shape

dataset.head(2)
dataset.isnull().sum()

dataset['Product Base Margin'].fillna(dataset['Product Base Margin'].mean(),inplace=True)

# order Priority visualization to see the insights
sns.countplot(x="Order Priority", data = dataset)
plt.show()
plt.figure(figsize=(5,3))
plt.title("Count of order Priority")

# now see the Shipmode
dataset['Ship Mode'].value_counts()
x = dataset['Ship Mode'].value_counts().index
y = dataset['Ship Mode'].value_counts().values

plt.figure(figsize=(5,4))
plt.pie(y,labels = x, startangle=60, autopct="%.2f%%")
plt.legend(loc = 2)
plt.show

plt.figure(figsize=(5,4))
sns.countplot(x = 'Ship Mode', data = dataset, hue = 'Product Category')
plt.show()

# Customer Segmentation
plt.figure(figsize=(5,4))
sns.countplot(x = 'Customer Segment', data= dataset)
plt.show()

# Product Category
plt.figure(figsize=(5,4))
sns.countplot(x = 'Product Category', data= dataset)
plt.show()

plt.figure(figsize=(10,6))
sns.countplot(x = 'Product Category', data= dataset[dataset['Product Category']=="Office Supplies"], hue = 'Product Sub-Category')
plt.show()

# time series analysis
dataset['Order year'] = dataset['Order Date'].dt.year
dataset['Order year'].value_counts()

# See profit by product category
sns.barplot(x = 'Product Category', y ='Profit', data = dataset,estimator='sum')
plt.show()
plt.figure(figsize = (6,4))

dataset['State or Province'].value_counts()




























