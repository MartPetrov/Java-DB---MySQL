-- Section 2 Data Manipulation Language 
-- P02 Insert
INSERT INTO actors (`first_name`,`last_name`,`birthdate`, `height`, `awards`, `country_id`)
(SELECT 
reverse(first_name),
reverse(last_name),  
DATE_SUB(birthdate, INTERVAL  2 day),
height + 10,
country_id,
3
FROM actors
WHERE id <= 10);

-- P03 Update 

UPDATE movies_additional_info
SET runtime = runtime - 10
WHERE id >= 15 AND id <= 25;

-- P04 Delete 
DELETE ctr
FROM countries AS ctr
LEFT JOIN movies AS m
ON ctr.id = m.country_id 
WHERE m.country_id IS NULL;