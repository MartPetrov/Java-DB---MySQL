-- P10 Find all basic information for a game
DELIMITER $$
CREATE FUNCTION udf_game_info_by_name (game_name VARCHAR (20)) 
RETURNS TEXT
DETERMINISTIC
BEGIN
DECLARE info_text TEXT;
		SET info_text := (
        SELECT
        concat("The ", g.`name`," is developed by a ", t.`name`," in an office with an address ", a.`name`) FROM games as g
        JOIN teams AS t ON g.team_id = t.id
        JOIN offices AS o ON o.id = t.office_id
        JOIN addresses AS a ON a.id = o.address_id
         WHERE g.`name` = game_name
        GROUP BY g.`name`
        );
RETURN info_text;
END
$$

DELIMITER ;

SELECT udf_game_info_by_name('Bitwolf') AS info;

-- P11 Update budget of the games
DELIMITER $$
CREATE PROCEDURE udp_update_budget(min_game_rating FLOAT) 
BEGIN
	UPDATE games as g
    LEFT JOIN games_categories as gc ON gc.game_id = g.id
    SET g.budget = g.budget + 100000,
		g.release_date =  adddate(g.release_date, INTERVAL 1 YEAR)
    WHERE gc.category_id IS NULL 
    AND g.rating > min_game_rating 
    AND g.release_date IS NOT NULL;
END
$$

DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
CALL udp_update_budget (8);