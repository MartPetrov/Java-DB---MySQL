/*P01*/ 
CREATE TABLE `minions` ( `id` INT AUTO_INCREMENT PRIMARY KEY, `name` VARCHAR (30), `age` INT );
CREATE TABLE `towns` (`town_id` INT AUTO_INCREMENT PRIMARY KEY, `name` VARCHAR(30));
  
ALTER TABLE `towns` 
CHANGE COLUMN `town_id` `id` INT;

/*P02*/ 
ALTER TABLE `minions` 
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_minions_towns`
  FOREIGN KEY `minions`(`town_id`)
  REFERENCES `towns` (`id`);
  
  /*P03*/
  INSERT INTO `towns` (`id`, `name`)
  Values ("1", "Sofia"),
 ("2", "Plovdiv"),
("3", "Varna");
  INSERT INTO `minions` (`id`, `name`, `age` , `town_id`)
  Values ("1", "Kevin", "22" , "1"),
 ("2", "Bob", "15" , "3"),
("3", "Steward", NULL , "2");

 /*P04*/
 TRUNCATE TABLE `minions`;
 
 /*P05*/
 DROP TABLE `minions`;
 DROP TABLE `towns`;

-- P06
CREATE TABLE `people` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DOUBLE(3 , 2 ),
    `weight` DOUBLE(5 , 2 ),
    `gender` CHAR(1) NOT NULL,
    `birthdate` DATETIME NOT NULL,
    `biography` TEXT
);

 INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`)
 VALUES ('Pesho', 1.84, 50.6, 'm', '1982-02-01 16:20:12');
 INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) 
 VALUES ('Martina', 1.86, 80, 'f', '1989-02-01 18:11:12');
 INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) 
 VALUES ('Miro', 1.94, 70.63, 'm', '1993-02-01 19:51:15');
 INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) 
 VALUES ('Yana', 1.84, 75.6, 'f', '1998-02-01 13:11:14');
 INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthdate`) 
 VALUES ('Marian', 1.54, 50, 'm', '1994-02-01 14:11:16');
 


-- P07 Create Table Users
CREATE TABLE users (
id BIGINT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(30) UNIQUE,
`password` VARCHAR(26),
profile_picture BLOB,
last_login_time DATETIME,
is_deleted BOOLEAN DEFAULT FALSE
);


INSERT INTO users (username,`password`, last_login_time) VALUES ("Martin","12345", now());
INSERT INTO users (username,`password`, last_login_time) VALUES ("Yana","123312312345", now());
INSERT INTO users (username,`password`, last_login_time) VALUES ("Pesho","412412", now());
INSERT INTO users (username,`password`, last_login_time) VALUES ("Gosho","31231", now());
INSERT INTO users (username,`password`, last_login_time) VALUES ("Tosho","12412412345", now());

-- P08 Change Primary Key
ALTER TABLE `users` 
CHANGE COLUMN `username` `username` VARCHAR(30) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `username`);
;

-- P09 Set Default Value of a Field
ALTER TABLE `users` 
CHANGE COLUMN `last_login_time` `last_login_time` DATETIME NULL DEFAULT NOW() ;

-- P10 Set Unique Fild
ALTER TABLE `users` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`),
CHANGE COLUMN `username` `username` VARCHAR(30) UNIQUE 
;

-- P11 Movies Database
CREATE SCHEMA Movies;
CREATE TABLE directors (
id INT PRIMARY KEY AUTO_INCREMENT,
director_name VARCHAR(40) NOT NULL,
notes TEXT
);

INSERT INTO directors (director_name) VALUES ("Tosho");
INSERT INTO directors (director_name) VALUES ("Gosho");
INSERT INTO directors (director_name) VALUES ("Mosho");
INSERT INTO directors (director_name) VALUES ("Losho");
INSERT INTO directors (director_name) VALUES ("Pesho");

CREATE TABLE genres (
id INT PRIMARY KEY AUTO_INCREMENT,
genre_name VARCHAR(40) NOT NULL,
notes TEXT
);

INSERT INTO genres (genre_name) VALUES ("Tosho");
INSERT INTO genres (genre_name) VALUES ("Gosho");
INSERT INTO genres (genre_name) VALUES ("Mosho");
INSERT INTO genres (genre_name) VALUES ("Losho");
INSERT INTO genres (genre_name) VALUES ("Pesho");

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(40) NOT NULL,
notes TEXT
);

INSERT INTO categories (category_name) VALUES ("Action");
INSERT INTO categories (category_name) VALUES ("Drama");
INSERT INTO categories (category_name) VALUES ("Mrama");
INSERT INTO categories (category_name) VALUES ("Krama");
INSERT INTO categories (category_name) VALUES ("Trama");

CREATE TABLE movies (
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(40) NOT NULL,
director_id INT,
copyright_year DATE,
`length` TIME,
genre_id INT,
category_id INT,
rating DOUBLE, 
notes TEXT
);

INSERT INTO movies (title) VALUES ("Action");
INSERT INTO movies (title) VALUES ("Drama");
INSERT INTO movies (title) VALUES ("Mrama");
INSERT INTO movies (title) VALUES ("Krama");
INSERT INTO movies (title) VALUES ("Trama");

