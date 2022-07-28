USE sakila;
-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, count(inventory.film_id) AS title
	FROM film
    JOIN inventory
		ON film.film_id = inventory.film_id
        WHERE title = "Hunchback Impossible"
    GROUP BY title;
    
-- 2. List all films whose length is longer than the average of all the films.
SELECT	title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film);
    
-- 3. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (SELECT actor_id
	FROM film_actor WHERE film_id = (SELECT film_id
	FROM film WHERE title="Alone Trip")); 

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title
FROM film 
WHERE film_id IN (SELECT film_id
	FROM film_category 
    WHERE category_id IN (SELECT category_id
		FROM category 
        WHERE name = "family"));

-- 5. Get name and email from customers from Canada using subqueries. 
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (SELECT address_id
	FROM address
    WHERE city_id IN (SELECT city_id
		FROM city 
		WHERE country_id IN (SELECT country_id
			FROM country
            WHERE country = "Canada")));
            
-- 5B. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT first_name, last_name, email
FROM customer
JOIN address
	ON customer.address_id=address.address_id
JOIN city
	ON address.city_id=city.city_id
JOIN country
	ON country.country_id=city.country_id
WHERE country.country= "Canada";

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT actor.actor_id, first_name, last_name, COUNT(film.title) AS count
FROM actor
JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
JOIN film
	ON film.film_id = film_actor.film_id
GROUP BY actor_id, first_name, last_name
ORDER BY count DESC;
    
SELECT *
FROM (select film.title as count, first_name, last_name
FROM actor
JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
JOIN film
	ON film.film_id = film_actor.film_id
	WHERE first_name = "gina" AND last_name = "degeneres") AS country;
    
-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT customer_id, SUM(amount) AS amount
FROM payment
GROUP BY customer_id
ORDER BY amount DESC;

SELECT customer.customer_id, first_name, last_name, film.title
FROM customer
JOIN rental
	ON customer.customer_id = rental.customer_id
JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
JOIN film
	ON inventory.film_id = film.film_id
    WHERE customer.customer_id = "526";
               

-- 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
SELECT customer_id, SUM(amount) AS amount
FROM payment
GROUP BY customer_id
ORDER BY amount desc;

 SELECT AVG(Average.amount) AS avrg
 FROM (select customer_id, SUM(amount) AS amount
	FROM payment
	GROUP BY customer_id
	ORDER BY amount DESC) as Average;
        
        
SELECT customer_id, SUM(amount) AS amount
FROM payment
GROUP BY customer_id
HAVING amount > (SELECT AVG(Average.amount) AS Averg
	FROM (SELECT customer_id, SUM(amount) AS amount
		FROM payment
		GROUP BY customer_id
        ORDER BY amount DESC) AS Average)
        ORDER BY amount DESC;

