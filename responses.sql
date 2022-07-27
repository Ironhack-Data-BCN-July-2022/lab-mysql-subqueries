USE sakila;
##1
select title, count(inventory.film_id) as count
	from film
    join inventory
    on film.film_id = inventory.film_id
    where title = "Hunchback Impossible"
    group by title;
    
##2
select title, length
	FROM film
    WHERE length > (select avg(length) from film);
    
##3
select *
From (select actor.first_name, actor.last_name
	from film
    left join film_actor
		on film.film_id = film_actor.film_id
    left join actor
		on actor.actor_id = film_actor.actor_id
        where film.title = 'Alone Trip') as result;
        
##4

        select *
From (select film.title, category.`name`
from film
left join film_category
on film.film_id = film_category.film_id
left join category
on category.category_id = film_category.category_id
where category.`name` = "Family") as kid;

##5
select *
From (select customer.first_name,customer.last_name,customer.email, country.country
from customer
left join address
on address.address_id = customer.address_id
left join city
on city.city_id = address.city_id
left join country
on city.country_id= country.country_id
where country.country = "Canada") as canadians;

##6
SELECT title, first_name, last_name
FROM actor
JOIN film_actor
ON film_actor.actor_id=actor.actor_id
JOIN film
ON film.film_id=film_actor.film_id
WHERE actor.actor_id = (SELECT actor_id FROM (SELECT actor_id, count(film_id) as num_films FROM film_actor GROUP BY actor_id ORDER BY num_films DESC LIMIT 1) AS what);

##7

##?? got this one from edgar will have to look back to understand better

select customer_id, sum(amount) as amount
		from payment
		group by customer_id
        order by amount desc;
        
select customer.customer_id, first_name, last_name, film.title
	from customer
    join rental
	on customer.customer_id = rental.customer_id
    join inventory
	on rental.inventory_id = inventory.inventory_id
	join film
	on inventory.film_id = film.film_id
    where customer.customer_id = "526";








