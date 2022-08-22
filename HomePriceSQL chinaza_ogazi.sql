---Create Database "HomePrediction"
CREATE DATABASE HomePrediction;

----Use already created Database

USE HomePrediction;

------Get the timeframe the year and month of house sales


SELECT MIN(MoSold) AS min_monthsold
      ,MIN(YrSold) AS min_yearsold
	  ,MAX(MoSold) AS max_monthsold
	  ,MAX(YrSold) AS max_yearsold

FROM [dbo].[train];

---create a  view representing the house location and sales 
CREATE VIEW house_location_sales AS
SELECT Id
	  ,Mosold
	  ,YrSold
	  ,Neighborhood AS location
	  ,HouseStyle  AS [House Types]
	  ,BedroomAbvGr AS Bedroom_no
	  ,SaleType
	  ,SaleCondition
	  ,SalePrice

FROM [dbo].[train];


	
----create a view representing the house features
CREATE VIEW house_features AS
SELECT Id
	   ,SaleType
	   ,OverallCond
	   ,LotArea
	   
FROM [dbo].[train];

-----create a view on house_construction details
CREATE VIEW house_construction AS 
SELECT Id
	   ,YrSold
	   ,YearBuilt AS Yr_built
	   ,YearRemodAdd AS Yr_renovated
	   ,Foundation AS Foundation_type

FROM [dbo].[train]


