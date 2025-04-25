use Bank;

SELECT * FROM DC;



#========1-Total Credit Amount:========#
ALTER TABLE DC CHANGE COLUMN`Customer ID` Customer_ID varchar(100);
ALTER TABLE DC CHANGE COLUMN`Transaction Type` Transaction_Type varchar(30);


SELECT SUM(Amount) AS Total_Credit_Amount
FROM DC
WHERE Transaction_Type = 'Credit';


#============ 2-Total Debit Amount:========#
SELECT SUM(Amount) AS Total_Debit_Amount
FROM dc
WHERE Transaction_Type = 'Debit';





#==================3-Credit to Debit Ratio:========#
SELECT 
  (SELECT SUM(Amount) FROM dc WHERE Transaction_Type = 'Credit') /
  (SELECT SUM(Amount) FROM dc  WHERE Transaction_Type = 'Debit') 
  AS Credit_to_Debit_Ratio;
  
  
  
  
  
  #============ 4-Net Transaction Amount:======#
  SELECT 
  (SUM(CASE WHEN Transaction_Type = 'Credit' THEN Amount ELSE 0 END) -
   SUM(CASE WHEN Transaction_Type = 'Debit' THEN Amount ELSE 0 END)) 
   AS Net_Transaction_Amount
FROM dc ;



#============ 5-Account Activity Ratio:=========#

SELECT 
  COUNT(*) * 1.0 / COUNT(DISTINCT Account_Number) AS Account_Activity_Ratio
FROM dc;




#=============6-Transactions per Day/Week/Month ==========#

SELECT 
  Transaction_Date AS Day,
  COUNT(*) AS Transactions_Per_Day
FROM dc
GROUP BY Transaction_Date
ORDER BY Day;


SELECT 
  YEAR(Transaction_Date) AS Year,
  WEEK(Transaction_Date) AS Week,
  COUNT(*) AS Transactions_Per_Week
FROM dc
GROUP BY YEAR(Transaction_Date), WEEK(Transaction_Date)
ORDER BY Year, Week;




SELECT 
  YEAR(Transaction_Date) AS Year,
  MONTH(Transaction_Date) AS Month,
  COUNT(*) AS Transactions_Per_Month
FROM dc
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date)
ORDER BY Year, Month;





#============= 7-Total Transaction Amount by Branch =======#
SELECT 
  Branch,
  SUM(Amount) AS Total_Transaction_Amount
FROM dc
GROUP BY Branch
ORDER BY Total_Transaction_Amount DESC;





