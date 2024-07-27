SELECT 
    m.id AS "ID",
    m.title AS "Title",
    m.release_date AS "Release date",
    m.duration AS "Duration",
    m.description AS "Description",
    TO_JSONB(poster) AS "Poster",
    JSON_BUILD_OBJECT(
        'ID', d.id,
        'First name', d.first_name,
        'Last name', d.last_name,
        'Photo', TO_JSONB(d_photo)
    ) AS "Director",
    (SELECT JSON_AGG(JSON_BUILD_OBJECT(
        'ID', a.id,
        'First name', a.first_name,
        'Last name', a.last_name,
        'Photo', TO_JSONB(a_photo)
    )) FROM persons a
    LEFT JOIN person_photos pp ON a.id = pp.person_id AND pp.is_main_photo = TRUE
    LEFT JOIN files a_photo ON pp.photo_id = a_photo.id
    JOIN characters c ON a.id = c.person_id
    WHERE c.movie_id = m.id) AS "Actors",
    (SELECT JSON_AGG(JSON_BUILD_OBJECT(
        'ID', g.id,
        'Name', g.genre
    )) FROM genres g
    WHERE g.movie_id = m.id) AS "Genres"
	FROM movies m
	LEFT JOIN files poster ON m.poster_id = poster.id
	LEFT JOIN persons d ON m.director_id = d.id  
	LEFT JOIN person_photos pp ON d.id = pp.person_id AND pp.is_main_photo = TRUE
	LEFT JOIN files d_photo ON pp.photo_id = d_photo.id
	WHERE 
    m.id = 1;


