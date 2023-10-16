CREATE DATABASE project;
CREATE DATABASE employee;

USE project;
USE employee;

-- Query to show some details on all the employees in the table
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

-- Query to select employees with ratings under 2
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING < 2;

-- Query to select employees with ratings above 4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING > 4;

-- Query to select employees with ratings between 2 and 4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING >= 2 AND EMP_RATING <= 4;

-- Query to concatenate the first and last names of employees in the finance department
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'FINANCE';

-- Query to list down employees who have someone reporting to them, and the number of reporters
SELECT DISTINCT t1.* FROM emp_record_table t1
INNER JOIN emp_record_table t2 ON t1.EMP_ID = t2.`MANAGER ID`;

SELECT COUNT(*) AS direct_reports
FROM emp_record_table
GROUP BY `MANAGER ID`;

-- Query to list down all employees rom the healthcare and finance department using union
SELECT * FROM emp_record_table
WHERE DEPT = 'HEALTHCARE'
UNION
SELECT * FROM emp_record_table
WHERE DEPT = 'FINANCE';

-- Query to list employee deatils by department
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING
FROM emp_record_table
ORDER BY DEPT;

-- Query to display maximum employee rating from each department
SELECT DEPT, MAX(EMP_RATING) AS highest_rating
FROM emp_record_table
GROUP BY DEPT;

-- Query to calculate minimum and maximum salary of employees in each role
SELECT ROLE, MIN(SALARY) AS min_salary, MAX(SALARY) AS max_salary
FROM emp_record_table
GROUP BY ROLE;

-- Query to assign ranks to each employee based on experience
SELECT *, RANK() OVER (ORDER BY EXP DESC) AS emp_rank
FROM emp_record_table
ORDER BY EXP DESC;

-- Query that displays employees by country with salaries 6000
SELECT * FROM emp_record_table
WHERE SALARY > 6000
ORDER BY COUNTRY;

-- Query to find employees with experience of more than 10 years
SELECT * FROM emp_record_table
WHERE EXP > 10;

DELIMITER //

-- Stored procedure to retrieve details of employees whose existence is more than 3 years
CREATE PROCEDURE above_three_yrs()
BEGIN
	SELECT * FROM emp_record_table
    WHERE EXP > 3;
END;
//

CALL above_three_yrs();
//

-- Index to improve the cost and performance of the query to find the employee whose first name is "Eric"
CREATE INDEX FN_Eric
ON emp_record_table (FIRST_NAME(255));
//
SELECT * FROM emp_record_table
WHERE FIRST_NAME = 'Eric';
//

-- Query to calculate bonuses for employees, based on formula: 5% of salary * employee rating
SELECT *, (.05*SALARY*EMP_RATING) AS bonus
FROM emp_record_table;
//
-- Query to calculate average salary distriution by continent and country
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS average_salary
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

