-- =====================================================
-- SQL Basics - SELECT Queries
-- =====================================================
-- Author: Onur Çakılı
-- Description: Basic SELECT statements and filtering
-- Database: Compatible with MSSQL, MySQL, PostgreSQL
-- =====================================================

-- =====================================================
-- 1. SIMPLE SELECT QUERIES
-- =====================================================

-- Select all columns from a table
SELECT * FROM Customers;

-- Select specific columns
SELECT 
    FirstName, 
    LastName, 
    Email 
FROM Customers;

-- Select with alias (column renaming)
SELECT 
    FirstName AS Name,
    LastName AS Surname,
    Email AS EmailAddress
FROM Customers;

-- Select with calculations
SELECT 
    ProductName,
    Price,
    Price * 1.18 AS PriceWithTax,
    Price * 0.9 AS DiscountedPrice
FROM Products;

-- =====================================================
-- 2. DISTINCT - Removing Duplicates
-- =====================================================

-- Get unique cities
SELECT DISTINCT City 
FROM Customers;

-- Get unique combinations
SELECT DISTINCT City, Country 
FROM Customers;

-- Count unique values
SELECT COUNT(DISTINCT City) AS UniqueCities 
FROM Customers;

-- =====================================================
-- 3. WHERE CLAUSE - Filtering
-- =====================================================

-- Basic WHERE
SELECT * FROM Products 
WHERE Price > 100;

-- Multiple conditions with AND
SELECT * FROM Products 
WHERE Price > 100 AND StockQuantity > 50;

-- Multiple conditions with OR
SELECT * FROM Products 
WHERE CategoryID = 1 OR CategoryID = 2;

-- NOT operator
SELECT * FROM Products 
WHERE NOT CategoryID = 3;

-- =====================================================
-- 4. COMPARISON OPERATORS
-- =====================================================

-- Equal to
SELECT * FROM Customers 
WHERE City = 'Istanbul';

-- Not equal to
SELECT * FROM Customers 
WHERE City != 'Ankara';
-- Alternative: City <> 'Ankara'

-- Greater than, less than
SELECT * FROM Products 
WHERE Price > 500 AND Price < 1000;

-- Greater than or equal, less than or equal
SELECT * FROM Products 
WHERE StockQuantity >= 10 AND StockQuantity <= 100;

-- =====================================================
-- 5. BETWEEN OPERATOR
-- =====================================================

-- Price range
SELECT ProductName, Price 
FROM Products 
WHERE Price BETWEEN 100 AND 500;

-- Equivalent to:
-- WHERE Price >= 100 AND Price <= 500

-- Date range
SELECT * FROM Orders 
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-12-31';

-- NOT BETWEEN
SELECT * FROM Products 
WHERE Price NOT BETWEEN 100 AND 500;

-- =====================================================
-- 6. IN OPERATOR
-- =====================================================

-- Multiple values
SELECT * FROM Products 
WHERE CategoryID IN (1, 2, 3);

-- Equivalent to:
-- WHERE CategoryID = 1 OR CategoryID = 2 OR CategoryID = 3

-- String values
SELECT * FROM Customers 
WHERE City IN ('Istanbul', 'Ankara', 'Izmir');

-- NOT IN
SELECT * FROM Customers 
WHERE City NOT IN ('Istanbul', 'Ankara');

-- =====================================================
-- 7. LIKE OPERATOR - Pattern Matching
-- =====================================================

-- Starts with 'A'
SELECT * FROM Customers 
WHERE FirstName LIKE 'A%';

-- Ends with 'n'
SELECT * FROM Customers 
WHERE FirstName LIKE '%n';

-- Contains 'ar'
SELECT * FROM Products 
WHERE ProductName LIKE '%ar%';

-- Second character is 'h'
SELECT * FROM Customers 
WHERE FirstName LIKE '_h%';

-- Case-insensitive search (depends on database collation)
SELECT * FROM Products 
WHERE ProductName LIKE '%phone%';

-- NOT LIKE
SELECT * FROM Products 
WHERE ProductName NOT LIKE '%phone%';

-- Multiple wildcards
SELECT * FROM Customers 
WHERE Email LIKE '%@gmail.com' OR Email LIKE '%@hotmail.com';

-- =====================================================
-- 8. NULL VALUES
-- =====================================================

-- Find NULL values
SELECT * FROM Customers 
WHERE Phone IS NULL;

-- Find NOT NULL values
SELECT * FROM Customers 
WHERE Phone IS NOT NULL;

-- Count NULL values
SELECT 
    COUNT(*) AS TotalCustomers,
    COUNT(Phone) AS CustomersWithPhone,
    COUNT(*) - COUNT(Phone) AS CustomersWithoutPhone
FROM Customers;

-- =====================================================
-- 9. ORDER BY - Sorting
-- =====================================================

-- Sort ascending (default)
SELECT * FROM Products 
ORDER BY Price;

-- Sort descending
SELECT * FROM Products 
ORDER BY Price DESC;

-- Multiple columns
SELECT * FROM Customers 
ORDER BY City ASC, LastName ASC;

-- Sort by calculated column
SELECT 
    ProductName,
    Price,
    StockQuantity,
    Price * StockQuantity AS TotalValue
FROM Products 
ORDER BY TotalValue DESC;

-- Sort with alias
SELECT 
    ProductName,
    Price * 1.18 AS PriceWithTax
FROM Products 
ORDER BY PriceWithTax DESC;

-- =====================================================
-- 10. LIMIT / TOP - Restricting Results
-- =====================================================

-- MSSQL: TOP
SELECT TOP 10 * FROM Products 
ORDER BY Price DESC;

