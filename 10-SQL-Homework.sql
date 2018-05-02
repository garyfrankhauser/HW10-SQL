USE sakila;

select * from actor;

#1A
SELECT first_name, last_name
FROM actor;

#1b
select concat(first_name, ' ', last_name)
FROM actor;

#2A
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name IN ('Joe ');

#2B
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE ('%GEN%');

#2C
SELECT actor_id, last_name, first_name
FROM actor
WHERE last_name LIKE ('%LI%');

#2D
SELECT country_id, country
FROM country
WHERE country_id IN
(
  SELECT country_id
  FROM country
  WHERE country IN ('Afghanistan', 'Bangladesh', 'China')
);

#3A
ALTER TABLE actor
ADD middle_name VARCHAR(20);
ALTER TABLE actor
MODIFY middle_name VARCHAR(20) AFTER first_name;

#3B
ALTER TABLE actor
CHANGE last_name last_name BLOB;

#3C
ALTER TABLE actor
DROP COLUMN middle_name;

#4A
SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;
 
 #4B
select last_name as last_name, count(*) as _count
    from actor
    group by last_name
        having _count > 1

#4C
UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id = 172;
select * from actor;

#4D
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';
select * from actor;

#5A
SHOW CREATE TABLE address;

#6A
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id; 

#6B
SELECT staff.first_name, staff.last_name, sum(payment.amount)
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
GROUP BY payment.staff_id; 

#6C
SELECT film.title, count(film_actor.actor_id)
FROM film
INNER JOIN film_actor ON
film.film_id = film_actor.film_id
GROUP BY film_actor.film_id; 

#6D
SELECT film.title, count(inventory.film_id)
FROM film
INNER JOIN inventory ON
film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible';

#6E
SELECT customer.first_name, customer.last_name, sum(payment.amount)
FROM customer
INNER JOIN payment ON
customer.customer_id = payment.customer_id

GROUP BY payment.customer_id
ORDER BY customer.last_name; 

#7A
SELECT title
FROM film
WHERE language_id in
(
	SELECT language_id
    FROM film
    WHERE language_id = 1
    )
    AND title LIKE 'K%'
    OR title LIKE 'Q%';
    
#7B
SELECT first_name, last_name
    FROM actor
    WHERE actor_id IN
    (
      SELECT actor_id
      FROM film_actor
      WHERE film_id IN
      (
       SELECT film_id
       FROM film
       WHERE title = 'Alone Trip'
      )
    );
    
#7C
SELECT first_name, last_name, email
    FROM customer
    WHERE address_id IN
    (
      SELECT address_id
      FROM city
      WHERE country_id IN
      (
       SELECT country_id
       FROM country
       WHERE country = 'Canada'
      )
    );
    
#7D
SELECT title
    FROM film
    WHERE film_id IN
    (
      SELECT film_id
      FROM film_category
      WHERE category_id IN
      (
       SELECT category_id
       FROM category
       WHERE name = 'Family'
      )
    );
    
#7E ##############################################################
SELECT film.title as title, count(rental.rental_id) as total
FROM film
INNER JOIN inventory ON
film.film_id = inventory.film_id
INNER JOIN rental ON
inventory.inventory_id = rental.inventory_id

GROUP BY title
ORDER BY total DESC
LIMIT 5;


#7F
SELECT payment.staff_id as STORE, sum(payment.amount) as TOTAL_SALES
FROM payment
GROUP BY STORE;

#7G
SELECT store.store_id, address.address, city.city, country.country
FROM store
INNER JOIN address ON
store.address_id = address.address_id
INNER JOIN city ON
address.city_id = city.city_id
INNER JOIN country ON
city.country_id = country.country_id;

#7H
SELECT category.name as GENRE, sum(payment.amount) as TOTAL
FROM category
INNER JOIN film_category ON
category.category_id = film_category.category_id
INNER JOIN inventory ON
film_category.film_id = inventory.film_id
INNER JOIN rental ON
inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON
rental.rental_id = payment.rental_id
GROUP BY GENRE
ORDER BY TOTAL DESC
LIMIT 5;

#8A
CREATE VIEW TOP_GENRES AS
SELECT category.name as GENRE, sum(payment.amount) as TOTAL
FROM category
INNER JOIN film_category ON
category.category_id = film_category.category_id
INNER JOIN inventory ON
film_category.film_id = inventory.film_id
INNER JOIN rental ON
inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON
rental.rental_id = payment.rental_id
GROUP BY GENRE
ORDER BY TOTAL DESC
LIMIT 5;

#8B
SELECT * FROM TOP_GENRES

#8C
DROP VIEW TOP_GENRES