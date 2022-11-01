#P01
CREATE TABLE `mountains` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);
CREATE TABLE `peaks` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `mountain_id` INT,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);

#P02
SELECT c.id as 'driver_id', 
`vehicle_type`, 
concat(`first_name`, " ", `last_name`) as `driver_name`
from campers as c
JOIN vehicles as v ON v.driver_id = c.id;

#P03
SELECT starting_point as 'route_starting_point', 
end_point as 'leader_name', 
leader_id, 
concat(c.first_name, " ", c.last_name) as 'leader_name'
FROM routes as r
JOIN campers as c ON r.leader_id = c.id;

#P04
DROP TABLE mountains;
DROP TABLE peaks;
CREATE TABLE `mountains` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50)
);
CREATE TABLE `peaks` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `mountain_id` INT,
    CONSTRAINT
    FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
        ON DELETE CASCADE
);