use sakila; 

#query 1
select title, count(inventory.film_id) as title
from film
join inventory
on film.film_id = (inventory.film_id)
where title = "Hunchback Impossible"
group by title;

#query 2
select title, length
from film
where length > (select avg(length) from film);

#query 3
select *
From (select actor.first_name, actor.last_name
from film
left join film_actor
on film.film_id = film_actor.film_id
left join actor
on actor.actor_id = film_actor.actor_id
where film.title = "Alone Trip") as derivada;

#query 4
select *
From (select film.title, category.`name`
from film
left join film_category
on film.film_id = film_category.film_id
left join category
on category.category_id = film_category.category_id
where category.`name` = "Family") as kid;

#query 5
select *
From (select customer.first_name, customer.last_name, customer.email, country.country
from customer
left join address
on address.address_id = customer.address_id 
left join city
on city.city_id = address.city_id
left join country
on country.country_id = city.country_id
where country = 'Canada') as canadians;

#query 6
SELECT title, first_name, last_name
FROM actor
JOIN film_actor
ON film_actor.actor_id=actor.actor_id
JOIN film
ON film.film_id=film_actor.film_id
WHERE actor.actor_id = (SELECT actor_id FROM (SELECT actor_id, count(film_id) as num_films FROM film_actor GROUP BY actor_id ORDER BY num_films DESC LIMIT 1) AS what);

#query 7
SELECT  customer_id, sum(amount) as amount
		FROM payment
		GROUP BY customer_id
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

#query 8

select customer_id, avg(total_amount)
from (SELECT customer_id, sum(amount) as total_amount
FROM payment
Group by customer_id) as rowas;

SELECT customer_id, sum(amount) as total_amount
FROM payment
Group by customer_id
HAVING
total_amount > 112.54;

