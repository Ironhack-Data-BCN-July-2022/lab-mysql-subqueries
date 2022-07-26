use sakila;

-- query 1
select title, count(inventory.film_id) as title
	from film
    join inventory 
    on film.film_id = inventory.film_id
    where title = "Hunchback Impossible"
    group by title;

-- query 2   
    
select title, length
    from film
    where length > (select avg(length) from film);

-- query 3

select *
From (select actor.first_name, actor.last_name
	from film
    left join film_actor
		on film.film_id = film_actor.film_id
    left join actor
		on actor.actor_id = film_actor.actor_id
        where film.title = "Alone Trip") as derivada;
 
-- query 4

select * 
from (select title, category.`name`
from film
join film_category
on film.film_id = film_category.film_id
join category
on film_category.category_id = category.category_id
where category.`name` = "Family") as category;

-- query 5

select * 
from (select first_name, last_name, email
from customer
join store
on customer.store_id = store.store_id
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
join country
on city.country_id = country.country_id
where country.country = "Canada") as country;

-- query 6
			-- this will give you the name of the most prolific actor "Gina Degerneres" with 42 movies
select actor.actor_id, first_name, last_name, count(film.title) as count
	from actor
    join film_actor
	on actor.actor_id = film_actor.actor_id
    join film
	on film.film_id = film_actor.film_id
    group by actor_id, first_name, last_name
    order by count desc;
    
			-- once we know who the prolific actor is we can display the list of all the films
Select *
from(select film.title as count, first_name, last_name
	from actor
    join film_actor
	on actor.actor_id = film_actor.actor_id
    join film
	on film.film_id = film_actor.film_id
    where first_name = "gina" and last_name = "degeneres") as country;


-- query 7
		-- Karl Seal with customer ID 526 has the most payment amount 
        -- for rentals at 221.55$ for an amount of 45 films 
        
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

-- query 8

select customer_id, sum(amount) as amount
		from payment
		group by customer_id
        order by amount desc;
 
 Select Avg(Average.amount) as Averg
 from (select customer_id, sum(amount) as amount
		from payment
		group by customer_id
        order by amount desc) as Average;
       
       -- this is the  will print out all the customers id that have purchases that are higher than the avergae
select customer_id, sum(amount) as amount
		from payment
		group by customer_id
        having amount > (Select Avg(Average.amount) as Averg
		from (select customer_id, sum(amount) as amount
		from payment
		group by customer_id
        order by amount desc) as Average)
        order by amount desc;
        