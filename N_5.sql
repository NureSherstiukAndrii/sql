SELECT
    m.id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration AS "Duration",
    m.description AS "Description",
    JSON_BUILD_OBJECT(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url,
        'created_at', f.created_at,
        'updated_at', f.updated_at
    ) AS "Poster",
    JSON_BUILD_OBJECT(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name
    ) AS "Director"
FROM movies m
LEFT JOIN persons p ON m.director_id = p.id
LEFT JOIN files f ON m.poster_id = f.id
LEFT JOIN genres g ON m.id = g.movie_id
WHERE
    m.country = (SELECT country FROM movies WHERE id = 1) AND
    m.release_date >= '2022-01-01' AND
    m.duration > '02:15:00' AND
    (g.genre = 'Action' OR g.genre = 'Drama')
GROUP BY m.id, f.id, p.id
