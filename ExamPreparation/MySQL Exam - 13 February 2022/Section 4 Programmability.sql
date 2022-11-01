-- P10 Extract client cards count

DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30)) 
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE total_products INT;
	SET total_products := (
		SELECT count(op.product_id)
        from orders_products as op
        JOIN orders as o ON op.order_id = o.id
        JOIN customers AS c
        ON o.customer_id = c.id
        WHERE c.first_name = `name`
    );
    RETURN total_products;
END
$$
DELIMITER ;

-- P11 Reduce price
DELIMITER $$
CREATE PROCEDURE udp_reduce_price  (category_name  VARCHAR (50))
BEGIN
UPDATE products AS p
	JOIN categories AS cat
    ON p.category_id = cat.id
    JOIN reviews AS r
    ON r.id = p.review_id
    SET p.price = p.price * 0.70
	WHERE r.rating < 4 AND cat.`name` = category_name;
END
 $$
 DELIMITER ;
 
 CALL udp_reduce_price ('Phones and tablets');
