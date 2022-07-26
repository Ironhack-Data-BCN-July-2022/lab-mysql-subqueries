USE sakila;

#How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT  film.title ,count(inventory.film_id) as "Total copies"
FROM inventory
JOIN film
ON film.film_id = inventory.film_id
WHERE film.title = "Hunchback Impossible";

#List all films whose length is longer than the average of all the films.

SELECT  title , length
FROM film
HAVING
	length > (SELECT AVG(length) FROM film);

#Use subqueries to display all actors who appear in the film Alone Trip.
SELECT *
FROM (SELECT  actor.first_name, actor.last_name
		FROM film
		JOIN film_actor
		ON film.film_id = film_actor.film_id
		JOIN actor
		ON actor.actor_id = film_actor.actor_id
		WHERE film.title = "Alone Trip") AS DERIVADA;
        
#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies 
# categorized as family films.

SELECT title
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = "Family";


#Get name and email from customers from Canada using subqueries. Do the same with joins.
#Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
#that will help you get the relevant information.

select *
FROM (Select concat_ws(" ",customer.first_name, customer.last_name) as `name`, customer.email as email, country.country
		FROM customer
        JOIN address
        ON customer.address_id = address.address_id
        JOIN city
        ON city.city_id = address.city_id
        JOIN country
        ON city.country_id = country.country_id
        WHERE country = "Canada") as ayylmao;


#Which are films starred by the most pfilm_actorrolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select actor.first_name, actor.last_name, film.title
FROM film
JOIN film_actor
ON film_actor.film_id = film.film_id
JOIN actor
ON actor.actor_id = film_actor.actor_id
JOIN (SELECT actor_id, film_id, count(actor_id) as `value_occurrence`
		FROM
		film_actor
		GROUP BY 
		actor_id
		ORDER BY 
		`value_occurrence` DESC
        LIMIT 1) as oscar_award
ON oscar_award.actor_id = film_actor.actor_id;


#Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer ie the customer that has 
#made the largest sum of payments

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

#Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

select customer_id, avg(total_amount)
from (SELECT customer_id, sum(amount) as total_amount
FROM payment
Group by customer_id) as rowas;

SELECT customer_id, sum(amount) as total_amount
FROM payment
Group by customer_id
HAVING
total_amount > 112.54;