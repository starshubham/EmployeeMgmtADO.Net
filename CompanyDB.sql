Create database CompanyDB;

Create table Employee
(
EmpId int not null,
ENAME varchar(50),
JOB varchar(20),
);
Select * from Employee;
Insert into Employee (EmpId,ENAME,JOB) VALUES
('1', 'Shubham', 'Student'),
('2', 'Terisa', 'Tech');

Create table Salary
(
SALARYId int not null,
SAL_MONTH varchar(20),
EMPSAL money,
EmpId int,
);
Select * from Salary;
Insert into Salary (SALARYId,SAL_MONTH,EMPSAL,EmpId) VALUES
('1', 'Dec', 300000.00, 1),
('2', 'Jan', 400000.00, 2);

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateEmployeeSalary]
	--Add the parameters for the stored procedure here
	@id int,
	@month varchar(20),
	@salary int,
	@EmpId int
AS 
BEGIN
--SET XACT_ABORT ON will cause the transaction to be uncommittable
-- when the constraint violation occurs.
SET XACT_ABORT ON;
BEGIN TRY
BEGIN TRANSACTION;
	Update SALARY

	set EMPSAL = @salary
	where SALARYId = @id and SAL_MONTH = @month and EmpId = @EmpId;
	select e.EmpId,e.ENAME,e.JOB,s.EMPSAL,s.SAL_MONTH,s.SALARYId
	from Employee e inner join SALARY s
	ON e.EmpId = s.EmpId where s.SALARYId = @id;
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
select ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
IF (XACT_STATE()) = -1
	BEGIN
		PRINT N'The transaction is in an uncommittable state.' + 'Rolling back transaction.'
		ROLLBACK TRANSACTION;
	END;
	--Test whether the transaction is committable.
	--You may want to commit a transaction in a catch block if you want to commit changes
	--to statements that ran prior to the error.
IF (XACT_STATE()) = 1
	BEGIN
		PRINT
			N'The transaction is committable.' + 'Committing transaction.'
		COMMIT TRANSACTION;
	END;
END CATCH
END
