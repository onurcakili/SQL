------------------------------------------------------------------------------------------------
-- TCL (TRANSACTION CONTROL LANGUAGE)
------------------------------------------------------------------------------------------------

-- TCL controls multi-step database operations.
-- COMMIT makes a transaction permanent.
-- ROLLBACK cancels a transaction and returns the data to the previous safe state.

------------------------------------------------------------------------------------------------
-- WHY TRANSACTIONS MATTER
------------------------------------------------------------------------------------------------

-- Example:
-- In an order process, two changes may need to happen together:
--
-- 1. Create the order record.
-- 2. Decrease product stock.
--
-- If only one of these actions succeeds, the database becomes inconsistent.
-- A transaction helps keep these steps together.

------------------------------------------------------------------------------------------------
-- BASIC TRANSACTION EXAMPLE
------------------------------------------------------------------------------------------------

BEGIN TRANSACTION;

-- INSERT INTO ORDERS (CustomerID, OrderDate)
-- VALUES (1, GETDATE());
--
-- UPDATE PRODUCTS
-- SET StockQuantity = StockQuantity - 1
-- WHERE ProductID = 10;

COMMIT;

------------------------------------------------------------------------------------------------
-- ROLLBACK EXAMPLE
------------------------------------------------------------------------------------------------

BEGIN TRANSACTION;

-- DELETE FROM CUSTOMERS
-- WHERE CITY = 'Istanbul';

ROLLBACK;

------------------------------------------------------------------------------------------------
-- SAVE TRANSACTION EXAMPLE
------------------------------------------------------------------------------------------------

BEGIN TRANSACTION;

-- UPDATE PRODUCTS
-- SET StockQuantity = StockQuantity - 1
-- WHERE ProductID = 10;

SAVE TRANSACTION StockUpdated;

-- UPDATE CUSTOMERS
-- SET CITY = 'Istanbul'
-- WHERE ID = 1;

ROLLBACK TRANSACTION StockUpdated;

COMMIT;

------------------------------------------------------------------------------------------------
-- SAFETY NOTES
------------------------------------------------------------------------------------------------

-- Do not leave transactions open.
-- Long transactions can create locks and performance problems.
-- Keep transaction scope small and intentional.
-- Use SELECT first when the transaction changes important data.



BEGIN TRANSACTION;

BEGIN TRY

-- UPDATE CUSTOMERS
-- SET BALANCE = BALANCE - 100
-- WHERE ID = 1001

-- UPDATE CUSTOMERS
-- SET BALANCE = BALANCE + 100
-- WHERE ID = 2002

COMMIT TRANSACTION

END TRY

BEGIN CATCH

ROLLBACK TRANSACTION UpdateCustomerBalance

END CATCH




