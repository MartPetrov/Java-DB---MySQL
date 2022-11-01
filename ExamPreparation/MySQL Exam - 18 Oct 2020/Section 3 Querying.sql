-- P05 Employees

SELECT first_name,middle_name,last_name,salary,hire_date
FROM employees
ORDER BY hire_date DESC;

-- P06 Products with old pictures

SELECT 
    p.`name`,
    p.`price`,
    p.best_before,
    CONCAT(LEFT(p.`description`, 10), '...') AS short_description,
    pic.url
FROM
    products AS p
        JOIN
    pictures AS pic ON pic.id = p.picture_id
WHERE
    YEAR(pic.added_on) < 2019
        AND p.price > 20
        AND char_length(p.`description`) > 100
ORDER BY p.price DESC;

-- P07 Count of products in stores and their average

SELECT 
    s.`name`,
    COUNT(ps.product_id) AS count_products,
    ROUND(AVG(p.price), 2) AS average_price
FROM
    stores AS s
        LEFT JOIN
    products_stores AS ps ON s.id = ps.store_id
        LEFT JOIN
    products AS p ON p.id = ps.product_id
GROUP BY s.id
ORDER BY count_products DESC , average_price DESC , s.id;

-- P08 Specific employee

SELECT 
    CONCAT_WS(' ', e.first_name, e.last_name) AS Full_name,
    s.`name` AS Store_name,
    a.`name` AS address,
    e.salary AS salary
FROM
    employees AS e
        JOIN
    stores AS s ON s.id = e.store_id
        JOIN
    addresses AS a ON a.id = s.address_id
WHERE
    e.salary < 4000 AND a.`name` LIKE '%5%'
        AND CHAR_LENGTH(a.`name`) > 8
        AND e.last_name LIKE '%n'
;

SELECT 
    REVERSE(s.`name`) AS reversed_name,
    CONCAT_WS('-', UPPER(t.`name`), a.`name`) AS full_address,
    COUNT(e.id)
FROM
    stores AS s
        JOIN
    addresses AS a ON a.id = s.address_id
        JOIN
    towns AS t ON t.id = a.town_id
        JOIN
    employees AS e ON e.store_id = s.id
GROUP BY s.id
ORDER BY `full_address`;


