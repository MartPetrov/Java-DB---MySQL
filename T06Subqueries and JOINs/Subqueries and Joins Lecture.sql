#P01 Managers
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', last_name) AS full_name,
    d.department_id,
    d.name
FROM
    employees AS e
        JOIN
    departments AS d ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;

#P02 Towns Addresses
SELECT 
    t.town_id, t.name AS 'town_name', a.address_text
FROM
    towns AS t
        JOIN
    addresses AS a ON t.town_id = a.town_id
WHERE
    t.`name` IN ('San Francisco' , 'Sofia', 'Carnation')
ORDER BY t.town_id , a.address_id;

#P03 Employees without manager
SELECT 
    `employee_id`,
    `first_name`,
    `last_name`,
    `department_id`,
    `salary`
FROM
    employees AS e
WHERE
    manager_id IS NULL;
    
#P04 Higher Salary
SELECT count(*) AS count FROM employees
WHERE salary > (SELECT AVG(`salary`) FROM employees);
