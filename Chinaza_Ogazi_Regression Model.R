# load lib
library (DBI)
library (odbc)
library(dplyr)
library(corrplot)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(gridExtra)
library(caTools)
library(GGally)

#connect to SQL database

con <- dbConnect(odbc::odbc(),
                 Driver = "SQL Server",
                 Server = "DESKTOP-G0SHRBK",
                 Database = "HomePrediction",
                 Port = 1433)

#getting a table from a database

dbListTables(con)
dbListFields(con, 'train')

dbListTables(con)
dbListTables(con,'test')

TrainData = collect(tbl(con,'train'))
TestData =collect(tbl(con,'test'))

#read my data
head(TrainData,10)
head(TestData,10)

#structure and summary
str(TrainData)
summary(TrainData)


#slicing off columns to select only numerical columns
df_new = select(TrainData, c(2, 4, 5, 18,19,20,21,27,35,37,38,39,44,45,46,47,48,49,50,51,52,53,55,57,60,62,63,67,68,69,70,71,72,76,77,78,81))
View(df)

#check for the data types


lapply(df_new, class)

#change column datatypes to Numeric datatypes

df_new$MSSubClass = as.numeric(df_new$MSSubClass)
df_new$LotFrontage = as.numeric(df_new$LotFrontage)
df_new$LotArea = as.numeric(df_new$LotArea)
df_new$OverallQual =as.numeric(df_new$OverallQual)
df_new$OverallCond =as.numeric(df_new$OverallCond)
df_new$YearBuilt =as.numeric(df_new$YearBuilt)
df_new$YearRemodAdd =as.numeric(df_new$YearRemodAdd)
df_new$MasVnrArea = as.numeric(df_new$MasVnrArea)
df_new$BsmtFinSF1 = as.numeric(df_new$BsmtFinSF1)
df_new$BsmtFinSF2 = as.numeric(df_new$BsmtFinSF2)
df_new$BsmtUnfSF = as.numeric(df_new$BsmtUnfSF)
df_new$TotalBsmtSF = as.numeric(df_new$TotalBsmtSF)
df_new$`1stFlrSF` = as.numeric(df_new$`1stFlrSF`)
df_new$`2ndFlrSF` = as.numeric(df_new$`2ndFlrSF`)
df_new$LowQualFinSF = as.numeric(df_new$LowQualFinSF)
df_new$GrLivArea = as.numeric(df_new$GrLivArea)
df_new$BsmtFullBath = as.numeric(df_new$BsmtFullBath)
df_new$BsmtHalfBath = as.numeric(df_new$BsmtHalfBath)
df_new$FullBath = as.numeric(df_new$FullBath)
df_new$HalfBath = as.numeric(df_new$HalfBath)
df_new$BedroomAbvGr = as.numeric(df_new$BedroomAbvGr)
df_new$KitchenAbvGr = as.numeric(df_new$KitchenAbvGr)
df_new$TotRmsAbvGrd = as.numeric(df_new$TotRmsAbvGrd)
df_new$Fireplaces = as.numeric(df_new$Fireplaces)
df_new$GarageYrBlt = as.numeric(df_new$GarageYrBlt)
df_new$GarageCars = as.numeric(df_new$GarageCars)
df_new$GarageArea = as.numeric(df_new$GarageArea)
df_new$WoodDeckSF = as.numeric(df_new$WoodDeckSF)
df_new$OpenPorchSF = as.numeric(df_new$OpenPorchSF)
df_new$EnclosedPorch = as.numeric(df_new$EnclosedPorch)
df_new$`3SsnPorch` = as.numeric(df_new$`3SsnPorch`)
df_new$ScreenPorch = as.numeric(df_new$ScreenPorch)
df_new$PoolArea = as.numeric(df_new$PoolArea)
df_new$MiscVal = as.numeric(df_new$MiscVal)
df_new$MoSold = as.numeric(df_new$MoSold)
df_new$YrSold = as.numeric(df_new$YrSold)
df_new$SalePrice = as.numeric(df_new$SalePrice)

summary(df_new)


