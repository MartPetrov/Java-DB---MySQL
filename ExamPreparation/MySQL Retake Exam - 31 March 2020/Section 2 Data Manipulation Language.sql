-- P02 Insert
INSERT INTO `addresses` (`address`,`town`,`country`,`user_id`)
SELECT u.username,u.`password`,u.ip,u.age from users as u
WHERE u.gender LIKE 'M';

-- P03 Update
SET SQL_SAFE_UPDATES = 0;
UPDATE `addresses` as a
SET a.country = 
CASE
WHEN left(a.country,1) = 'B' THEN 'Blocked'
WHEN left(a.country,1) = 'T' THEN 'Test'
WHEN left(a.country,1) = 'P' THEN 'In Progress'
ELSE country
END;

-- P04 Delete

DELETE address FROM `addresses` AS address 
WHERE
    address.id % 3 = 0;