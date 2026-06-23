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
### Query 1 — Preview the Dataset:
Confirmed all 14 columns loaded correctly with 1,200 rows of clean e-commerce order data.

```sql
SELECT * FROM orders LIMIT 10;
```

### Query 2 — High-Value Orders (WHERE + ORDER BY):
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



