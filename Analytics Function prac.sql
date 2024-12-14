/** What is analytic functions in SQL. This is a type of functions thta performs calculations across specified data range
of rows  related to the current rows within a query result set. This functions are often used in combining with
the OVER() clause, which defines partitions and ordering of the data. 
Note: the partition and the OVER, you can partition the data into a subset like grouping and order the rows for the most broken 
detailed specified component (Granular control).

The common analytic function are
A. The Ranking Function includes:
1. The Row_Number () = A row number is used to assign a unique number to each row based on a specified order
2. Rank() = A Rank assigns a Rank to each row, with gaps if they are the same or ties 
3. Dense_Rank() = A Dense Rank works like a Rank but without gaps incase of same record or ties 

B. we have the window aggregate function 
1. The Sum() = The sum calculates the total running of the windows sum
2. The Min() = The min calculates the total running of the windows min
3. The Max() = The max calculates the total running of the windows max
4. The Avg() = The Avg calculates the total running of the windows avg


C. The Offset Functions 
1. The Lag() = The lag assess the value of a column in a previous row
2. The Lead() = The lead assess the value of a column in a subsequent row
3. The First_Value() = Returns the firts value in a partition 
4. The Last_Value() = Returns the last value in a partition 

These are the three characteristics of Analytic functions and are widely being used in advanced reporting and data analytics task
**/

CREATE TABLE Sales (
    SaleID INT,
    EmployeeID INT,
    DepartmentID INT,
    SaleAmount DECIMAL(10, 2),
    SaleDate DATE
);

INSERT INTO Sales VALUES
(1, 101, 1, 500.00, '2024-01-01'),
(2, 102, 1, 300.00, '2024-01-02'),
(3, 103, 2, 700.00, '2024-01-03'),
(4, 101, 1, 200.00, '2024-01-04'),
(5, 102, 1, 400.00, '2024-01-05'),
(6, 103, 2, 800.00, '2024-01-06'),
(7, 101, 1, 600.00, '2024-01-07'),
(8, 102, 1, 500.00, '2024-01-08');

Select *
From Sales

-- How to assign a unique number to each sale within a department. Order by sale amount descending. 
--It enables you to keep a specific criteria based on first occurance

--RowNumber/Rank/Dense Rank
Select
SaleID, EmployeeID, DepartmentID, SaleAmount, 
ROW_NUMBER() OVER (Partition by DepartmentID Order by SaleAmount desc) as RowNumber, --RowNumber
Rank() Over (Partition by DepartmentID Order by SaleAmount desc) as RankNumber, -- Rank
DENSE_RANK() Over (Partition by DepartmentID Order by SaleAmount desc) as DenseRank -- Dense Rank
From Sales

Select
SaleID, EmployeeID, DepartmentID, SaleAmount, 
ROW_NUMBER() OVER (Partition by DepartmentID, EmployeeID Order by SaleAmount desc) as RowNumber --RowNumber
--Rank() Over (Partition by DepartmentID Order by SaleAmount desc) as RankNumber, -- Rank
--DENSE_RANK() Over (Partition by DepartmentID Order by SaleAmount desc) as DenseRank -- Dense Rank
From Sales 

--Over Partition by clause is dividing the data into each group. RowNumber assigns numbers by increment of 1
--Finding the Highest sales in each department

Select*
From (
Select
SaleID, EmployeeID, DepartmentID, SaleAmount, 
ROW_NUMBER() OVER (Partition by DepartmentID Order by SaleAmount desc) as RowNumber --RowNumber
--Rank() Over (Partition by DepartmentID Order by SaleAmount desc) as RankNumber -- Rank
From Sales
) as TopRankSales 
Where RowNumber = 1

--Find the second rank sales in each department
Select*
From (
Select
SaleID, EmployeeID, DepartmentID, SaleAmount, 
--ROW_NUMBER() OVER (Partition by DepartmentID Order by SaleAmount desc) as RowNumber --RowNumber
Rank() Over (Partition by DepartmentID Order by SaleAmount desc) as RankNumber -- Rank
From Sales
) as SecondRankSales 
Where RankNumber = 2

--To close the gaps in the sequence irrespective of their duplicates 
Select*
From (
Select
SaleID, EmployeeID, DepartmentID, SaleAmount, 
--ROW_NUMBER() OVER (Partition by DepartmentID Order by SaleAmount desc) as RowNumber --RowNumber
Dense_Rank() Over (Partition by DepartmentID Order by SaleAmount desc) as DenseRankNumber -- Rank
From Sales
) as Top3Sales 
Where DenseRankNumber <= 3

--Total sum of sales for each department- We will run this by salesID which captures the information of all sales transactions
--Criteria for Order will be SalesID

Select
SaleID, DepartmentID, SaleAmount, 
Sum(saleAmount) Over (Partition by DepartmentID order by SaleID) as SumOfTotalSales 
From Sales

Select
SaleID, DepartmentID, SaleAmount, 
ROW_NUMBER() Over (Partition by DepartmentID order by SaleID) as SumOfTotalSales 
From Sales

/** SalesID 1 = Group1 = 500
SalesID 2 = 300 + 500 = 800
SalesID 4 =200 + 800 = 1000
SalesID 5 = 400 +1000 = 1400
SalesID 7 = 600 + 1400 = 2000
SalesID 8 = 500 + 2000 = 2500
SalesID 3 = Group2 = 700 
SalesID 6 = 800 + 700 = 1500 

We use this type of query to track cumulative metrics total sales across group of region or departments 