#change data type for train data
TrainData$MSSubClass = as.numeric(TrainData$MSSubClass)
TrainData$LotFrontage = as.numeric(TrainData$LotFrontage)
TrainData$LotArea = as.numeric(TrainData$LotArea)
TrainData$OverallQual =as.numeric(TrainData$OverallQual)
TrainDataOverallCond =as.numeric(TrainData$OverallCond)
TrainData$YearBuilt =as.numeric(TrainData$YearBuilt)
TrainData$YearRemodAdd =as.numeric(TrainData$YearRemodAdd)
TrainData$MasVnrArea = as.numeric(TrainData$MasVnrArea)
TrainData$BsmtFinSF1 = as.numeric(TrainData$BsmtFinSF1)
TrainData$BsmtFinSF2 = as.numeric(TrainData$BsmtFinSF2)
TrainData$BsmtUnfSF = as.numeric(TrainData$BsmtUnfSF)
TrainData$TotalBsmtSF = as.numeric(TrainData$TotalBsmtSF)
TrainData$`1stFlrSF` = as.numeric(TrainData$`1stFlrSF`)
TrainData$`2ndFlrSF` = as.numeric(TrainData$`2ndFlrSF`)
TrainData$LowQualFinSF = as.numeric(TrainData$LowQualFinSF)
TrainData$GrLivArea = as.numeric(TrainData$GrLivArea)
TrainData$BsmtFullBath = as.numeric(TrainData$BsmtFullBath)
TrainData$BsmtHalfBath = as.numeric(TrainData$BsmtHalfBath)
TrainData$FullBath = as.numeric(TrainData$FullBath)
TrainData$HalfBath = as.numeric(TrainData$HalfBath)
TrainData$BedroomAbvGr = as.numeric(TrainData$BedroomAbvGr)
TrainData$KitchenAbvGr = as.numeric(TrainData$KitchenAbvGr)
TrainData$TotRmsAbvGrd = as.numeric(TrainData$TotRmsAbvGrd)
TrainData$Fireplaces = as.numeric(TrainData$Fireplaces)
TrainData$GarageYrBlt = as.numeric(TrainData$GarageYrBlt)
TrainData$GarageCars = as.numeric(TrainData$GarageCars)
TrainData$GarageArea = as.numeric(TrainData$GarageArea)
TrainData$WoodDeckSF = as.numeric(TrainData$WoodDeckSF)
TrainData$OpenPorchSF = as.numeric(TrainData$OpenPorchSF)
TrainData$EnclosedPorch = as.numeric(TrainData$EnclosedPorch)
TrainData$`3SsnPorch` = as.numeric(TrainData$`3SsnPorch`)
TrainData$ScreenPorch = as.numeric(TrainData$ScreenPorch)
TrainData$PoolArea = as.numeric(TrainData$PoolArea)
TrainData$MiscVal = as.numeric(TrainData$MiscVal)
TrainData$MoSold = as.numeric(TrainData$MoSold)
TrainData$YrSold = as.numeric(TrainData$YrSold)
TrainData$SalePrice = as.numeric(TrainData$SalePrice)

#data validation
lapply(TrainData, class)

TestData$MSSubClass = as.numeric(TestData$MSSubClass)
TestData$LotFrontage = as.numeric(TestData$LotFrontage)
TestData$LotArea = as.numeric(TestData$LotArea)
TestData$OverallQual =as.numeric(TestData$OverallQual)
TestDataOverallCond =as.numeric(TestData$OverallCond)
TestData$YearBuilt =as.numeric(TestData$YearBuilt)
TestData$YearRemodAdd =as.numeric(TestData$YearRemodAdd)
TestData$MasVnrArea = as.numeric(TestData$MasVnrArea)
TestData$BsmtFinSF1 = as.numeric(TestData$BsmtFinSF1)
TestData$BsmtFinSF2 = as.numeric(TestData$BsmtFinSF2)
TestData$BsmtUnfSF = as.numeric(TestData$BsmtUnfSF)
TestData$TotalBsmtSF = as.numeric(TrainData$TotalBsmtSF)
TestData$`1stFlrSF` = as.numeric(TestData$`1stFlrSF`)
TestData$`2ndFlrSF` = as.numeric(TestData$`2ndFlrSF`)
TestData$LowQualFinSF = as.numeric(TestData$LowQualFinSF)
TestData$GrLivArea = as.numeric(TestData$GrLivArea)
TestData$BsmtFullBath = as.numeric(TestData$BsmtFullBath)
TestData$BsmtHalfBath = as.numeric(TestData$BsmtHalfBath)
TestData$FullBath = as.numeric(TestData$FullBath)
TestData$HalfBath = as.numeric(TestData$HalfBath)
TestData$BedroomAbvGr = as.numeric(TestData$BedroomAbvGr)
TestData$KitchenAbvGr = as.numeric(TestData$KitchenAbvGr)
TestData$TotRmsAbvGrd = as.numeric(TestData$TotRmsAbvGrd)
TestData$Fireplaces = as.numeric(TestData$Fireplaces)
TestData$GarageYrBlt = as.numeric(TestData$GarageYrBlt)
TestData$GarageCars = as.numeric(TestData$GarageCars)
TestData$GarageArea = as.numeric(TestData$GarageArea)
TestData$WoodDeckSF = as.numeric(TestData$WoodDeckSF)
TestData$OpenPorchSF = as.numeric(TestData$OpenPorchSF)
TestData$EnclosedPorch = as.numeric(TestData$EnclosedPorch)
TestData$`3SsnPorch` = as.numeric(TestData$`3SsnPorch`)
TestData$ScreenPorch = as.numeric(TestData$ScreenPorch)
TestData$PoolArea = as.numeric(TestData$PoolArea)
TestData$MiscVal = as.numeric(TestData$MiscVal)
TestData$MoSold = as.numeric(TestData$MoSold)
TestData$YrSold = as.numeric(TestData$YrSold)




