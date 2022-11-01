-- P10 Find full name of top paid employee by store name

DELIMITER $$ 
CREATE FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50))
RETURNS TEXT
DETERMINISTIC
	BEGIN
DECLARE full_info VARCHAR (255);
	DECLARE full_name  VARCHAR (40);
	DECLARE years INT;
	DECLARE employee_id INT;
    
	SET employee_id := (
		SELECT e.id
		FROM employees AS e
		JOIN stores AS s
		ON e.store_id = s.id
		WHERE s.`name` = store_name
		ORDER BY e.salary DESC
		LIMIT 1);
        
	SET full_name := (
		SELECT concat_ws(' ', first_name, concat(middle_name, '.'), last_name)
		FROM employees AS e
    		WHERE e.id = employee_id);
	
  	SET years := (
		SELECT floor(DATEDIFF("2020-10-18", hire_date)/365)
		FROM employees AS e
		WHERE e.id = employee_id);
    
  	SET full_info := concat_ws(' ', full_name, 'works in store for', years, 'years');
  	RETURN full_info;
    END
    $$
DELIMITER ;


-- P11 Update product price by address
DELIMITER $$ 
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
BEGIN
	UPDATE products as p
    JOIN products_stores as ps
    ON ps.product_id = p.id
    JOIN stores AS s
    ON ps.store_id = s.id
    JOIN addresses as a 
    ON s.address_id = a.id
    SET p.price =
    CASE
    WHEN RIGHT(address_name,1) LIKE 0 THEN  p.price + 100
    ELSE p.price + 200
    END
    WHERE a.`name` = address_name;
END
$$

DELIMITER ;


