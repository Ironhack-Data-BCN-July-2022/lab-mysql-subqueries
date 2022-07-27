# 1
SELECT  film.title, count(inventory.film_id)
	FROM inventory
	JOIN film
	ON film.film_id = inventory.film_id
	WHERE film.title = "Hunchback Impossible";
    
# 2
SELECT title, length
	FROM film
	HAVING length > (SELECT AVG(length) FROM film);
    
# 3
SELECT * FROM (
		SELECT  actor.first_name, actor.last_name
		FROM film
		JOIN film_actor
		ON film.film_id = film_actor.film_id
		JOIN actor
		ON actor.actor_id = film_actor.actor_id
		WHERE film.title = "Alone Trip") as table2;
        
# 4
SELECT title
	FROM film
	JOIN film_category
	ON film.film_id = film_category.film_id
		JOIN category
		ON film_category.category_id = category.category_id
		WHERE category.name = "Family";
        
# 5
SELECT *
	FROM (Select concat_ws(" ",customer.first_name, customer.last_name) as `name`, customer.email as email, country.country
		FROM customer
        JOIN address
        ON customer.address_id = address.address_id
			JOIN city
			ON city.city_id = address.city_id
				JOIN country
				ON city.country_id = country.country_id
				WHERE country = "Canada") as table3;

# 6
SELECT actor.first_name, actor.last_name, film.title
	FROM film
	JOIN film_actor
	ON film_actor.film_id = film.film_id
		JOIN actor
		ON actor.actor_id = film_actor.actor_id
			JOIN (SELECT actor_id, film_id, count(actor_id) as `value_occurrence`
			FROM film_actor
			GROUP BY actor_id
			ORDER BY `value_occurrence` DESC
			LIMIT 1) as table4
			ON table4.actor_id = film_actor.actor_id;
            
# 7
SELECT  customer_id, sum(amount) as amount
		FROM payment
		GROUP BY customer_id
        order by amount desc;
SELECT customer.customer_id, first_name, last_name, film.title
	from customer
    join rental
	on customer.customer_id = rental.customer_id
    join inventory
	on rental.inventory_id = inventory.inventory_id
	join film
	on inventory.film_id = film.film_id
    where customer.customer_id = "526";
    
# 8
SELECT customer_id, avg(total_amount)
	from (SELECT customer_id, sum(amount) as total_amount
	FROM payment
	Group by customer_id) as rowas;
SELECT customer_id, sum(amount) as total_amount
	FROM payment
	Group by customer_id
	HAVING total_amount > 112.54;