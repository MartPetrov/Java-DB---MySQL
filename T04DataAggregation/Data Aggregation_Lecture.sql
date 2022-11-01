-- P01
SELECT 
    `department_id`, COUNT(*) AS 'Number of employees'
FROM
    employees
GROUP BY `department_id`
ORDER BY `department_id`;

-- P02
SELECT 
    `department_id`, ROUND(AVG(`salary`), 2) AS 'Average Salary'
FROM
    employees
GROUP BY `department_id`
ORDER BY `department_id`;

-- P03
SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS 'Min salary'
FROM
    employees
GROUP BY `department_id`
HAVING `Min salary` > 800;

-- P04
SELECT 
    COUNT(category_id) AS 'count'
FROM
    products
WHERE
    `price` > 8.00
GROUP BY `category_id`
HAVING `category_id` = 2;

-- P05
SELECT 
    category_id AS 'category_id',
    ROUND(AVG(`price`), 2) AS 'Average Price',
    ROUND(MIN(`price`), 2) AS 'Cheapest Product',
    ROUND(MAX(`price`), 2) AS 'Most Expensive Product'
FROM
    products
GROUP BY `category_id`;

