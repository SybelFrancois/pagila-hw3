/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */ 


select f1.title from film f1
join film_actor fac1 using (film_id)
join film_actor fac2 on fac2.actor_id = fac1.actor_id 
and fac2.film_id != fac1.film_id
join film f2 on fac2.film_id = f2.film_id
where f2.title = 'AMERICAN CIRCUS'
group by f1.title
having count(f1.title) >= 2
union all select 'AMERICAN CIRCUS' from film 
where title = 'AMERICAN CIRCUS' order by title;