-- P12 Car Rental Database
Create schema car_rental;
USE car_rental;

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(20) NOT NULL,
daily_rate DOUBLE DEFAULT 0,
weekly_rate DOUBLE DEFAULT 0,
monthly_rate DOUBLE DEFAULT 0,
weekend_rate DOUBLE DEFAULT 0
);
INSERT INTO categories (category) VALUES ("Action");
INSERT INTO categories (category) VALUES ("Drama");
INSERT INTO categories (category) VALUES ("Mrama");

CREATE TABLE cars (
id INT PRIMARY KEY AUTO_INCREMENT,
plate_number VARCHAR(7) NOT NULL,
make VARCHAR(25),
model VARCHAR(25),
car_year DATE,
category_id INT ,
doors INT,
picture BLOB,
car_condition CHAR(1),
available BOOLEAN DEFAULT TRUE
);

INSERT INTO cars (plate_number) VALUES ("a9742WD");
INSERT INTO cars (plate_number) VALUES ("ST9573W");
INSERT INTO cars (plate_number) VALUES ("P9275AD");

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20),
title VARCHAR(20),
notes TEXT
);
INSERT INTO employees (first_name) VALUES ("MARTIN");
INSERT INTO employees (first_name) VALUES ("IVAN");
INSERT INTO employees (first_name) VALUES ("TODOR");


CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
driver_licence_number VARCHAR(10) NOT NULL UNIQUE,
full_name VARCHAR(45),
address VARCHAR(100),
city VARCHAR (20),
zip_code INT UNIQUE,
notes TEXT
);
INSERT INTO customers (driver_licence_number) VALUES ("86547524");
INSERT INTO customers (driver_licence_number) VALUES ("865424524");
INSERT INTO customers (driver_licence_number) VALUES ("865125474");


CREATE TABLE rental_orders (
id  INT PRIMARY KEY AUTO_INCREMENT, 
employee_id INT, 
customer_id INT, 
car_id INT, 
car_condition CHAR(1), 
tank_level VARCHAR(10), 
kilometrage_start VARCHAR(10), 
kilometrage_end VARCHAR(10), 
total_kilometrage VARCHAR(10),
 start_date DATE,
 end_date DATE, 
 total_days DATE, 
 rate_applied DOUBLE , 
 tax_rate DOUBLE , 
 order_status VARCHAR(10),
 notes TEXT
);

INSERT INTO rental_orders (employee_id) VALUES (2);
INSERT INTO rental_orders (employee_id) VALUES (5);
INSERT INTO rental_orders (employee_id) VALUES (6);


-- P13 Basic Insert

CREATE SCHEMA soft_uni;
USE soft_uni;

CREATE TABLE towns (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE addresses (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`address_text` VARCHAR(50) NOT NULL,
`town_id` INT,
CONSTRAINT fk_addresses_towns
FOREIGN KEY (`town_id`)
REFERENCES towns(id)
);

CREATE TABLE departments (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`middle_name` VARCHAR(50) NOT NULL,
`last_name` VARCHAR(50) NOT NULL,
`job_title` VARCHAR(50),
`department_id` INT,
`hire_date` DATE,
`salary` DECIMAL(10,2),
`address_id` INT,
CONSTRAINT fk_employees_departments
FOREIGN KEY (`department_id`)
REFERENCES departments(id),
CONSTRAINT fk_employees_addresses
FOREIGN KEY (`address_id`)
REFERENCES addresses(id)
);

INSERT INTO towns (`name`) VALUES ('Sofia');
INSERT INTO towns (`name`) VALUES ('Plovdiv');
INSERT INTO towns (`name`) VALUES ('Varna');
INSERT INTO towns (`name`) VALUES ('Burgas');

INSERT INTO departments (`name`) VALUES ('Engineering');
INSERT INTO departments (`name`) VALUES ('Sales');
INSERT INTO departments (`name`) VALUES ('Marketing');
INSERT INTO departments (`name`) VALUES ('Software Development');
INSERT INTO departments (`name`) VALUES ('Quality Assurance');

INSERT INTO employees 
(`first_name`, `middle_name`, `last_name`,
`job_title`, department_id,`hire_date`,`salary`)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, "2013-02-01",3500.00);
INSERT INTO employees 
(`first_name`, `middle_name`, `last_name`,
`job_title`, department_id,`hire_date`,`salary`)
VALUES ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, "2004-03-02",4000.00);
INSERT INTO employees 
(`first_name`, `middle_name`, `last_name`,
`job_title`, department_id,`hire_date`,`salary`)
VALUES ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, "2016-08-28",525.25);
INSERT INTO employees 
(`first_name`, `middle_name`, `last_name`,
`job_title`, department_id,`hire_date`,`salary`)
VALUES ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, "2007-12-09",3000.00);
INSERT INTO employees 
(`first_name`, `middle_name`, `last_name`,
`job_title`, department_id,`hire_date`,`salary`)
VALUES ('Peter', 'Pan', 'Pan', 'Intern',3, "2016-08-028",599.88);

-- P14 Basic Select All Fields
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

-- P15 Basic Select All Fields and Order Them
SELECT * FROM towns
ORDER BY `name`;
SELECT * FROM departments
ORDER BY `name`;
SELECT * FROM employees
ORDER BY `salary` DESC;

-- P16 Basic Select Some Fields
SELECT `name` FROM towns
ORDER BY `name`;
SELECT `name` FROM departments
ORDER BY `name`;
SELECT `first_name`,`last_name`, `job_title`, `salary` FROM employees
ORDER BY `salary` DESC;

-- P17 Increase Employees Salary
UPDATE employees as e
SET e.salary = e.salary * 1.10;
SELECT `salary` FROM employees;








 
  