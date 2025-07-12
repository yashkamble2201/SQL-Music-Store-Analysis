# 🛒 Zepto Product Data Analysis (SQL Project)

This project focuses on performing **data exploration, cleaning, and analysis** on a mock product inventory dataset inspired by Zepto — a quick-commerce grocery delivery platform.

## 📂 Project Structure

- **query.sql** – Contains SQL code for:
  - Creating the `zepto` table
  - Exploring and analyzing product data
  - Cleaning data inconsistencies
  - Deriving business insights using SQL queries

## 🛠️ Technologies Used

- SQL (PostgreSQL syntax)
- Relational Database Concepts

## 📊 Key Features

### 1. **Data Exploration**
- Count of total records
- Sample data view
- Null value detection
- Unique product categories
- Stock availability insights
- Detection of duplicate product names

### 2. **Data Cleaning**
- Removal of invalid pricing records
- Standardization of price units (Paise to Rupees)

### 3. **Business Insights & Analysis**
- 🔝 Top 10 best-value products based on discount percentage
- ❌ High MRP but out-of-stock products
- 💰 Estimated revenue per category
- 🎯 Products with high MRP but low discount
- 🏆 Top 5 categories with the highest average discount
- ⚖️ Price per gram analysis for value-for-money ranking
- 📦 Categorization of products by weight: Low, Medium, Bulk
- ⚖️ Total inventory weight per category

## 📈 Sample Query Example

```sql
-- Top 5 categories offering the highest average discount percentage
SELECT category, 
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
