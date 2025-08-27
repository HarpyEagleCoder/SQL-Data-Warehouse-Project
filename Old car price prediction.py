# Importing Libraries
import pandas as pd
import seaborn as sns 
import matplotlib.pyplot as plt
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression, Ridge, Lasso, ElasticNet
from sklearn.tree import DecisionTreeRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error
# Lets Look at the dataset
df = pd.read_csv("old car data.csv")
df.head(2)

# Lets make data preprocessing steps
df.isnull().sum()
df.info()
# Encoding features
Car_Name_Le = LabelEncoder()
df['Car_Name'] = Car_Name_Le.fit_transform(df['Car_Name'])
df['Car_Name']
# Fuel Type Encoded label
df['Fuel_Type'].unique()
Fuel_Type_Le = LabelEncoder()
df['Fuel_Type'] = Fuel_Type_Le.fit_transform(df['Fuel_Type'])
df['Fuel_Type']
# Seller_Type
Seller_Type_Le = LabelEncoder()
df['Seller_Type'] = Seller_Type_Le.fit_transform(df['Seller_Type'])
df['Seller_Type']
# Label encoding to Transmission Column
Transmission_Le = LabelEncoder()
df['Transmission'] = Seller_Type_Le.fit_transform(df['Transmission'])
df['Transmission']
# Lets create input data and output data
input_data = df.iloc[:,:-1]
output_data = df['Selling_Price']
# Standard scaller
ss = StandardScaler()
input_data = pd.DataFrame(ss.fit_transform(input_data),columns = input_data.columns)
# Now checking the Linearity between input and output features
sns.heatmap(data=df.corr(),annot=True)
plt.show()
# test and training data
x_train,x_test,y_train,y_test = train_test_split(input_data,output_data,test_size=0.2,random_state=42)

# Lets check acccuracy of test and training features by evaluating every models
lr = LinearRegression()
lr.fit(x_train,y_train)
lr.score(x_train,y_train)*100 , lr.score(x_test,y_test)*100

dt = DecisionTreeRegressor(max_depth=13)
dt.fit(x_train,y_train)
dt.score(x_train,y_train)*100 , dt.score(x_test,y_test)*100

rf = RandomForestRegressor()
rf.fit(x_train,y_train)
rf.score(x_train,y_train)*100 , rf.score(x_test,y_test)*100

mean_squared_error(y_test, dt.predict(x_test)), mean_absolute_error(y_test, dt.predict(x_test))

mean_squared_error(y_test, rf.predict(x_test)), mean_absolute_error(y_test, rf.predict(x_test))

rf.predict([[-1.275759,0.821718,-0.849623,-0.817924,-0.333500,0.500183,1.356327,-2.554408]])
y_test

