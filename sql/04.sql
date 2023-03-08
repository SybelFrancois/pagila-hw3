/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */


select distinct(first_name), last_name from actor
join film_actor USING (actor_id)
join film_category USING (film_id)
join category using (category_id)
where category.name = 'Children'
and actor_id not in (
    select distinct actor_id
    from film_actor
    join film_category USING (film_id)
    join category USING (category_id)
    where category.name = 'Horror'
) order by last_name;

