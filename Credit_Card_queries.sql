CREATE TABLE cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),

	-- 2. Create cust_detail table

CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

Select * from cc_detail
Select * from cust_detail

---- Total Customers

SELECT COUNT(*) AS Total_Customers
FROM cust_detail;

--- Male vs Female Customers

SELECT Gender,
COUNT(*) AS Total_Customers
FROM cust_detail
GROUP BY Gender;

---- Customers by Education Level

SELECT Education_Level,
COUNT(*) AS Total_Customers
FROM cust_detail
GROUP BY Education_Level
ORDER BY Total_Customers DESC;


---- Customers by Marital Status

SELECT Marital_Status,
COUNT(*) AS Total_Customers
FROM cust_detail
GROUP BY Marital_Status;

---- Average Income by Job

SELECT Customer_Job,
AVG(Income) AS Avg_Income
FROM cust_detail
GROUP BY Customer_Job
ORDER BY Avg_Income DESC;


---- Card Category Distribution

SELECT Card_Category,
COUNT(*) AS Total_Cards
FROM cc_detail
GROUP BY Card_Category;


---- Total Transaction Amount

SELECT SUM(Total_Trans_Amt) AS Total_Transaction
FROM cc_detail;

----- Average Credit Limit

SELECT AVG(Credit_Limit) AS Avg_Credit_Limit
FROM cc_detail;

----- Total Interest Earned by Card Type

SELECT Card_Category,
SUM(Interest_Earned) AS Total_Interest
FROM cc_detail
GROUP BY Card_Category
ORDER BY Total_Interest DESC;


---- Average Utilization Ratio

SELECT AVG(Avg_Utilization_Ratio) AS Avg_Utilization
FROM cc_detail;

---- Customer + Card Information

SELECT
c.Client_Num,
c.Gender,
c.Customer_Age,
c.Income,
cc.Card_Category,
cc.Credit_Limit,
cc.Total_Trans_Amt
FROM cust_detail c
INNER JOIN cc_detail cc
ON c.Client_Num = cc.Client_Num;

--- Total Transaction by Gender

SELECT
c.Gender,
SUM(cc.Total_Trans_Amt) AS Total_Transaction
FROM cust_detail c
INNER JOIN cc_detail cc
ON c.Client_Num = cc.Client_Num
GROUP BY c.Gender;

--- Average Credit Limit by Education

SELECT
c.Education_Level,
AVG(cc.Credit_Limit) AS Avg_Credit_Limit
FROM cust_detail c
INNER JOIN cc_detail cc
ON c.Client_Num = cc.Client_Num
GROUP BY c.Education_Level
ORDER BY Avg_Credit_Limit DESC;

---- Top 10 Customers by Transaction Amount

SELECT
c.Client_Num,
c.Customer_Age,
c.Gender,
cc.Total_Trans_Amt
FROM cust_detail c
INNER JOIN cc_detail cc
ON c.Client_Num = cc.Client_Num
ORDER BY cc.Total_Trans_Amt DESC
LIMIT 10;

--- Delinquent Customers 

SELECT
c.Client_Num,
c.Gender,
cc.Delinquent_Acc
FROM cust_detail c
INNER JOIN cc_detail cc
ON c.Client_Num = cc.Client_Num
WHERE cc.Delinquent_Acc = 'Yes';

