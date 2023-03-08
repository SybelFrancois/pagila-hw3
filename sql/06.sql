/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */


Select actor.first_name || ' ' || actor.last_name as "Actor Name" from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id
where film_actor.film_id in (
select fa.film_id from film_actor as fa
join actor AS a on fa.actor_id = a.actor_id
join film_actor as fa2 on fa.film_id = fa2.film_id
join actor as a2 on fa2.actor_id = a2.actor_id
where a2.first_name = 'RUSSELL' and a2.last_name = 'BACALL'
)
and actor.actor_id not in (
select fa.actor_id from film_actor as fa
join actor as a on fa.actor_id = a.actor_id
where a.first_name = 'RUSSELL' and a.last_name = 'BACALL'
)
group by "Actor Name" order by "Actor Name";

