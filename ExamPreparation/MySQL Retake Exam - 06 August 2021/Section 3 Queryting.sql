-- P05	Employees
SELECT first_name,last_name,age,salary,happiness_level 
FROM employees as e
ORDER BY e.salary,e.id;

-- P06 Addresses of the teams
SELECT 
    t.`name` as team_name,
    a.`name` as address_name, 
    char_length(a.`name`) as count_of_characters
FROM
    teams AS t
        JOIN
    offices AS o ON t.office_id = o.id
        JOIN
    addresses AS a ON a.id = o.address_id
WHERE
    o.website IS NOT NULL
ORDER BY t.`name` , a.`name`;

-- P07 Categories Info
SELECT 
    c.`name` AS 'name',
    COUNT(*) AS games_count,
    ROUND(AVG(g.budget), 2) AS avg_budget,
    MAX(g.rating) AS max_rating
FROM
    games AS g
        JOIN
    games_categories AS gs ON gs.game_id = g.id
        JOIN
    categories AS c ON c.id = gs.category_id
GROUP BY c.`id`
HAVING max_rating >= 9.5
ORDER BY games_count DESC , c.`name`;


-- P08 Games of 2022 

SELECT 
    g.`name`,
    g.release_date,
    CONCAT(LEFT(g.`description`, 10), '...') AS summary,
    CASE
        WHEN MONTH(g.release_date) IN (1 , 2, 3) THEN 'Q1'
        WHEN MONTH(g.release_date) IN (4 , 5, 6) THEN 'Q2'
        WHEN MONTH(g.release_date) IN (7 , 8, 9) THEN 'Q3'
        WHEN MONTH(g.release_date) IN (10 , 11, 12) THEN 'Q4'
    END AS `quarter`,
    t.name AS team_name
FROM
    games AS g
        JOIN
    teams AS t ON g.team_id = t.id
WHERE
    MONTH(g.release_date) % 2 = 0
        AND RIGHT(g.`name`, 1) LIKE 2
        AND YEAR(g.release_date) LIKE 2022
ORDER BY `quarter`;

-- P09 Full info for games
SELECT 
    g.`name` AS `name`,
    CASE
        WHEN g.budget < 50000 THEN 'Normal budget'
        ELSE 'Insufficient budget'
    END AS `budget_level`,
    t.`name` AS team_name,
    a.`name` AS address_name
FROM
    games AS g
        LEFT JOIN
    games_categories AS gc ON gc.game_id = g.id
        JOIN
    teams AS t ON t.id = g.team_id
        JOIN
    `offices` AS o ON t.office_id = o.id
        JOIN
    `addresses` AS a ON a.id = o.address_id
WHERE
    g.release_date IS NULL
        AND gc.category_id IS NULL
ORDER BY g.`name`; 


















