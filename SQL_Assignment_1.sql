-- Q1: Show all the brand names
SELECT brand_name
FROM production.brands
ORDER BY brand_name;
-- Q2: Show all products, starting from the most expensive
SELECT product_name, list_price
FROM production.products
ORDER BY list_price DESC;
-- Q3: Customers who live in New York (state code = 'NY')
SELECT customer_id, first_name, last_name, city, state
FROM sales.customers
WHERE state = 'NY';
-- Q4: The 5 most expensive products
SELECT TOP (5) product_name, list_price
FROM production.products
ORDER BY list_price DESC;
-- Q5: Products priced between $200 and $500 (inclusive)
SELECT product_name, list_price
FROM production.products
WHERE list_price BETWEEN 200 AND 500
ORDER BY list_price;
-- Q6: Customers whose last name starts with the letter S
SELECT first_name, last_name, email
FROM sales.customers
WHERE last_name LIKE 'S%'
ORDER BY last_name, first_name;
-- Q7: Products that are Mountain Bikes OR Road Bikes
SELECT p.product_name, c.category_name
FROM production.products AS p
JOIN production.categories AS c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Mountain Bikes'
   OR c.category_name = 'Road Bikes'
ORDER BY c.category_name, p.product_name;
-- Q8: Orders that have not been shipped yet (no shipped date)
SELECT order_id, customer_id, order_date, required_date, shipped_date
FROM sales.orders
WHERE shipped_date IS NULL;
-- Q9: Product name, brand id and the price after a 15% discount
SELECT
    product_name,
    brand_id,
    list_price,
    ROUND(list_price - (list_price * 0.15), 2) AS discounted_price
FROM production.products;
-- Q10: Unique cities of customers, A to Z
SELECT DISTINCT city
FROM sales.customers
ORDER BY city;
-- Q11: Active staff members with their full name and email
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM sales.staffs
WHERE active = 1;
-- Q12: All cities from customers and stores combined (no duplicates)
SELECT city FROM sales.customers
UNION
SELECT city FROM sales.stores
ORDER BY city;
-- Q13: Product ids that appear in order_items but not in products
SELECT DISTINCT oi.product_id
FROM sales.order_items AS oi
WHERE NOT EXISTS (
    SELECT 1
    FROM production.products AS p
    WHERE p.product_id = oi.product_id
);
-- Q14: Products from model year 2016 that cost more than $1,500
SELECT product_name, model_year, list_price
FROM production.products
WHERE model_year = 2016
  AND list_price > 1500
ORDER BY list_price DESC;
-- Q15 (Bonus): Trek products from 2016 together with Surly products
SELECT b.brand_name, p.product_name, p.model_year, p.list_price
FROM production.products AS p
JOIN production.brands AS b
    ON p.brand_id = b.brand_id
WHERE (b.brand_name = 'Trek'  AND p.model_year = 2016)
   OR (b.brand_name = 'Surly' AND p.model_year = 2017)
ORDER BY b.brand_name, p.model_year, p.list_price DESC;
