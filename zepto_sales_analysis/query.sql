drop table if exists zepto;

create table zepto(
sku_id SERIAL  PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER, 
discountedSedllingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration

--count or rows
SELECT COUNT(*) FROM zepto;

--sample data 
SELECT * FROM zepto;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR category IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR availablequantity IS NULL
OR outofstock IS NULL
OR quantity IS NULL;

--different product categrories
SELECT DISTINCT category
FROM zepto
ORDER BY category;


--products in stock VS out of stock
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

--data cleaning

--product with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM zepto

--Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2. What are the products with High MRP but Out of stock
SELECT DISTINCT name, mrp
FROM zepto
WHERE outOfStock = TRUE and mrp>300
ORDER BY  mrp DESC;

--Q3. Caculate Estimted Revenue for each category
SELECT category, 
SUM(discountedSellingPrice * availableQuantity)  AS total_revenue
FROM zepto
GROUP by category
ORDER BY total_revenue;

--Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10.00
ORDER BY mrp DESC, discountPercent DESC;

--Q5. Identify the top 5 categories offering the highest average discount percetage.
SELECT category, 
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5 ;

--Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightingms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightingms,2) AS price_per_gram
FROM zepto
WHERE weightingms >= 100
ORDER BY price_per_gram;


--Q7. Group the products into categories like low, Medium, Bulk based on there weights in grams.
SELECT DISTINCT name, weightingms,
CASE WHEN weightingms < 1000 THEN 'Low'
     WHEN weightingms < 5000 THEN 'medium'
	 ELSE 'Bulk'
     END  AS weight_category
FROM zepto;     


--Q8. What is the Total Inventory Weight per category
SELECT category ,
SUM(weightingms * availablequantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;









