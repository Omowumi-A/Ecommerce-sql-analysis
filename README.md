# Ecommerce-sql-analysis
SQL analysis of a 1,200-row e-commerce dataset using PostgreSQL, filtering, grouping, and aggregation | DecodeLabs Data Analytics Internship Project 3

## Overview
This project uses PostgreSQL to extract business insights from a cleaned, 1,200-row e-commerce orders dataset. The goal was to move beyond spreadsheet viewing and use structured SQL queries like filtering, grouping, and aggregating to answer specific business questions about sales, revenue, and customer behavior.

## Tools Used
- PostgreSQL (database engine)
- pgAdmin 4 (query interface)
- SQL: SELECT, WHERE, GROUP BY, HAVING, ORDER BY, COUNT, SUM, AVG

## Data
The dataset was cleaned in Project 1 before this analysis.
It contains 1,200 rows and 14 columns: `OrderID` | `Date` | `CustomerID` | `Product` | `Quantity` | `UnitPrice` | `ShippingAddress` | `PaymentMethod` | `OrderStatus` | `TrackingNumber` | `ItemsInCart` | `CouponCode` | `ReferralSource` | `TotalPrice`

The data was cleaned in Project 1 (missing CouponCode values handled, duplicate OrderIDs verified as zero, dates standardized to YYYY-MM-DD, numeric precision standardized to 2 decimal places) before being loaded into PostgreSQL.

## How Data was Loaded
1. Exported cleaned dataset as CSV from Excel
2. Created `ecommerce_analytics` database in pgAdmin
3. Created `orders` table with explicit column types matching the dataset schema
4. Imported CSV using pgAdmin's built-in Import/Export tool

## SQL Concepts Covered

| Concept | Used In |
|---------|---------|
| SELECT + LIMIT | Query 1 |
| WHERE + ORDER BY | Query 2 |
| GROUP BY + COUNT | Queries 3 & 6 |
| GROUP BY + SUM | Queries 4 & 7 |
| GROUP BY + AVG | Query 5 |
| HAVING | Query 7 |

## Queries and Key Findings
### Query 1 — Preview the Dataset
Confirmed all 14 columns loaded correctly with 1,200 rows of clean e-commerce order data.

```sql
SELECT * FROM orders LIMIT 10;
```

### Query 2 — High-Value Orders (WHERE + ORDER BY)
Filtered all orders above $1,000, sorted from highest to lowest.

```sql
SELECT "OrderID", "Product", "TotalPrice"
FROM orders
WHERE "TotalPrice" > 1000
ORDER BY "TotalPrice" DESC;
```
Key Finding: 512 orders exceeded $1,000, with the highest valued at $3,456.40

### Query 3 — Top-Selling Products (GROUP BY + COUNT)
Counted total orders per product to identify best sellers.

```sql
SELECT "Product", COUNT(*) AS total_orders
FROM orders
GROUP BY "Product"
ORDER BY total_orders DESC;
```
Key Finding: The Printer was the top-selling product with 181 orders.

### Query 4 — Revenue by Product (GROUP BY + SUM)
Summed the total revenue per product to find the highest earners.

```sql
SELECT "Product", SUM("TotalPrice") AS total_revenue
FROM orders
GROUP BY "Product"
ORDER BY total_revenue DESC;
```
Key Finding: Chair generated the highest total revenue at $195,620.11

### Query 5 — Average Order Value by Payment Method (GROUP BY + AVG)
Calculated average spend per payment channel.

```sql
SELECT "PaymentMethod", AVG("TotalPrice") AS avg_order_value
FROM orders
GROUP BY "PaymentMethod"
ORDER BY avg_order_value DESC;
```

Key Finding: Credit Card had the highest average order value at $1,127.55

### Query 6 — Order Status Breakdown (GROUP BY + COUNT)
Counted orders per fulfillment status.

```sql
SELECT "OrderStatus", COUNT(*) AS status_count
FROM orders
GROUP BY "OrderStatus"
ORDER BY status_count DESC;
```

Key Finding: 250 orders were cancelled, while 231 orders were delivered.

### Query 7 — Top Referral Sources by Revenue (HAVING)
Grouped revenue by referral source, filtering out sources below $50,000.

> **Why HAVING and not WHERE?** The SQL execution order runs FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY. WHERE filters individual rows before grouping happens, so it cannot see aggregated values like SUM(). HAVING runs after GROUP BY, making it the correct tool for filtering on aggregated results.

```sql
SELECT "ReferralSource", SUM("TotalPrice") AS total_revenue
FROM orders
GROUP BY "ReferralSource"
HAVING SUM("TotalPrice") > 50000
ORDER BY total_revenue DESC;
```

Key Finding: All 5 referral sources exceeded the $50,000 threshold. Instagram led with $275,285.45, followed by Email ($261,808.55), Google ($250,441.48), Facebook ($250,410.90), and Referral ($226,815.58).

## Key Business Insights
| Query | Business Question | Finding |
|-------|------------------|---------|
| Query 2 | Which orders are high value? | 512 orders exceeded $1,000, with the highest valued at $3,456.40 |
| Query 3 | Most ordered product? | Printer was the top-selling product with 181 orders |
| Query 4 | Highest revenue product? | Chair generated the highest total revenue at $195,620.11 |
| Query 5 | Best payment method by avg spend? | Credit card is the best payment method with the highest avg order value at $1,127.55 |
| Query 6 | Order fulfillment health? | 250 orders were cancelled while 231 orders were delivered |
| Query 7 | Top marketing channel by revenue? | All 5 sources exceeded $50K, Instagram led at $275,285.45 |

## Recommendations
Since Instagram drives the most revenue, the marketing budget should prioritize these channels over underperforming sources.

## Files
- [analysis_queries.sql](analysis_queries.sql) — All 7 SQL queries with comments
- [Project3_SQL_Analysis.docx](Project3_SQL_Analysis.docx) — Full project documentation

## Related Projects
- [Project 1: Data Cleaning](https://github.com/Omowumi2/Ecommerce-data-cleaning)
- [Project 2: Exploratory Data Analysis](https://github.com/Omowumi2/Ecommerce-exploratory-data-analysis)
- Project 4: Data Visualization *(coming soon)*
