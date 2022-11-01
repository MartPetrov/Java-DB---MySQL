-- P05 Countries
SELECT 
    c.id, c.`name`, c.continent, c.currency
FROM
    countries AS c
ORDER BY currency DESC , id;

-- P06
SELECT 
    m_info.id,
    m.title,
    m_info.runtime,
    m_info.budget,
    m_info.release_date
FROM
    movies_additional_info AS m_info
        JOIN
    movies AS m ON m.movie_info_id = m_info.id
WHERE
    YEAR(release_date) IN (1996 , 1997, 1998, 1999)
ORDER BY runtime , id
LIMIT 20;

-- P07 Movie casting
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    CONCAT(REVERSE(a.last_name),
            CHAR_LENGTH(a.last_name),
            '@cast.com') AS email,
    (2022 - YEAR(a.birthdate)) AS age,
    a.height
FROM
    actors AS a
        LEFT JOIN
    movies_actors AS m_a ON m_a.actor_id = id
WHERE
    actor_id IS NULL
ORDER BY a.height ASC;
 
 
 -- P08 International festival
 SELECT 
    c.`name`, COUNT(*) AS movies_count
FROM
    countries AS c
        JOIN
    movies AS m ON m.country_id = c.id
GROUP BY country_id
HAVING movies_count >= 7
ORDER BY c.name DESC;
 
 -- P09 Rating system
 SELECT 
    m.title AS title,
    CASE
        WHEN m_info.rating <= 4.00 THEN 'poor'
        WHEN m_info.rating <= 7.00 THEN 'good'
        WHEN m_info.rating > 7.00 THEN 'excellent'
    END AS rating,
    CASE
        WHEN m_info.has_subtitles = 1 THEN 'english'
        ELSE '-'
    END AS subtitles,
    m_info.budget
FROM
    movies_additional_info AS m_info
        JOIN
    movies AS m ON m.movie_info_id = m_info.id
ORDER BY m_info.budget DESC;


