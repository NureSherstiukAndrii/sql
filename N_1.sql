SELECT m.id, m.title, COUNT(DISTINCT p.id) AS "Actors count"
FROM movies m
LEFT JOIN characters c ON m.id = c.movie_id
LEFT JOIN persons p ON c.person_id = p.id
WHERE m.release_date > (CURRENT_DATE - INTERVAL '5 YEARS')
GROUP BY m.id, m.title
