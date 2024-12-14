/** What is analytic functions in SQL. This is a type of functions thta performs calculations across specified data range
of rows  related to the current rows withing a query result set. This  function are often used in combining with
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
5. The Count() = The Count calculates the total running of the windows count

C. The Offset Functions 
1. The Lag() = The lag assess the value of a column in a previous row
2. The Lead() = The lead assess the value of a column in a subsequent row
3. The First_Value() = Returns the firts value in a partition 
4. The Last_Value() = Returns the last value in a partition 

These are the three characteristics of Analytic functions and are widely being used in advanced reporting and data analytics task
**/
