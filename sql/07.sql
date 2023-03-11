/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with
 an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

/*Comment: use common table expressions (CTEs) to define 
two intermediate sets of actor IDs, t1 and t2
*/

with t1 as (
select distinct actor_id from  actor
join film_actor using (actor_id) where film_id in (
select film_id from film_actor 
join actor using (actor_id) 
where first_name = 'RUSSELL' and last_name = 'BACALL')
and not (first_name = 'RUSSELL' and last_name = 'BACALL')
),

t2 AS (
select distinct a3.actor_id from actor a3
join film_actor fa3 on (a3.actor_id = fa3.actor_id)
join film_actor fa4 on (fa3.film_id = fa4.film_id)
join actor a4 on (fa4.actor_id = a4.actor_id)
where a4.actor_id in (select * from t1)
and a3.actor_id not in (select * from t1)
and a3.actor_id not in (select actor_id from actor 
where a3.first_name = 'RUSSELL'and a3.last_name ='BACALL')
),

actor_names as (
select distinct first_name || ' ' || last_name as "Actor Name" from actor
where actor_id in (select * from t2)
and not exists(select 1 from film_actor where actor.actor_id = film_actor.actor_id
and film_actor.film_id in (
select film_id from film_actor join actor using (actor_id)
where first_name = 'RUSSELL' and last_name = 'BACALL') 
and not (actor.first_name = 'RUSSELL' and actor.last_name = 'BACALL')
)
and (select count(distinct actor_id) from film_actor where film_id 
in (select distinct film_id from film_actor 
where actor_id in (select * from t2))) >= 2
)

select * from actor_names order by "Actor Name";

