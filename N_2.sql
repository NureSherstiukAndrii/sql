SELECT u.id, u.username, COALESCE(array_agg(fm.movie_id), '{}') AS "Favorite movie IDs"
FROM users u
LEFT JOIN favorite_movies fm ON u.id = fm.user_id
GROUP BY u.id, u.username
