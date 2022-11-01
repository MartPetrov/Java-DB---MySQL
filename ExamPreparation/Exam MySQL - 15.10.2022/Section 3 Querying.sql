-- P05 Clients
SELECT * FROM clients as c
ORDER BY c.birthdate DESC, c.id DESC;

-- P06 Birthdate
SELECT 
    c.first_name, c.last_name, c.birthdate, c.review
FROM
    clients AS c
WHERE
    c.card IS NULL
        AND YEAR(c.birthdate) >= 1978
        AND YEAR(c.birthdate) <= 1993
ORDER BY c.last_name DESC , c.id
LIMIT 5
;

-- P07 Accounts

SELECT 
    CONCAT(w.last_name,
            w.first_name,
            CHAR_LENGTH(w.first_name),
            'Restaurant') AS `username`,
    REVERSE(SUBSTRING(w.email, 2, 12)) AS `password`
FROM
    waiters AS w
WHERE
    w.salary IS NOT NULL
ORDER BY `password` DESC;


-- P08 Top from menu

SELECT 
    p.id, p.`name`, COUNT(p.id) AS `count`
FROM
    products AS p
        LEFT JOIN
    orders_products AS op ON op.product_id = p.id
        LEFT JOIN
    orders AS o ON o.id = op.order_id
GROUP BY p.`name`
HAVING `count` >= 5
ORDER BY `count` DESC , p.`name`;

-- P09 Availabily
SELECT 
    t.id AS table_id,
    t.capacity AS capacity,
    COUNT(c.id),
    CASE
        WHEN capacity > COUNT(c.id) THEN 'Free seats'
        WHEN capacity = COUNT(c.id) THEN 'Full'
        ELSE 'Extra seats'
    END AS 'availability'
FROM
    tables AS t
        JOIN
    orders AS o ON o.table_id = t.id
        JOIN
    orders_clients AS oc ON oc.order_id = o.id
        JOIN
    clients AS c ON c.id = oc.client_id
WHERE
    t.floor = 1
GROUP BY o.table_id
ORDER BY t.id DESC;









