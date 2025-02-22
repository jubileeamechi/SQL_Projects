-- NAME: JUBILEE AMECHI
-- Joint Query Task

-- 1. Retrieve all employees and their job titles using INNER JOIN
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    t.Title
FROM Employees e
INNER JOIN Titles t ON e.EmployeeID = t.EmployeeID;

-- 2. Retrieve all employees and their job titles, including those without titles (LEFT JOIN)
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    COALESCE(t.Title, 'No Title Assigned') AS JobTitle
FROM Employees e
LEFT JOIN Titles t ON e.EmployeeID = t.EmployeeID;

-- 3. Retrieve all job titles and the employees assigned to them, including titles without employees (RIGHT JOIN)
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    COALESCE(t.Title, 'Unassigned Title') AS JobTitle
FROM Employees e
RIGHT JOIN Titles t ON e.EmployeeID = t.EmployeeID;

-- 4. Retrieve employees and managers by combining Employees and Managers tables using UNION
SELECT 
    EmployeeID, 
    CONCAT(FirstName, ' ', LastName) AS FullName, 
    'Employee' AS Role
FROM Employees
UNION
SELECT 
    ManagerID AS EmployeeID, 
    CONCAT(FirstName, ' ', LastName) AS FullName, 
    'Manager' AS Role
FROM Managers;

-- 5. Retrieve all employees and their department names using INNER JOIN
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    d.DepartmentName
FROM Employees e
INNER JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
INNER JOIN Departments d ON ed.DepartmentID = d.DepartmentID;

-- 6. Retrieve employees from multiple departments using UNION (avoiding duplicates)
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    d.DepartmentName
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT'
UNION
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    d.DepartmentName
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';

-- 7. Retrieve all employees who are either Managers or part of the HR Department using UNION ALL (keeping duplicates)
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    'Manager' AS Position
FROM Employees e
JOIN Titles t ON e.EmployeeID = t.EmployeeID
WHERE t.Title = 'Manager'
UNION ALL
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    'HR Department' AS Position
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';

-- 8. Retrieve employees with missing salaries and combine with those having salaries (UNION)
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    COALESCE(s.Salary, 0) AS Salary
FROM Employees e
LEFT JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.Salary IS NOT NULL
UNION
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    0 AS Salary
FROM Employees e
LEFT JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.Salary IS NULL;

-- 9. Retrieve employees who have changed departments at least once
SELECT 
    e.EmployeeID, 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    COUNT(ed.DepartmentID) AS DepartmentChanges
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
GROUP BY e.EmployeeID
HAVING COUNT(ed.DepartmentID) > 1;

-- 10. Retrieve all employees, their job titles, and department names in a single query using multiple JOINs
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    COALESCE(t.Title, 'No Title Assigned') AS JobTitle, 
    COALESCE(d.DepartmentName, 'No Department Assigned') AS Department
FROM Employees e
LEFT JOIN Titles t ON e.EmployeeID = t.EmployeeID
LEFT JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
LEFT JOIN Departments d ON ed.DepartmentID = d.DepartmentID;

-- 11. Retrieve employees from IT and HR departments using UNION
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    d.DepartmentName
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT'
UNION
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    d.DepartmentName
FROM Employees e
JOIN Employee_Department ed ON e.EmployeeID = ed.EmployeeID
JOIN Departments d ON ed.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR';

-- 12. Retrieve top 3 highest-paid employees along with top 3 longest-serving employees 
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    s.Salary, 
    'Highest Salary' AS Category
FROM Employees e
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
ORDER BY s.Salary DESC
LIMIT 3;
 
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName, 
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS YearsWorked, 
    'Longest Serving' AS Category
FROM Employees e
ORDER BY YearsWorked DESC
LIMIT 3;