-- MSSQL: TOP with PERCENT
SELECT TOP 10 PERCENT * FROM Products 
ORDER BY Price DESC;

-- MySQL / PostgreSQL: LIMIT
-- SELECT * FROM Products 
-- ORDER BY Price DESC 
-- LIMIT 10;

-- MySQL / PostgreSQL: LIMIT with OFFSET
-- SELECT * FROM Products 
-- ORDER BY Price DESC 
-- LIMIT 10 OFFSET 5;

-- MSSQL: OFFSET FETCH (SQL Server 2012+)
SELECT * FROM Products 
ORDER BY Price DESC 
OFFSET 5 ROWS 
FETCH NEXT 10 ROWS ONLY;

-- =====================================================
-- 11. PRACTICAL EXAMPLES
-- =====================================================

-- Example 1: Find expensive products
SELECT 
    ProductID,
    ProductName,
    Price,
    CategoryID
FROM Products 
WHERE Price > (SELECT AVG(Price) FROM Products)
ORDER BY Price DESC;

-- Example 2: Search customers by name pattern
SELECT 
    CustomerID,
    FirstName + ' ' + LastName AS FullName,
    Email,
    City
FROM Customers 
WHERE 
    FirstName LIKE 'M%' 
    OR LastName LIKE 'M%'
ORDER BY LastName, FirstName;

-- Example 3: Find out-of-stock products
SELECT 
    ProductID,
    ProductName,
    StockQuantity,
    ReorderLevel,
    CASE 
        WHEN StockQuantity = 0 THEN 'Out of Stock'
        WHEN StockQuantity <= ReorderLevel THEN 'Low Stock'
        ELSE 'In Stock'
    END AS StockStatus
FROM Products 
WHERE StockQuantity <= ReorderLevel
ORDER BY StockQuantity;

-- Example 4: Find recent orders
SELECT 
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount,
    Status
FROM Orders 
WHERE 
    OrderDate >= DATEADD(DAY, -30, GETDATE())
    AND Status IN ('Pending', 'Processing')
ORDER BY OrderDate DESC;

-- Example 5: Price categories
SELECT 
    ProductName,
    Price,
    CASE 
        WHEN Price < 100 THEN 'Budget'
        WHEN Price < 500 THEN 'Mid-Range'
        WHEN Price < 1000 THEN 'Premium'
        ELSE 'Luxury'
    END AS PriceCategory
FROM Products 
ORDER BY Price;

-- Example 6: Customer search with multiple criteria
SELECT 
    CustomerID,
    FirstName,
    LastName,
    City,
    Email
FROM Customers 
WHERE 
    (City IN ('Istanbul', 'Ankara', 'Izmir'))
    AND Email LIKE '%@gmail.com'
    AND IsActive = 1
ORDER BY City, LastName;

-- Example 7: Product inventory report
SELECT 
    p.ProductID,
    p.ProductName,
    p.Price,
    p.StockQuantity,
    p.ReorderLevel,
    p.Price * p.StockQuantity AS InventoryValue,
    CASE 
        WHEN p.StockQuantity = 0 THEN '🔴 Out of Stock'
        WHEN p.StockQuantity <= p.ReorderLevel THEN '🟡 Reorder'
        ELSE '🟢 Sufficient'
    END AS Status
FROM Products p
WHERE p.IsActive = 1
ORDER BY InventoryValue DESC;

-- Example 8: Customer activity filter
SELECT 
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.City,
    c.RegistrationDate,
    DATEDIFF(DAY, c.RegistrationDate, GETDATE()) AS DaysSinceRegistration
FROM Customers c
WHERE 
    c.IsActive = 1
    AND c.RegistrationDate >= DATEADD(YEAR, -1, GETDATE())
ORDER BY c.RegistrationDate DESC;

-- Example 9: Advanced filtering
SELECT 
    ProductName,
    CategoryID,
    Price,
    StockQuantity
FROM Products 
WHERE 
    (CategoryID = 1 AND Price > 500)
    OR (CategoryID = 2 AND StockQuantity > 100)
    OR (CategoryID = 3 AND Price < 200)
ORDER BY CategoryID, Price;

-- Example 10: Text search in multiple columns
SELECT 
    ProductID,
    ProductName,
    Description,
    Price
FROM Products 
WHERE 
    ProductName LIKE '%laptop%'
    OR Description LIKE '%laptop%'
    OR ProductName LIKE '%computer%'
    OR Description LIKE '%computer%'
ORDER BY Price;

-- =====================================================
-- BEST PRACTICES
-- =====================================================

/*
1. Always use specific column names instead of SELECT *
2. Use proper indentation for readability
3. Add meaningful aliases for calculated columns
4. Use appropriate indexes for WHERE clauses
5. Avoid using LIKE with leading wildcard (LIKE '%text') when possible
6. Use BETWEEN instead of >= AND <=
7. Use IN instead of multiple OR conditions
8. Always specify ORDER BY for consistent results
9. Use TOP/LIMIT for large result sets
10. Comment your complex queries
*/

-- =====================================================
-- PERFORMANCE TIPS
-- =====================================================

-- Good: Indexed column
SELECT * FROM Customers 
WHERE CustomerID = 123;

-- Bad: Function on indexed column (prevents index usage)
-- SELECT * FROM Customers 
-- WHERE YEAR(RegistrationDate) = 2024;

-- Good: Use date range
SELECT * FROM Customers 
WHERE RegistrationDate >= '2024-01-01' 
  AND RegistrationDate < '2025-01-01';

-- Good: Specific columns
SELECT CustomerID, FirstName, LastName FROM Customers;

-- Avoid: SELECT *
-- SELECT * FROM Customers;

-- =====================================================
-- END OF BASIC SELECT QUERIES
-- =====================================================
