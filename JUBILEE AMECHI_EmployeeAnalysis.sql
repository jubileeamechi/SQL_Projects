-- NAME: JUBILEE AMECHI
-- Employee Salary Analysis and Monthly Revenue Insights Using Window Functions


-- 1. To Create a Temporary Table Storing Total Revenue by Month
CREATE TEMPORARY TABLE monthly_revenue AS (
    SELECT 
        MONTH(o.order_date) AS month, 
        ROUND(SUM(oi.quantity * oi.list_price), 0) AS revenue
    FROM orders o 
    JOIN order_items oi ON o.order_id = oi.order_id 
    GROUP BY MONTH(o.order_date)
);

-- 2. To Retrieve Monthly Revenue with Previous and Next Month Revenue Using Window Functions
SELECT 
    month,
    revenue,
    LAG(revenue, 1, 0) OVER (ORDER BY month) AS previous_month,
    LEAD(revenue, 2, 0) OVER (ORDER BY month) AS next_month
FROM monthly_revenue;

-- 3. To Retrieve Employee Salaries Alongside Their Titles
SELECT * 
FROM salaries s 
JOIN titles t ON s.emp_no = t.emp_no;

-- 4. Average Salary by Gender
SELECT 
    e.gender,
    AVG(s.salary) AS average_salary
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no 
GROUP BY e.gender;

-- 5. To Set Maximum Execution Time for Queries (If Required)
SET SESSION max_execution_time = 30000000000;

-- 6. To Retrieve All Employees Data
SELECT * FROM employees;

-- 7. Compute Salary Difference from Gender-Based Average Using Window Functions
SELECT 
    e.first_name, 
    e.last_name, 
    e.gender, 
    s.salary,
    AVG(s.salary) OVER (PARTITION BY e.gender) AS average_salary,
    (s.salary - AVG(s.salary) OVER (PARTITION BY e.gender)) AS salary_difference
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- 8. Running Total of Salaries Ordered by Salary Amount
SELECT 
    e.first_name, 
    e.last_name, 
    e.gender, 
    s.salary,
    SUM(s.salary) OVER (ORDER BY s.salary) AS running_total
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no;

-- 9. Retrieve Employee Salaries Ordered by Salary
SELECT 
    e.first_name, 
    e.last_name, 
    e.gender, 
    s.salary
FROM employees e 
JOIN salaries s ON e.emp_no = s.emp_no 
ORDER BY s.salary;

-- 10. Rank Employees by Salary Within Their Title Using Window Functions
SELECT 
    e.first_name,
    e.last_name,
    t.title,
    s.salary,
    ROW_NUMBER() OVER (PARTITION BY t.title ORDER BY s.salary DESC) AS rownumber,
    RANK() OVER (PARTITION BY t.title ORDER BY s.salary DESC) AS rankk,
    DENSE_RANK() OVER (PARTITION BY t.title ORDER BY s.salary DESC) AS denserank
FROM employees e 
JOIN titles t ON e.emp_no = t.emp_no
JOIN salaries s ON s.emp_no = t.emp_no;
