SELECT
    p.id AS "Director ID",
    CONCAT(p.first_name, ' ', p.last_name) AS "Director name",
    AVG(m.budget) AS "Average budget"
FROM persons p
LEFT JOIN movies m ON p.id = m.director_id
GROUP BY p.id, p.first_name, p.last_name
