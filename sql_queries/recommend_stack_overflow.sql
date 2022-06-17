-- Restaurant.where(id: Restaurant.search_by_location('bali')).joins(:cuisines).order('restaurants.id ASC').distinct

SELECT DISTINCT "restaurants".* 
FROM "restaurants" 
INNER JOIN "restaurant_cuisines" 
ON "restaurant_cuisines"."restaurant_id" = "restaurants"."id" 
INNER JOIN "cuisines" 
ON "cuisines"."id" = "restaurant_cuisines"."cuisine_id" 
WHERE "restaurants"."id" IN 
(   
    SELECT "restaurants"."id" 
    FROM "restaurants" 
    INNER JOIN 
    (
        SELECT 
            "restaurants"."id" AS pg_search_id, 
            (ts_rank((to_tsvector('simple', coalesce("restaurants"."location_name"::text, ''))), (to_tsquery('simple', ''' ' || 'bali' || ' ''' || ':*')), 0)) AS rank 
        FROM "restaurants" 
        WHERE ((to_tsvector('simple', coalesce("restaurants"."location_name"::text, ''))) @@ (to_tsquery('simple', ''' ' || 'bali' || ' ''' || ':*')))
    ) AS pg_search_0dbdc4fb0fbb8e199f1b35 
    ON "restaurants"."id" = pg_search_0dbdc4fb0fbb8e199f1b35.pg_search_id 
    ORDER BY pg_search_0dbdc4fb0fbb8e199f1b35.rank DESC, "restaurants"."id" ASC
) 
ORDER BY restaurants.id ASC