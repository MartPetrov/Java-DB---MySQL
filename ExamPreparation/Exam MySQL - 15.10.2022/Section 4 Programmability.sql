-- P10 Extract bill
DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
		DECLARE bill DECIMAL(19,2);
        DECLARE first_name VARCHAR(50);
        DECLARE last_name VARCHAR(50);
        SET first_name := SUBSTRING_INDEX(full_name,' ', 1);
        SET last_name := SUBSTRING_INDEX(full_name,' ', -1);
SET bill := (
SELECT sum(p.price) as bill 
from products as p
JOIN orders_products AS op ON op.product_id = p.id
JOIN orders as o ON op.order_id = o.id
JOIN orders_clients as oc ON oc.order_id = o.id
JOIN clients as c ON c.id = oc.client_id
WHERE c.first_name LIKE first_name AND c.last_name = last_name
GROUP BY c.id
);
RETURN bill;
END
$$
DELIMITER ;

SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';

-- P11 Happy hour
DELIMITER $$
CREATE PROCEDURE udp_happy_hour(`type_of_product` VARCHAR(50))
BEGIN
UPDATE products as p
SET p.price = p.price * 0.80
WHERE p.price >= 10.00 AND p.`type` LIKE type_of_product;
END
$$

DELIMITER ;
CALL udp_happy_hour ('Cognac');


