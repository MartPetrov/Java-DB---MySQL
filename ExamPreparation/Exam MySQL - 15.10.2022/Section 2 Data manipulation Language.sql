-- P02 Insert 
INSERT INTO products (`name`,`type`,`price`)
SELECT concat_ws(" ", w.`last_name`, "specialty"),
"Cocktail", ceil(w.salary * 0.01) 
 FROM waiters  as w
WHERE w.id > 6;

 -- P03 Update 	
 UPDATE `orders`as o
SET o.table_id  = o.table_id - 1
WHERE o.id >= 12 AND o.id <= 23;

-- P04 Delete	
DELETE w from waiters as w
LEFT JOIN orders as o ON o.waiter_id = w.id
WHERE o.waiter_id IS NULL;