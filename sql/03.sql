/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */


 select country.country, sum(amount) as total_payments from country 
join city using (country_id) 
join address using (city_id) 
join customer using (address_id) 
join payment using (customer_id) 
group by country.country 
order by total_payments desc, country.country;