#check for missing values
colSums(is.na(df_new)) > 0
which(colSums(is.na(df_new)) > 0)
names(which(colSums(is.na(df_new)) > 0))
colSums(is.na(df_new))



#replace the Missing numbers with median
df_new <- df_new %>% 
  mutate_if(is.numeric, function(x) ifelse(is.na(x), median(x, na.rm = T), x))

TrainData <- TrainData %>% 
  mutate_if(is.numeric, function(x) ifelse(is.na(x), median(x, na.rm = T), x))

TestData <- TestData %>% 
  mutate_if(is.numeric, function(x) ifelse(is.na(x), median(x, na.rm = T), x))

#data validation
colSums(is.na(TrainData))
colSums(is.na(TestData))
colSums(is.na(df_new))


#more cleaning, rename columns by their index no

TrainData %>%
  rename(firstfloorsquarefeet = 44,
         secondfloorsquarefeet = 45,
         )

TestData %>%
  rename(firstfloorsquarefeet = 44,
         secondfloorsquarefeet = 45)

df_new %>%
  rename(firstfloorsquarefeet = 10,
         secondfloorsquarefeet = 11)

colnames(TestData)



#EDA

#correlation between numerical variables


cor_data=data.frame(df_new)
correlation=cor(cor_data)
par(mfrow=c(1, 1))
corrplot(correlation,method="color",number.cex = 0.1)


#visualizing the relationship between sales price and some Numeric Variable


p1 = ggplot(data = df_new, aes(x = MSSubClass, y = SalePrice)) +
  geom_jitter() + geom_smooth(method = "lm", se = FALSE) + labs(title = "Scatter plot of MSSubClass and SalesPrice", x ='MSSubClass', y = 'Saleprice')

p2 = ggplot(data = df_new,aes(x = LotArea, y = SalePrice)) +
  geom_jitter() + geom_smooth(method = "lm", se = FALSE ) + labs(title ="Scatter plot of LotArea and SalesPrice", x ="LotArea", y = "Saleprice")

grid.arrange(p1,p2,nrow=2)

 #compute for the multiple reg between salesprice and other num variables

reg =lm(SalePrice~ ., data= df_new)
summary(reg)

#use the step function regression function to select most significant variable for my model
step_reg = step(reg)
summary(step_reg)

#modelling on train data
model=lm(data=TrainData,SalePrice~MSSubClass+LotArea + OverallQual + YearBuilt + BsmtFinSF1 + `1stFlrSF` + `2ndFlrSF` + BsmtFullBath + FullBath + BedroomAbvGr + KitchenAbvGr + Fireplaces + ScreenPorch)  
summary(model)

# fit our Train data in our data  

pred_SalePrice=model$fitted.values

Pred_table=data.frame(actual=TrainData$SalePrice, predicted=pred_SalePrice)

#check for accuracy
mape=mean(abs(Pred_table$actual-Pred_table$predicted)/Pred_table$actual)
accuracy=1-mape
accuracy 
cat("the accuracy is:", accuracy)

prediction =predict(newdata=TestData,model)

summary(prediction)





#merge the predicted Sales Price Values to the Test Data

pred <- cbind(TestData,prediction) # combining results to the test data to prepare for export

write.csv(pred, file = 'pred_table.csv', row.names = FALSE) #Exporting solution as a csv file.



