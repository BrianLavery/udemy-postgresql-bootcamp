SELECT DISTINCT
	name,
	location_name
FROM
(
	SELECT 
		restaurants.* 
	FROM restaurants 
	INNER JOIN 
	(
		SELECT 
			restaurants.id AS pg_search_id, 
			(ts_rank((to_tsvector('simple', coalesce(restaurants.location_name::text, ''))), (to_tsquery('simple', ''' ' || 'bali' || ' ''' || ':*')), 0)) AS rank 
		FROM restaurants 
		WHERE ((to_tsvector('simple', coalesce(restaurants.location_name::text, ''))) @@ (to_tsquery('simple', ''' ' || 'bali' || ' ''' || ':*')))
	) AS pg_search_0dbdc4fb0fbb8e199f1b35 
	ON restaurants.id = pg_search_0dbdc4fb0fbb8e199f1b35.pg_search_id 
	INNER JOIN restaurant_cuisines 
	ON restaurant_cuisines.restaurant_id = restaurants.id 
	INNER JOIN cuisines 
	ON cuisines.id = restaurant_cuisines.cuisine_id 
	ORDER BY pg_search_0dbdc4fb0fbb8e199f1b35.rank DESC, restaurants.id ASC, restaurants.id ASC
) t


	SELECT 
		restaurants.*,
		cuisines.*
	FROM restaurants 
	INNER JOIN 
	(
		SELECT 
			restaurants.id AS pg_search_id, 
			restaurants.name AS r_name,
			(ts_rank((to_tsvector('simple', coalesce(restaurants.name::text, ''))), (to_tsquery('simple', ''' ' || 'me' || ' ''' || ':*')), 0)) AS rank 
		FROM restaurants 
		--WHERE ((to_tsvector('simple', coalesce(restaurants.name::text, ''))) @@ (to_tsquery('simple', ''' ' || 'ba' || ' ''' || ':*')))
	) AS pg_search_0dbdc4fb0fbb8e199f1b35 
	ON restaurants.id = pg_search_0dbdc4fb0fbb8e199f1b35.pg_search_id 
	INNER JOIN restaurant_cuisines 
	ON restaurant_cuisines.restaurant_id = restaurants.id 
	INNER JOIN cuisines 
	ON cuisines.id = restaurant_cuisines.cuisine_id 
	ORDER BY pg_search_0dbdc4fb0fbb8e199f1b35.rank DESC, restaurants.id ASC, restaurants.id ASC