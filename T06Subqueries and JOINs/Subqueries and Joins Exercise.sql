#P01 Employee Addreess
SELECT 
    e.employee_id, e.job_title, a.address_id, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;

#P02 Addresses with Towns
SELECT 
    e.first_name, e.last_name, t.name AS town, a.address_text
FROM
    employees AS e
        JOIN
    addresses AS a ON e.address_id = a.address_id
        JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name , e.last_name
LIMIT 5;

#P03 Sales Employee
SELECT 
    e.employee_id, e.first_name, e.last_name, d.name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    d.name LIKE 'Sales'
ORDER BY e.employee_id DESC;

#P04 Employee Departments
SELECT 
    e.employee_id, e.first_name, e.salary, d.name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
WHERE
    e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

#P05 Employees Without Project
SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
        LEFT JOIN
    employees_projects e2 ON e2.employee_id = e.employee_id
WHERE
    e2.project_id IS NULL
ORDER BY employee_id DESC
LIMIT 3
; 
#P06 Employees Hired After
SELECT 
    e.first_name, e.last_name, e.hire_date, d.name AS dept_name
FROM
    employees AS e
        JOIN
    departments AS d USING (department_id)
WHERE
    e.hire_date > '1999-01-01 23:59:59'
        AND d.name IN ('Sales' , 'Finance')
ORDER BY hire_date
;
#P07 Employees with Project
SELECT 
    e.employee_id, e.first_name, p.name
FROM
    employees AS e
        JOIN
    employees_projects AS emp_proj ON e.employee_id = emp_proj.employee_id
        JOIN
    projects AS p ON p.project_id = emp_proj.project_id
WHERE
    DATE(p.start_date) > TIMESTAMP('2002-08-13 23:59:59')
        AND p.end_date IS NULL
ORDER BY e.first_name , p.name
LIMIT 5;

#P08 Employee 24
SELECT 
    e.employee_id,
    e.first_name,
    CASE
        WHEN p.start_date >= '2005-01-01 00:00:00' THEN NULL
        ELSE p.name
    END AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS e_p USING (employee_id)
        JOIN
    projects AS p USING (project_id)
WHERE
    e.employee_id = 24
ORDER BY p.name
;
#P09 Employee Manager
SELECT 
    e.employee_id, e.first_name, e.manager_id, e2.first_name
FROM
    employees AS e
    JOIN employees as e2 ON e.manager_id = e2.employee_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name;

#P10 Employee Summary
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
        JOIN
    departments AS d ON e.department_id = d.department_id
        JOIN
    employees AS m ON e.manager_id = m.employee_id
ORDER BY e.employee_id
LIMIT 5;

#P11 Min Average Salary
SELECT 
    AVG(e.salary) AS 'min_average_salary'
FROM
    employees AS e
GROUP BY e.department_id
ORDER BY min_average_salary
LIMIT 1
;

#12 Higthest Peaks in Bulgaria
SELECT 
    m_c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    countries AS c
        JOIN
    mountains_countries AS m_c USING (country_code)
        JOIN
    mountains AS m ON m.id = m_c.mountain_id
        JOIN
    peaks AS p ON p.mountain_id = m.id
WHERE
    c.country_code LIKE 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;

#13 Count mountain ranges
SELECT c.country_code,
    COUNT(*) AS 'mountain_range'
FROM
    countries AS c
        JOIN
    mountains_countries AS m_c USING (country_code)
GROUP BY c.country_code
HAVING c.country_code IN ('US' , 'RU', 'BG')
ORDER BY `mountain_range` DESC;

#P14 Countries with Rivers
SELECT 
    c.country_name, r.river_name
FROM
    countries AS c
        LEFT JOIN
    countries_rivers AS c_r USING (country_code)
        LEFT JOIN
    rivers AS r ON r.id = c_r.river_id
WHERE
    continent_code LIKE 'AF'
ORDER BY c.country_name
LIMIT 5;

#P15 Continents and Currencies
SELECT 
    c.continent_code,
    c.currency_code,
    COUNT(*) AS currency_usage
FROM
    countries AS c
GROUP BY c.continent_code , c.currency_code
HAVING currency_usage > 1
    AND currency_usage = (SELECT 
        COUNT(*) AS 'most_used_curr'
    FROM
        countries AS c2
    WHERE
        c2.continent_code = c.continent_code
    GROUP BY c2.currency_code
    ORDER BY most_used_curr DESC
    LIMIT 1)
ORDER BY continent_code , currency_code
;

#P16 Countries without any Mountains
SELECT 
    COUNT(*) AS country_count
FROM
    countries AS c
        LEFT JOIN
    mountains_countries AS m_c USING (country_code)
WHERE
    m_c.mountain_id IS NULL;

#P17 Highest Peak and Longest River by Country
SELECT 
    c.country_name,
    MAX(p.elevation) AS 'highest_peak_elevation',
    MAX(r.length) AS 'longest_river_length'
FROM
    countries AS c
        LEFT JOIN
    mountains_countries AS mc USING (country_code)
        LEFT JOIN
    peaks AS p ON mc.mountain_id = p.mountain_id
        LEFT JOIN
    countries_rivers AS cr ON cr.country_code = c.country_code
        LEFT JOIN
    rivers AS r ON r.id = cr.river_id
GROUP BY c.country_code
ORDER BY highest_peak_elevation DESC , longest_river_length DESC , c.country_name
LIMIT 5
;











