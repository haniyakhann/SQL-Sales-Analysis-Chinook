# SQL Sales Analysis – Chinook Database

This repository contains SQL queries written to analyze the Chinook sample database.  
The goal is to practice SQL skills and answer business-style questions about sales and revenue.

---

## Files
- **analysis.sql** – main file with all queries and comments

---

## Database
The Chinook database is a mock digital media store.  
Tables used in this project:
- `Invoice` / `InvoiceLine` – sales data
- `Track` / `Album` / `Artist` – product catalog
- `Customer` – customer details

---

## Key Queries
- List all tables in the database
- Preview sample rows from `Invoice`
- Top 5 countries by revenue
- Top 10 tracks by revenue and units sold
- Top 10 artists by revenue
- Top 10 albums by revenue
- Monthly revenue trend
- Month-over-month growth using a window function (`LAG`)

---

## Example
Top 5 countries by revenue:
```sql
SELECT BillingCountry, SUM(Total) AS revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY revenue DESC
LIMIT 5;
