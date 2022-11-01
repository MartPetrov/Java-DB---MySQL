CREATE TABLE `employees` (
id int PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR (50) NOT NULL,
last_name VARCHAR (50) NOT NULL
);
CREATE TABLE `categories`(
id int PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);
CREATE TABLE `products`(
id int PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id int NOT NULL
);
INSERT INTO `employees` (`first_name`, `last_name`) VALUES ('Test1', 'Test1');
INSERT INTO `employees` (`first_name`, `last_name`) VALUES ('Test2', 'Test2');
INSERT INTO `employees` (`first_name`, `last_name`) VALUES ('Test3', 'Test3');

ALTER TABLE `employees` 
ADD COLUMN `middle_name` VARCHAR(45) NOT NULL AFTER `last_name`;


ALTER TABLE `products` 
ADD INDEX `my_fk_idx` (`category_id` ASC) VISIBLE;
ALTER TABLE `products` 
ADD CONSTRAINT `my_fk`
  FOREIGN KEY (`category_id`)
  REFERENCES `products` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `employees` 
CHANGE COLUMN `middle_name` `middle_name` VARCHAR(100) NOT NULL ;

