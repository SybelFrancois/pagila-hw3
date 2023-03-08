/*
 * Compute the number of customers who live outside of the US.
 */


 select count(customer_id) from customer where address_id not in (
    select distinct address.address_id from address join city using (city_id) join country using (country_id) where country.country = 'United States' or country.country = 'US'
);
