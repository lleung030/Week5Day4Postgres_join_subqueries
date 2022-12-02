SELECT*
FROM payment 
WHERE amount >(
	SELECT avg(amount)
	FROM payment 
);

-- write a subquery that finds all the films that has the language of english

SELECT langauge_id
FROM "language"
WHERE "name" = 'English';

SELECT *
FROM film 
WHERE language_id = (
	SELECT language_id
	FROM "language"
	WHERE "name" = "English"
)

-- find all actors with last name Alan

SELECT actor_id
FROM actor 
WHERE last_name = 'Allen'

SELECT *
FROM film_actor 
WHERE actor_id IN (
	SELECT actor_id 
	FROM actor 
	WHERE last_name = 'Allen'
)

SELECT *
FROM film_actor 
WHERE actor_id IN (
	SELECT actor_id 
	FROM actor 
	WHERE last_name = 'Allen'
)

SELECT title
FROM film 
WHERE film_id IN (
	SELECT film_id 
	FROM film_actor 
	WHERE actor_id IN (
	SELECT actor_id
	FROM actor a
	WHERE last_name = 'Allen'
	)	
);

SELECT max(count)
FROM (
	SELECT country.country, COUNT(country.country)
	FROM category
	JOIN film_category
	ON film_category.category_id = category.category_id
	JOIN film
	ON film.film_id = film_category.film_id 
	JOIN inventory
	ON inventory.film_id = film.film_id
	JOIN rental
	ON rental.inventory_id = inventory.inventory_id
	JOIN customer
	ON customer.customer_id = rental.customer_id 
	JOIN address
	ON customer.address_id = address.address_id 
	JOIN city
	ON address.city_id = city.city_id
	JOIN country
	ON city.country_id = country.country_id
	WHERE category."name" = 'Drama' AND release_year = 2006
	GROUP BY country.country
)
AS drama_country_rentals

SELECT avg(count)
FROM (
	SELECT country.country, COUNT(country.country)
	FROM category
	JOIN film_category
	ON film_category.category_id = category.category_id
	JOIN film
	ON film.film_id = film_category.film_id 
	JOIN inventory
	ON inventory.film_id = film.film_id
	JOIN rental
	ON rental.inventory_id = inventory.inventory_id
	JOIN customer
	ON customer.customer_id = rental.customer_id 
	JOIN address
	ON customer.address_id = address.address_id 
	JOIN city
	ON address.city_id = city.city_id
	JOIN country
	ON city.country_id = country.country_id
	WHERE category."name" = 'Drama' AND release_year = 2006
	GROUP BY country.country
)
AS drama_country_rentals


SELECT country.country, COUNT(country.country)
FROM category
JOIN film_category
ON film_category.category_id = category.category_id
JOIN film
ON film.film_id = film_category.film_id 
JOIN inventory
ON inventory.film_id = film.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN customer
ON customer.customer_id = rental.customer_id 
JOIN address
ON customer.address_id = address.address_id 
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE category."name" = 'Drama' AND release_year = 2006
GROUP BY country.country
HAVING count(*) > (
	SELECT AVG(count)
	FROM (
		SELECT country.country, COUNT(country.country)
		FROM category
		JOIN film_category
		ON film_category.category_id = category.category_id
		JOIN film
		ON film.film_id = film_category.film_id 
		JOIN inventory
		ON inventory.film_id = film.film_id
		JOIN rental
		ON rental.inventory_id = inventory.inventory_id
		JOIN customer
		ON customer.customer_id = rental.customer_id 
		JOIN address
		ON customer.address_id = address.address_id 
		JOIN city
		ON address.city_id = city.city_id
		JOIN country
		ON city.country_id = country.country_id
		WHERE category."name" = 'Drama' AND release_year = 2006
		GROUP BY country.country
	) AS drama_country_rentals
);

CREATE VIEW drama_country_rentals
AS
	SELECT country.country, COUNT(country.country)
	FROM category
	JOIN film_category
	ON film_category.category_id = category.category_id
	JOIN film
	ON film.film_id = film_category.film_id 
	JOIN inventory
	ON inventory.film_id = film.film_id
	JOIN rental
	ON rental.inventory_id = inventory.inventory_id
	JOIN customer
	ON customer.customer_id = rental.customer_id 
	JOIN address
	ON customer.address_id = address.address_id 
	JOIN city
	ON address.city_id = city.city_id
	JOIN country
	ON city.country_id = country.country_id
	WHERE category."name" = 'Drama' AND release_year = 2006
	GROUP BY country.country;
	
SELECT*
FROM drama_country_rentals 
WHERE "count" > (
	SELECT avg(count)
	FROM drama_country_rentals 
)


-- Use the above subquery, to find all of the countries with an above average count
-- of drama movie rentals
SELECT *
FROM drama_country_rentals
WHERE "count" > (
	SELECT AVG(count)
	FROM drama_country_rentals
);

CREATE OR REPLACE VIEW drama_country_rentals
AS
	SELECT country.country, COUNT(country.country)
	FROM category
	JOIN film_category
	ON film_category.category_id = category.category_id
	JOIN film
	ON film.film_id = film_category.film_id 
	JOIN inventory
	ON inventory.film_id = film.film_id
	JOIN rental
	ON rental.inventory_id = inventory.inventory_id
	JOIN customer
	ON customer.customer_id = rental.customer_id 
	JOIN address
	ON customer.address_id = address.address_id 
	JOIN city
	ON address.city_id = city.city_id
	JOIN country
	ON city.country_id = country.country_id
	WHERE category."name" = 'Drama' AND release_year = 2006
	GROUP BY country.country;
	

-- which country/countries have the most movie rentals?
CREATE OR REPLACE VIEW country_rental_count
AS
	SELECT country.country, COUNT(country.country)
	FROM category
	JOIN film_category
	ON film_category.category_id = category.category_id
	JOIN film
	ON film.film_id = film_category.film_id 
	JOIN inventory
	ON inventory.film_id = film.film_id
	JOIN rental
	ON rental.inventory_id = inventory.inventory_id
	JOIN customer
	ON customer.customer_id = rental.customer_id 
	JOIN address
	ON customer.address_id = address.address_id 
	JOIN city
	ON address.city_id = city.city_id
	JOIN country
	ON city.country_id = country.country_id
	GROUP BY country.country;

SELECT MAX(count)
FROM country_rental_count;

SELECT country
FROM country_rental_count
WHERE count = (
	SELECT MAX(count)
	FROM country_rental_count
);

-- which cities have less than average total payments?
SELECT city, sum
FROM city_total_payments
WHERE sum > (
	SELECT AVG(sum)
	FROM city_total_payments
);

CREATE OR REPLACE VIEW city_total_payments
AS
	SELECT city, SUM(amount)
	FROM city
	JOIN address
	ON city.city_id = address.city_id
	JOIN customer
	ON customer.address_id = address.address_id 
	JOIN payment
	ON payment.customer_id = customer.customer_id
	GROUP BY city;