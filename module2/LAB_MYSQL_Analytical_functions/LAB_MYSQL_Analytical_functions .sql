-- LAB I MYSQL Analytical functions

USE sakila;

/* 1. find the running total of rental payments for each customer in the payment table, ordered by payment date.
By selecting the customer_id, payment_date, and amount columns from the payment table, and then applying the SUM function 
to the amount column within each customer_id partition, ordering by payment_date.*/

SELECT 
  customer_id,
  payment_date,
  amount,
  SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM payment
ORDER BY customer_id, payment_date;

#2
SELECT 
  DATE(payment_date) AS payment_dt, 
  amount,
  RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS rnk,
  DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS dense_rnk
FROM payment
ORDER BY payment_dt, amount DESC;

#3 
SELECT 
  c.name AS category,
  f.title AS film_title,
  f.rental_rate,
  DENSE_RANK() OVER (PARTITION BY c.category_id ORDER BY f.rental_rate DESC) AS rnk,
  DENSE_RANK() OVER (ORDER BY f.rental_rate DESC) AS dens_rank
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY c.name, rnk, film_title;

#5
SELECT payment_id, 
       customer_id, 
       amount, 
       payment_date, 
       amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) as diff_from_prev, 
       LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) - amount as diff_from_next
FROM payment
ORDER BY customer_id, payment_date;

