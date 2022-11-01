-- P10 Get User's Photos Count
DELIMITER $$
CREATE FUNCTION  udf_users_photos_count(username VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE count_photos INT;
SET count_photos := (
SELECT count(photo_id) from users_photos as up
JOIN users AS u ON u.id = up.user_id
WHERE  u.username = username
);

RETURN count_photos;
END
$$
DELIMITER ;

SELECT udf_users_photos_count('ssantryd') AS photosCount;

-- P 11 Increase user age
DELIMITER $$
CREATE PROCEDURE udp_modify_user (address VARCHAR(30), town VARCHAR(30)) 
BEGIN
UPDATE users AS u
JOIN addresses as a ON a.user_id = u.id
SET u.age = IF (u.age IS NULL, NULL, u.age + 10)
WHERE a.address = address and a.town = town;
END
$$
DELIMITER ;

CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
