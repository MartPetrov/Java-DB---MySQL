#P01 Count Employees by Town
DELIMITER !!!
CREATE FUNCTION ufn_count_employees_by_town(cityname VARCHAR(100))
RETURNS INT
DETERMINISTIC

BEGIN
RETURN (SELECT count(*) as 'count' FROM employees AS e
LEFT JOIN addresses as a USING (`address_id`)
LEFT JOIN towns as t USING(`town_id`)
WHERE t.name = cityname);
END
!!!
DELIMITER ;
SELECT ufn_count_employees_by_town('Sofia');


#P02 Employees Promotion
DELIMITER !!!
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
UPDATE employees as e  
RIGHT JOIN departments as d USING (department_id)
SET salary = salary * 1.05
WHERE d.name = department_name;
END 
!!!
CALL usp_raise_salaries('Finance');
DELIMITER ;

SELECT first_name,salary FROM employees
WHERE department_id = 10
ORDER BY first_name,salary;

#P03 Employees Promotion by ID 
DELIMITER !!!
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
START TRANSACTION;
UPDATE employees AS e 
SET 
    salary = salary * 1.05
WHERE
    id = e.employee_id;
COMMIT;
END 
!!!
DELIMITER ;

SELECT salary FROM employees
WHERE employee_id = 17;
CALL usp_raise_salary_by_id(17);

#P04 Triggered
CREATE TABLE deleted_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(19 , 4 ) NOT NULL
);

CREATE 
    TRIGGER  deleted_employees
 BEFORE DELETE ON employees FOR EACH ROW 
    INSERT INTO deleted_employees 
    (first_name , last_name , middle_name , job_title , department_id , salary) 
    VALUES 
    (OLD.first_name , OLD.last_name , OLD.middle_name , OLD.job_title , OLD.department_id , OLD.salary);
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM employees where employee_id = 1;

