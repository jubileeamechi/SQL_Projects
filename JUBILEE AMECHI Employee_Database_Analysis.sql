-- NAME: JUBILEE AMECHI
-- Employee Database Task


-- 1. Creating the CompanyDB database
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- 2. Creating the Employees table
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    JobTitle VARCHAR(50),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

-- 3. Creating additional related tables
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    Salary DECIMAL(10, 2),
    FromDate DATE,
    ToDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- 4. Adding a Department column to the Employees table
ALTER TABLE Employees
ADD DepartmentID INT,
ADD FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID);

-- 5. Inserting departments
INSERT INTO Departments (DepartmentName) VALUES 
('IT'),
('Human Resources'),
('Marketing'),
('Finance');

-- 6. Inserting employee records into the Employees table
INSERT INTO Employees (FirstName, LastName, JobTitle, Salary, HireDate, DepartmentID)
VALUES 
('John', 'Doe', 'Software Engineer', 75000.00, '2020-06-15', 1),
('Jane', 'Smith', 'HR Manager', 60000.00, '2018-03-22', 2),
('Alice', 'White', 'Marketing Lead', 65000.00, '2021-11-05', 3);

-- 7. Inserting salary records
INSERT INTO Salaries (EmployeeID, Salary, FromDate, ToDate)
VALUES 
(1, 75000.00, '2020-06-15', NULL),
(2, 60000.00, '2018-03-22', NULL),
(3, 65000.00, '2021-11-05', NULL);

-- 8. Retrieve all employee records
SELECT * FROM Employees;

-- 9. Retrieve employee first name, last name, job title, and hire date
SELECT FirstName, LastName, JobTitle, HireDate FROM Employees;

-- 10. Retrieve all department names
SELECT * FROM Departments;

-- 11. Retrieve a list of employees and their salary details
SELECT e.EmployeeID, e.FirstName, e.LastName, e.JobTitle, s.Salary, s.FromDate 
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- 12. Increase salary by 10% for all employees in the IT department
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'IT');

-- 13. Retrieve updated salary information
SELECT FirstName, LastName, JobTitle, Salary FROM Employees;

-- 14. Remove an employee with the job title "HR Manager"
DELETE FROM Employees
WHERE JobTitle = 'HR Manager';

-- 15. Drop the Salaries table
DROP TABLE Salaries;

-- 16. Drop the Employees table
DROP TABLE Employees;

-- 17. Drop the Departments table
DROP TABLE Departments;

-- 18. Drop the CompanyDB database
DROP DATABASE CompanyDB;
