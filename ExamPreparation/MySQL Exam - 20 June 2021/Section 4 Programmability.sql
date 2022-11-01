-- P10 Find all courses by client's phone number
DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20))
RETURNS INT
DETERMINISTIC
BEGIN
	 DECLARE count_courses INT;
     SET count_courses := (
     SELECT count(c.id) FROM courses as c
JOIN clients as cl ON cl.id = c.client_id
WHERE cl.phone_number LIKE phone_num
     );
RETURN count_courses;
END
$$
DELIMITER ;
SELECT udf_courses_by_client ('(803) 6386812') as `count`; 

-- P11 Full info for address
DELIMITER $$
CREATE PROCEDURE udp_courses_by_address (address_name VARCHAR(100))
BEGIN
		SELECT 
        a.`name` AS `name`,
        cl.full_name AS full_name,
        CASE
        WHEN co.bill <= 20 THEN "Low"
        WHEN co.bill <= 30 THEN "Medium"
        ELSE "High"
        END AS level_of_bill,
        c.make AS make,
        c.`condition` AS `condition`,
        cat.`name` AS cat_name
		FROM addresses AS a 
        JOIN courses AS co ON co.from_address_id = a.id
        JOIN clients AS cl ON cl.id = co.client_id
        JOIN cars AS c ON c.id = co.car_id
        JOIN categories AS cat ON cat.id = c.category_id
		WHERE a.`name` LIKE address_name
        ORDER BY c.make, cl.full_name;
END
$$
DELIMITER ;

CALL udp_courses_by_address('700 Monterey Avenue');