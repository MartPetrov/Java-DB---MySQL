-- Section 4 Programmability 
-- P10 History movies 

DELIMITER $$
CREATE FUNCTION udf_actor_history_movies_count (full_name VARCHAR(50))
RETURNS INT DETERMINISTIC
BEGIN
	DECLARE history_movies INT;
	SET history_movies := (
SELECT count(m_a.movie_id)
        FROM movies_actors AS m_a
        JOIN actors AS a
        ON m_a.actor_id = a.id
        JOIN genres_movies AS gm
        ON gm.movie_id = m_a.movie_id
        JOIN genres AS g
        ON gm.genre_id = g.id
        WHERE concat_ws(' ', a.first_name, a.last_name) = full_name AND g.`name` = 'History'
        GROUP BY m_a.actor_id
        );
RETURN history_movies;
END
$$
DELIMITER ;

-- P11 Movie awards
DELIMITER $$
CREATE PROCEDURE udp_award_movie (movie_title VARCHAR (50))
BEGIN
UPDATE actors AS a
	JOIN movies_actors AS m_a
    ON a.id = m_a.actor_id
    JOIN movies AS m
    ON m_a.movie_id = m.id
    SET a.awards = a.awards + 1
	WHERE m.title = movie_title;
END
 $$
 DELIMITER ;