-- P02 Insert

INSERT INTO clients (`full_name`, `phone_number`)
SELECT 
concat_ws(" ", d.first_name, d.last_name) as full_name,
concat("(088) 9999" , (d.id * 2))
 from drivers as d
 WHERE d.id BETWEEN 10 and 20;

-- P03 Update
SET SQL_SAFE_UPDATES = 0;

UPDATE cars AS c 
SET 
    c.`condition` = 'C'
WHERE
    (c.mileage >= 800000 OR c.mileage IS NULL)
        AND c.`year` <= 2010
        AND c.make NOT LIKE 'Mercedes-Benz'; 
        
-- P04 Delete
DELETE c FROM clients AS c
        LEFT JOIN
    courses AS cour ON cour.client_id = c.id 
WHERE
    cour.id IS NULL
    AND CHAR_LENGTH(c.full_name) > 3;