-- P02 Insert
INSERT INTO games (`name`,rating,budget,team_id)
(SELECT left (lower(reverse(`name`)), length(`name`) - 1),
t.id as rating,
t.leader_id * 1000 as budget,
t.id
 from  teams as t
 WHERE t.id >= 1 and t.id <= 9);
 
 -- P03 Update
 SET SQL_SAFE_UPDATES = 0;
 UPDATE employees as e
 JOIN teams ON teams.leader_id = e.id
SET 
    e.salary = e.salary + 1000
WHERE
    e.salary  < 5000 AND e.age < 40
        AND e.id = teams.leader_id;
        
        
-- P04 Delete
 DELETE game FROM games AS game
		LEFT JOIN
    games_categories AS g ON game.id = g.game_id
WHERE
    g.category_id IS NULL and game.release_date IS NULL;