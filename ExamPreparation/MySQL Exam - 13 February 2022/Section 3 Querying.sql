-- P05 Categories
SELECT 
    id, `name`
FROM
    categories
GROUP BY `name`
ORDER BY `name` DESC;

-- P06 Quantity
SELECT id,brand_id,`name`,quantity_in_stock from products
where price > 1000 and quantity_in_stock < 30
ORDER BY quantity_in_stock, id;

-- P07 Review
SELECT 
    *
FROM
    reviews AS r
WHERE
    LEFT(r.content, 2) LIKE 'My'
        AND CHAR_LENGTH(r.content) > 61
ORDER BY r.rating DESC;


-- P08 First customers
SELECT 
    CONCAT_WS(' ', c.first_name, c.last_name) AS full_name,
    c.address,
    o.order_datetime
FROM
    customers AS c
        JOIN
    orders AS o ON o.customer_id = c.id
HAVING YEAR(o.order_datetime) <= '2018-01-01 00:00:00'
ORDER BY full_name DESC;

-- P09 Best categories
SELECT 
    COUNT(*) AS item_count,
    c.`name`,
    SUM(p.quantity_in_stock) AS total_quantity
FROM
    products AS p
        JOIN
    categories AS c ON c.id = p.category_id
GROUP BY c.id
ORDER BY item_count DESC , total_quantity
LIMIT 5;