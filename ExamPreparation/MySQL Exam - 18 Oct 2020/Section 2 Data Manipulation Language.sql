-- P02 Insert

INSERT INTO products_stores (product_id,store_id)
SELECT id,1 FROM products as p
LEFT JOIN products_stores as pc ON p.id = pc.product_id
WHERE store_id IS NULL
;

-- P03 Update

UPDATE employees AS e 
SET 
    e.manager_id = 3,
    e.salary = e.salary - 500
WHERE
    YEAR(e.hire_date) > 2003
        AND e.store_id NOT IN (5 , 14);

-- P04 Delete

DELETE empl FROM employees AS empl 
WHERE
    empl.id != empl.manager_id
    AND empl.manager_id IS NOT NULL
    AND empl.salary >= 6000;