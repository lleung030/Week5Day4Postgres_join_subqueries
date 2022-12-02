--1. List all customers who live in Texas (use JOINs)

SELECT first_name, last_name, district
FROM customer
JOIN address
ON address.address_id = customer.address_id 
WHERE district = 'Texas'

--2. Get all payments above $6.99 with the Customer's Full Name

SELECT first_name, last_name, amount
FROM payment 
JOIN customer 
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99
ORDER BY amount desc

--3. Show all customers names who have made payments over $175(use subqueries)
----------------------------
SELECT first_name, last_name, sum(amount)
FROM customer  
JOIN payment 
ON payment.payment_id = customer.customer_id
GROUP BY sum(amount)
WHERE amount > (
	SELECT sum(amount)
	FROM payment 
	JOIN customer 
	ON customer.customer_id = payment.payment_id
	GROUP BY customer_id 
	HAVING sum(amount) = 175
	
	)

	
SELECT sum(amount)
FROM payment 
JOIN customer 
ON customer.customer_id = payment.payment_id
GROUP BY customer.customer_id 
HAVING sum(amount) = 175


--4. List all customers that live in Nepal (use the city table)

SELECT first_name, last_name, country
FROM customer
JOIN address
ON address.address_id = customer.address_id 
JOIN city 
ON city.city_id = address.city_id
JOIN country 
ON country.country_id = city.country_id 
WHERE country = 'Nepal'


--5. Which staff member had the most transactions?

SELECT first_name, last_name, count(amount)
FROM staff
JOIN payment
ON payment.staff_id = staff.staff_id 
GROUP BY staff.staff_id
	

--6. How many movies of each rating are there?

SELECT count(rating), film.rating
FROM film 
GROUP BY film.rating 

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT first_name, last_name, amount
FROM customer
JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE amount >(
	SELECT amount
	FROM customer
	JOIN payment 
	ON customer.customer_id = payment.customer_id 
	WHERE amount = 6.99
	LIMIT 1
)

--8.How many FREE rentals did our store rental give away?

SELECT count(rental.rental_id)
FROM rental
JOIN payment 
ON payment.rental_id = rental.rental_id 
WHERE amount = 0

