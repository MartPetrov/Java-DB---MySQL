-- P05 Users

SELECT username,gender,age FROM `users`
ORDER BY age DESC, `username`;

-- P06 Extract 5 Most Commented Photos

SELECT 
    p.id,
    p.`date`,
    p.`description`,
    COUNT(c.id) AS count_Comments
FROM
    photos AS p
        LEFT JOIN
    comments AS c ON p.id = c.photo_id
GROUP BY p.id
ORDER BY count_Comments DESC , p.id
LIMIT 5
;

-- P07 Lucky Users

SELECT 
    CONCAT_WS(' ', u.id, u.`username`) AS id_username, u.email
FROM
    users AS u
        JOIN
    users_photos AS up ON u.id = up.user_id
WHERE
    up.photo_id = up.user_id
ORDER BY up.user_id;

-- P08 Count Likes and Comments

SELECT 
    p.id AS 'photo_id',
    (SELECT count(id) FROM likes
    WHERE p.id = likes.photo_id) as "likes_count",
    (SELECT count(id) FROM comments
    WHERE p.id = comments.photo_id) AS 'comments_count'
FROM
    photos AS p
ORDER BY likes_count DESC , comments_count DESC , p.`id`;

-- P09 The Photo on the Tenth Day of the Month
SELECT 
    CONCAT(LEFT(`description`, 30), '...') AS summary, `date`
FROM
    photos
WHERE
    DAY(`date`) LIKE 10
ORDER BY `date` DESC;




