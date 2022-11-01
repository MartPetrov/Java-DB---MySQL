-- P05 Cars

SELECT 
    c.make, c.model, c.`condition`
FROM
    cars AS c
ORDER BY c.id;

-- P06 Drivers and Cars

SELECT 
    d.first_name, d.last_name, c.make, c.model, c.mileage
FROM
    cars AS c
        JOIN
    cars_drivers AS cd ON c.id = cd.car_id
        JOIN
    drivers AS d ON d.id = cd.driver_id
WHERE
    c.mileage IS NOT NULL
ORDER BY c.mileage DESC , d.first_name;

-- P07 Number of courses for each car

SELECT 
    c.id,
    c.make,
    c.mileage,
    COUNT(cours.id) AS count_of_courses,
    ROUND(AVG(cours.bill), 2) AS avg_bill
FROM
    cars AS c
        LEFT JOIN
    courses AS cours ON cours.car_id = c.id
GROUP BY c.id
HAVING count_of_courses <> 2
ORDER BY count_of_courses DESC , c.id
;

-- P08 Regular clients

SELECT 
    cl.full_name,
    COUNT(c.id) AS count_of_cars,
    SUM(cour.bill) AS total_sum
FROM
    clients AS cl
        JOIN
    courses AS cour ON cl.id = cour.client_id
        JOIN
    cars AS c ON c.id = cour.car_id
WHERE
    SUBSTR(cl.full_name, 2, 1) LIKE 'a'
GROUP BY cl.id
HAVING count_of_cars > 1
ORDER BY cl.full_name;


SELECT 
    a.`name`,
    CASE
        WHEN HOUR(cour.`start`) BETWEEN 6 AND 20 THEN 'Day'
        ELSE 'Night'
    END AS day_time,
    cour.bill AS bill,
    cl.full_name AS full_name,
    c.make AS make,
    c.model AS model,
    categ.`name` AS category_name
FROM
    courses AS cour
        JOIN
    clients AS cl ON cl.id = cour.client_id
        JOIN
    addresses AS a ON a.id = cour.from_address_id
        JOIN
    cars AS c ON c.id = cour.car_id
        JOIN
    categories AS categ ON categ.id = c.category_id
ORDER BY cour.id;

