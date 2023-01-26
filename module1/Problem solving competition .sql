-- Problem solving -- 

CREATE DATABASE if not exists Company;
USE Company;

CREATE TABLE if not exists Employees (
    Emp_ID int AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Surname VARCHAR(255) NOT NULL,
    Department VARCHAR(255) NOT NULL,
    Salary Float NOT NULL
);

INSERT INTO Employees (Name, Surname, Department, Salary)
VALUES ('Petey', 'Cruiser', 'IT', 55000), ('Anna', 'Sthesia', 'Marketing', 65000), ('Paul', 'Molive', 'Marketing', 35000),
('Gail', 'Molive', 'Finance', 105000);

-- Write a query to get unique department ID from employee table

SELECT DISTINCT Department FROM Employees;

-- Write a query to get the 2 columns Full name and Taxes  (20% from Salary)


SELECT CONCAT(Name,' ', Surname) as Full_name, (Salary*0.20) as Taxes FROM Employees;

-- Write a query to get the maximum and minimum salary from employees table

SELECT MAX(Salary), MIN(Salary) FROM Employees;

-- Write a query to get the average salary per department

SELECT Department, AVG(Salary) FROM Employees
GROUP BY Department;