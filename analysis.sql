-- lists all the tables in the database
SELECT name 
FROM sqlite_master 
WHERE type='table';

-- looks at 5 rows from invoice to kinda get an idea of the structure
SELECT * 
FROM invoice
LIMIT 5;

-- finds the top 5 countries by total revenue
SELECT BillingCountry, SUM(Total) AS revenue
FROM invoice
GROUP BY BillingCountry
ORDER BY revenue DESC
LIMIT 5;

--finds the top 10 tracks by total rev and units sold
SELECT 
    t.Name AS track_name,
    SUM(il.UnitPrice * il.Quantity) AS revenue,
    SUM(il.Quantity) AS units_sold
FROM InvoiceLine il
JOIN Track t ON t.TrackId = il.TrackId
GROUP BY t.Name
ORDER BY revenue DESC
LIMIT 10;

-- Top 10 artists by rev
SELECT
  ar.Name AS artist_name,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS revenue
FROM InvoiceLine il
JOIN Track t  ON t.TrackId  = il.TrackId
JOIN Album a  ON a.AlbumId  = t.AlbumId
JOIN Artist ar ON ar.ArtistId = a.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY revenue DESC
LIMIT 10;

-- Top 10 albums by rev 
SELECT
  a.Title AS album_title,
  ar.Name AS artist_name,
  ROUND(SUM(il.UnitPrice * il.Quantity), 2) AS revenue
FROM InvoiceLine il
JOIN Track t  ON t.TrackId = il.TrackId
JOIN Album a  ON a.AlbumId = t.AlbumId
JOIN Artist ar ON ar.ArtistId = a.ArtistId
GROUP BY a.AlbumId, a.Title, ar.Name
ORDER BY revenue DESC
LIMIT 10;


--monthly rev trend 
SELECT
  strftime('%Y-%m', i.InvoiceDate) AS month,
  ROUND(SUM(i.Total), 2) AS revenue,
  COUNT(*) AS invoice
FROM Invoice i
GROUP BY month
ORDER BY month;

--LAG is a windows function
--A window function is a special kind of SQL function that lets you look across 
-- multiple rows while still keeping each row visible.

-- Month-over-Month % (uses window functions)
WITH m AS (
  SELECT strftime('%Y-%m', InvoiceDate) AS month,
         SUM(Total) AS revenue
  FROM Invoice
  GROUP BY month
)
SELECT
  month,
  ROUND(revenue, 2) AS revenue,
  ROUND(
    (revenue - LAG(revenue) OVER (ORDER BY month))
    / NULLIF(LAG(revenue) OVER (ORDER BY month), 0) * 100, 2
  ) AS mom_growth_pct
FROM m
ORDER BY month;







