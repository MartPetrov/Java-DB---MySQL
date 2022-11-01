-- P01
SELECT `title` FROM books
WHERE substring(title, 1,3) = 'The';

-- P02
SELECT replace(`title`,'The', '***') as `title` from books
where substring(title, 1,3) = 'The';

-- P03
SELECT format(sum(`cost`),2) FROM books;

-- P04
SELECT concat_ws(" ",`first_name`, `last_name`) as 'Full Name',
timestampdiff(day,`born`, `died`) as 'Days Lived' from authors;

-- P05
SELECT `title` FROM books
WHERE `title` LIKE 'Harry Potter%'
ORDER BY id;