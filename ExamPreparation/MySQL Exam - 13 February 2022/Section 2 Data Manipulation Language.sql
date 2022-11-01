-- P02 Insert

INSERT INTO reviews (content,picture_url,published_at,rating)
(SELECT LEFT(p.`description`, 15) as content,
reverse(p.`name`) as picture_url,
'2010-10-10 00:00:00' as published_at,
p.price / 8 as rating
 from  products as p
 WHERE p.id >= 5);
 
 -- P03 Update
 
 SET SQL_SAFE_UPDATES = 0;
 UPDATE products 
SET 
    quantity_in_stock = quantity_in_stock - 5
WHERE
    quantity_in_stock >= 60
        AND quantity_in_stock <= 70;
 
 -- P04 Delete
 
 DELETE cust FROM customers AS cust
        LEFT JOIN
    orders AS o ON cust.id = o.customer_id 
WHERE
    o.customer_id IS NULL;