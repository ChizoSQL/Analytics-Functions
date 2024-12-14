SELECT *
From Today
Insert into Today
(StudentID, FirstName, LastName, DateofBirth)
Values
(1111, 'Joyce Doe', 'Doe','1939-04-23')
-- Deleting all diplicate record by using a groupby, Having Count and a left join
-- creating a backup table
Drop Table If exists Today
Select *
Into Today
From Today_Backup

-- Deleting all diplicate record by using a groupby, Having Count and a left join
Delete from T
From Today T
Left join 
( 
Select FirstName, LastName, DateOfBirth,
Count (*) as RecordCount
From Today
Group by FirstName, LastName, DateOfBirth
Having count (*) > 1
) as RC
On RC.FirstName = T.FirstName
And RC.LastName = T.LastName
And RC.DateofBirth = T.DateofBirth


With CTE as (
Select  StudentID, FirstName, LastName, DateOfBirth,
Row_Number() 
Over (
Partition by StudentID, FirstName, LastName, DateOfBirth 
Order by (
Select 1) 
) TS
From Today)
Delete from
CTE where Exists  (select 2 From CTE C Where C.FirstName = CTE.FirstName
And C.LastName = CTE.LastName
And C.DateOfBirth = CTE.DateofBirth
And C.StudentID = CTE.StudentID
And TS > 1
)

--using Union 
Select Distinct StudentID, FirstName, LastName, DateOfBirth 
From Today
Union
Select Distinct StudentID, FirstName, LastName, DateOfBirth 
From Today_Backup

Select Distinct StudentID, FirstName, LastName, DateOfBirth 
into NewToday
From Today

 Select *
 From NewToday

 Drop table if Exists Today
 Select *
 Into Today
 From NewToday

