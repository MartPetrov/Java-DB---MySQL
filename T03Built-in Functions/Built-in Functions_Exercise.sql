-- P01
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
    SUBSTRING(`first_name` FROM 1 FOR 2) = 'Sa'
ORDER BY employee_id;

-- P02
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
    LOWER(last_name) LIKE ('%ei%')
ORDER BY employee_id;

-- P03
SELECT 
    `first_name`
FROM
    employees
WHERE
    `department_id` IN (3 , 10)
        AND YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY employee_id;

-- P04
SELECT 
    `first_name`, `last_name`
FROM
    employees
WHERE
    LOWER(`job_title`) NOT LIKE '%engineer%'
ORDER BY employee_id;

-- P05
SELECT 
    `name`
FROM
    `towns`
WHERE
    CHAR_LENGTH(`name`) = 5
        OR CHAR_LENGTH(`name`) = 6
ORDER BY `name`;

-- P06
SELECT 
    `town_id`, `name`
FROM
    towns
WHERE
    `name` REGEXP '^[MmKkBbEe]'
ORDER BY `name` ASC;
-- LOWER (`name`) like 'm%' or
-- LOWER (`name`) like 'b%'or
-- LOWER (`name`) like 'k%'or
-- LOWER (`name`) like 'e%'

SELECT 
    `town_id`, `name`
FROM
    towns
WHERE
    UPPER(`name`) NOT LIKE 'R%'
        AND UPPER(`name`) NOT LIKE 'B%'
        AND UPPER(`name`) NOT LIKE 'D%'
ORDER BY `name` ASC;

-- P08
CREATE VIEW v_employees_hired_after_2000 AS
    SELECT 
        first_name, last_name
    FROM
        employees
    WHERE
        YEAR(`hire_date`) > 2000;
        
-- P09
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    CHAR_LENGTH(`last_name`) = 5;
    
-- P10
SELECT 
    country_name, iso_code
FROM
    countries
WHERE
    country_name LIKE '%a%a%a%'
ORDER BY iso_code;

-- P11
SELECT 
    p.peak_name,
    r.river_name,
    LOWER(CONCAT(LEFT(p.peak_name,
                        CHAR_LENGTH(p.peak_name) - 1),
                    r.river_name)) AS mix
FROM
    peaks AS p,
    rivers AS r
WHERE
    LOWER(RIGHT(p.peak_name, 1)) = LOWER(LEFT(r.river_name, 1))
ORDER BY mix
;

-- P12
SELECT 
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d')
FROM
    `games`
WHERE
    YEAR(`start`) = 2011
        OR YEAR(`start`) = 2012
ORDER BY `start` , `name`
LIMIT 50;

-- P13
SELECT 
    user_name,
    REGEXP_REPLACE(email, '.*@', '') AS 'email provider'
FROM
    users
ORDER BY `email provider` , `user_name`;

-- P14
SELECT 
    `user_name`, `ip_address`
FROM
    `users`
WHERE
    `ip_address` LIKE '___.1%.%.___'
ORDER BY user_name;

-- P15
SELECT 
    `name` AS game,
    CASE
        WHEN HOUR(g.start) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(g.start) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS 'Part of the day',
    CASE
        WHEN g.duration <= 3 THEN 'Extra Short'
        WHEN g.duration BETWEEN 4 AND 6 THEN 'Short'
        WHEN g.duration BETWEEN 7 AND 10 THEN 'Long'
        WHEN g.duration BETWEEN 11 AND 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games` AS g;

-- P16
SELECT 
    product_name,
    order_date,
    ADDDATE(order_date, INTERVAL 3 DAY) AS 'pay_due',
    ADDDATE(order_date, INTERVAL 1 MONTH) 'deliver_due'
FROM
    orders;










