-- E-Commerce SQL Analysis — Project 3
-- Tool: PostgreSQL via pgAdmin
-- Dataset: Ecommerce dataset (1,200 rows)
-- ===============================================================

-- Create Orders Table
CREATE TABLE orders (
"OrderID" VARCHAR(20),
"Date" DATE,
"CustomerID" VARCHAR(20),
"Product" VARCHAR(50),
"Quantity" INTEGER,
"UnitPrice" NUMERIC(10,2),
"ShippingAddress" VARCHAR(255),
"PaymentMethod" VARCHAR(50),
"OrderStatus" VARCHAR(50),
"TrackingNumber" VARCHAR(50),
"ItemsInCart" INTEGER,
"CouponCode" VARCHAR(50),
"ReferralSource" VARCHAR(50),
"TotalPrice" NUMERIC(10,2)
);

-- Query 1: Preview the dataset
-- Purpose: Confirm data loaded correctly and view the first 10 rows
SELECT * FROM orders LIMIT 10;

-- Query 2: High-value orders above $1,000
-- Purpose: Use WHERE clause to filter orders above a specific threshold, sorted by value
SELECT "OrderID", "Product", "TotalPrice"
FROM orders
WHERE "TotalPrice" > 1000
ORDER BY "TotalPrice" DESC;

-- Query 3: Top-selling products by order count
-- Purpose: Use GROUP BY and COUNT to find which products are ordered most frequently
SELECT "Product", COUNT(*) AS total_orders
FROM orders
GROUP BY "Product"
ORDER BY total_orders DESC;

-- Query 4: Total revenue by product
-- Purpose: Use GROUP BY and SUM to find which products generate the most revenue
SELECT "Product", SUM("TotalPrice") AS total_revenue
FROM orders
GROUP BY "Product"
ORDER BY total_revenue DESC;

-- Query 5: Average order value by payment method
-- Purpose: Use GROUP BY and AVG to understand customer spending habits per payment channel
SELECT "PaymentMethod", AVG("TotalPrice") AS avg_order_value
FROM orders
GROUP BY "PaymentMethod"
ORDER BY avg_order_value DESC;

-- Query 6: Order status breakdown
-- Purpose: Count orders per status to know what orders were fulfilled or not
SELECT "OrderStatus", COUNT(*) AS status_count
FROM orders
GROUP BY "OrderStatus"
ORDER BY status_count DESC;


-- Query 7: Top referral sources by revenue
-- Purpose: Demonstrates HAVING vs WHERE
-- HAVING filters AFTER aggregation (SUM), while WHERE filters individual rows BEFORE grouping. 
SELECT "ReferralSource", SUM("TotalPrice") AS total_revenue
FROM orders
GROUP BY "ReferralSource"
HAVING SUM("TotalPrice") > 50000
ORDER BY total_revenue DESC;
