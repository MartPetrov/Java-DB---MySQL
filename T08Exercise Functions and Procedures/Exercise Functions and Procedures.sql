-- P01 Employees with Salary Above 35000
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN
SELECT e.first_name, e.last_name
FROM employees as e
WHERE e.salary > 35000
ORDER BY e.first_name, e.last_name, e.employee_id;
END
$$
DELIMITER ;

DROP PROCEDURE usp_get_employees_salary_above_35000;
CALL usp_get_employees_salary_above_35000 ();


-- P02 Employees with Salary Above Number
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above  (limit_salary DECIMAL (19,4))
BEGIN
SELECT e.first_name, e.last_name
FROM employees as e
WHERE e.salary >= limit_salary
ORDER BY e.first_name, e.last_name, e.employee_id;
END
$$
DELIMITER ;
CALL usp_get_employees_salary_above (45000);

-- P03 Town Names Starting With

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (start_with TEXT)
BEGIN
SELECT t.`name`FROM towns as t
WHERE LEFT (t.`name`, length(start_with)) LIKE start_with
ORDER BY t.`name`;
END
$$

DELIMITER ;
DROP PROCEDURE usp_get_towns_starting_with;
CALL usp_get_towns_starting_with("b");

-- P04 Employees from Town
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
BEGIN
SELECT e.first_name,e.last_name FROM employees as e
JOIN addresses as a ON e.address_id = a.address_id
JOIN towns as t ON t.town_id = a.town_id
WHERE t.`name` = town_name
ORDER BY e.first_name,e.last_name,e.employee_id;
END $$

DELIMITER ;
DROP PROCEDURE usp_get_employees_from_town;
CALL usp_get_employees_from_town ('Sofia');

-- P05 Salary Level Function
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,4))
RETURNS VARCHAR(7)
DETERMINISTIC
BEGIN
DECLARE salary_level VARCHAR(7);
	SET salary_level :=
CASE
WHEN salary < 30000 THEN "Low"
WHEN salary BETWEEN 30000 AND 50000 THEN  "Average"
ELSE "High"
END;
RETURN salary_level;
END $$
DELIMITER ;
DROP FUNCTION ufn_get_salary_level;

SELECT ufn_get_salary_level (13500) as salary_level;

-- P06 Employees by Salary Level
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level  (salary_level VARCHAR(7))
BEGIN
SELECT e.first_name, e.last_name FROM  employees as e
WHERE ufn_get_salary_level (e.salary) = salary_level
ORDER BY e.first_name DESC,e.last_name DESC;
END $$
DELIMITER ;

CALL usp_get_employees_by_salary_level ('high');


-- P07 Define Function
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS INT 
DETERMINISTIC
BEGIN
RETURN word REGEXP (concat('^[',set_of_letters,']+$'));
END
$$
DELIMITER ;

SELECT ufn_is_word_comprised ('oistmiahf', 'Sofia');

-- P08 Find Full Name
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name ()
BEGIN
SELECT concat_ws(" ",ah.first_name,ah.last_name) as full_name
FROM account_holders as ah
ORDER BY full_name, ah.id
;
END $$

DELIMITER ;

CALL usp_get_holders_full_name();

-- P09 People with Balance Higher Than
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than (money_in_acc DECIMAL(19,4))
BEGIN
SELECT 
    ah.first_name, ah.last_name
FROM
    accounts AS a
        JOIN
    account_holders AS ah ON ah.id = a.account_holder_id
GROUP BY ah.id
HAVING SUM(a.balance) > money_in_acc
ORDER BY a.account_holder_id;
END $$
DELIMITER ;

DROP PROCEDURE usp_get_holders_with_balance_higher_than;
CALL usp_get_holders_with_balance_higher_than (7000);

-- P10 Future Value Function
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value  (initial_sum DECIMAL(19,4), yearly_rate DECIMAL(19,5),number_of_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
RETURN initial_sum * pow(1 + yearly_rate,number_of_years);
END $$
DELIMITER ;

DROP FUNCTION ufn_calculate_future_value;
select ufn_calculate_future_value (1000,0.5,5);

-- P11 Calculating Interest
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value  (initial_sum DECIMAL(19,4), yearly_rate DECIMAL(19,4),number_of_years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
RETURN initial_sum * pow(1 + yearly_rate,number_of_years);
END;

CREATE PROCEDURE usp_calculate_future_value_for_account (accounts_id INT, yearly_rate DOUBLE)
BEGIN
SELECT a.id,ah.first_name,ah.last_name,a.balance as current_balance,
ufn_calculate_future_value  (a.balance,yearly_rate,5) as balance_in_5_years FROM accounts as a
LEFT JOIN account_holders as ah ON ah.id = a.account_holder_id
WHERE a.id = accounts_id;

END $$


DELIMITER ;
DROP PROCEDURE usp_calculate_future_value_for_account;
CALL usp_calculate_future_value_for_account (1,0.1);

-- P12 Deposit Money
SET SQL_SAFE_UPDATES = 0;
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4)) 
BEGIN
START TRANSACTION;
IF (money_amount <= 0) THEN ROLLBACK;
ELSE 
UPDATE accounts AS a
SET a.balance = a.balance + money_amount
WHERE a.id = account_id;
COMMIT;	
END IF;
END $$
DELIMITER ;
DROP PROCEDURE usp_deposit_money;
CALL usp_deposit_money(1,10);

-- P13 Withdraw Money 
SET SQL_SAFE_UPDATES = 0;
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4)) 
BEGIN
START TRANSACTION;
IF (money_amount <= 0 OR 
(SELECT balance FROM accounts
WHERE id = account_id) < money_amount) 
		THEN ROLLBACK;
ELSE 
UPDATE accounts
SET balance = balance - money_amount
WHERE id = account_id;
		END IF;
END $$
DELIMITER ;
DROP PROCEDURE usp_withdraw_money;
CALL usp_withdraw_money (1,10);