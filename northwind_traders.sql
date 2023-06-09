SET GLOBAL local_infile=1;
SET SQL_SAFE_UPDATES = 0;
load data local infile '/Users/marcusogata/Desktop/Analytics/Projects/Northwind Traders/orders.csv' into table orders fields terminated by ',' ignore 1 rows;
load data local infile '/Users/marcusogata/Desktop/Analytics/Projects/Northwind Traders/customers.csv' into table customers fields terminated by ',' ignore 1 rows;
load data local infile '/Users/marcusogata/Desktop/Analytics/Projects/Northwind Traders/order_details.csv' into table order_details fields terminated by ',' ignore 1 rows;

/* customers table analysis */ 
SELECT *
FROM customers;

-- customers in 21 countries 
SELECT DISTINCT country
FROM customers;

-- amount of customers in each country
SELECT 
	country,
    COUNT(country) total_customers
FROM customers
GROUP BY country;

-- amount of customers in each city
SELECT 
	city,
    COUNT(city) total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- amount of sales by company
SELECT
	c.company_name,
    SUM(ROUND((unit_price * quantity))) - SUM(ROUND((unit_price * quantity) * discount)) AS total_w_discount	
FROM orders o INNER JOIN order_details d  
ON o.orderID = d.orderID
INNER JOIN customers c
ON o.customerID = c.customerID
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY
  c.company_name
ORDER BY 	
	total_w_discount DESC;

/* order_details table analysis */ 
SELECT *
FROM order_details
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53");

-- orders made per product 
SELECT 
	productID,
    COUNT(orderID) orders_made
FROM order_details
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY productID
ORDER BY orders_made DESC;

-- total sold by productID
SELECT
	productID,
    SUM(ROUND((unit_price * quantity))) - SUM(ROUND((unit_price * quantity) * discount)) AS total_w_discount
FROM order_details
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY productID
ORDER BY total_w_discount DESC;

-- total sold by customerID
SELECT
	o.customerID,
    SUM(ROUND((d.unit_price * d.quantity))) - SUM(ROUND((d.unit_price * d.quantity) * d.discount)) AS total_w_discount
FROM order_details d INNER JOIN orders o 
ON o.orderID = d.orderID
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY o.customerID
ORDER BY total_w_discount DESC;

-- total sold by employee
SELECT
	e.employeeID AS ID,
    e.employee_name,
	SUM(ROUND((d.unit_price * d.quantity))) - SUM(ROUND((d.unit_price * d.quantity) * d.discount)) AS total_w_discount
FROM order_details d JOIN orders o 
ON d.orderID = o.orderID
JOIN employees e
ON o.employeeID = e.employeeID
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY ID
ORDER BY total_w_discount DESC;

-- most expensive product 
SELECT
	productID,
	MAX(unit_price) AS most_expensive
FROM order_details
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY productID 
ORDER BY most_expensive DESC LIMIT 1;

-- least expensive product 
SELECT
	productID,
	MIN(unit_price) AS least_expensive
FROM order_details
WHERE productID NOT IN ("5", "9", "17", "24", "28", "29", "42", "53")
GROUP BY productID 
ORDER BY least_expensive LIMIT 1;

/* orders table analysis */
SELECT *
FROM orders;

-- 21 orders missing a shippeddate
SELECT
	COUNT(customerID) missing_shippeddate
FROM orders 
WHERE shippeddate IS NULL;

-- 37 orders shipped after required date
SELECT
	orderID,
    requireddate,
    shippeddate,
    DATEDIFF(shippeddate, requireddate) AS date_diff
FROM
	(SELECT 
		orderID,
        requireddate,
		shippeddate,
		DATEDIFF(shippeddate, requireddate) AS date_diff
	FROM orders 
	WHERE shippeddate IS NOT NULL) x
WHERE date_diff > "0"; 

SELECT *
FROM orders;

-- number of orders completed by each employee
SELECT 
	o.employeeID,
    e.employee_name,
    COUNT(o.customerID) orders_filled
FROM orders o INNER JOIN employees e
ON o.employeeID = e.employeeID
WHERE o.shippeddate IS NOT NULL
GROUP BY o.employeeID
ORDER BY orders_filled DESC;

-- orders made by each customer
SELECT 
	o.customerID,
    c.company_name,
    c.contact_name,
    COUNT(o.customerID) orders_made
FROM orders o INNER JOIN customers c
ON o.customerID = c.customerID
WHERE o.shippeddate IS NOT NULL
GROUP BY c.company_name, c.contact_name, o.customerID
ORDER BY orders_made DESC;

-- count of sales by month  
SELECT
	MONTH(shippeddate),
	COUNT(orderID) AS count
FROM orders
WHERE shippeddate IS NOT NULL
GROUP BY
  MONTH(shippeddate)
ORDER BY 	
	MONTH(shippeddate);
    
-- amount in sales by month
SELECT
	MONTH(shippeddate),
    SUM(ROUND((d.unit_price * d.quantity))) - SUM(ROUND((d.unit_price * d.quantity) * d.discount)) AS total_w_discount	
FROM orders o INNER JOIN order_details d  
ON o.orderID = d.orderID
INNER JOIN products p
ON d.productID = p.productID
WHERE shippeddate IS NOT NULL AND discontinued = "0"
GROUP BY
  MONTH(shippeddate)
ORDER BY 	
	MONTH(shippeddate);
    
-- count of orders by year
SELECT
	YEAR(shippeddate),
	COUNT(orderID)
FROM orders
WHERE shippeddate IS NOT NULL
GROUP BY
  YEAR(shippeddate);
  
-- amount in sales by year
SELECT
	YEAR(shippeddate),
    SUM(ROUND((d.unit_price * d.quantity))) - SUM(ROUND((d.unit_price * d.quantity * d.discount))) AS total_w_discount
FROM orders o INNER JOIN order_details d  
ON o.orderID = d.orderID
INNER JOIN products p
ON d.productID = p.productID
WHERE shippeddate IS NOT NULL AND discontinued = "0"
GROUP BY YEAR(shippeddate)
ORDER BY YEAR(shippeddate);

-- total cost of shipping 
SELECT 
	SUM(ROUND(freight))
FROM orders;

/* products table analysis */  
SELECT *
FROM products;

-- 8 discountinued prodcuts 
SELECT *
	-- COUNT(productID)
FROM products
WHERE discontinued = "1"; 

-- count of products in each category 
SELECT 
	p.categoryID,
    c.category_name,
	COUNT(p.categoryID) product_count
FROM products p INNER JOIN categories c
ON p.categoryID = c.categoryID
WHERE p.discontinued = "0" 
GROUP BY p.categoryID;

-- count of orders by product
SELECT 
	p.product_name,
	COUNT(o.orderID) order_count
FROM products p INNER JOIN order_details o
ON p.productID = o.productID
WHERE p.discontinued = "0" 
GROUP BY product_name
ORDER BY order_count DESC;

-- unit_price differences between products & order_details tables
-- productID 42 & 11 have multiple unit_price in order_details table 
SELECT DISTINCT 
	p.productID, 
    p.unit_price product_table_price,
    o.unit_price order_details_tableID
FROM products p LEFT JOIN order_details o 
ON p.productID = o.productID
WHERE p.unit_price != o.unit_price
ORDER BY productID;





















