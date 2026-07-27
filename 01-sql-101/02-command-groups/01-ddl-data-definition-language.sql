------------------------------------------------------------------------------------------------
-- DDL (DATA DEFINITION LANGUAGE)
------------------------------------------------------------------------------------------------
-- DDL defines database objects. CREATE, ALTER, DROP, and TRUNCATE shape databases,
-- tables, columns, and other database structures.
--
-- In data work, DDL matters because the table design decides how safely and accurately
-- future analysis can be done.
--
-- 1. DDL (DATA DEFINITION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- ETRADE adında yeni bir veritabanı oluşturur.
CREATE DATABASE ETRADE;
GO

-- ETRADE veritabanını kullanıma alır.
-- Bu satırdan sonra çalıştırılan komutlar ETRADE veritabanı üzerinde işlem yapar.
USE ETRADE;
GO

-- CUSTOMERS tablosunu oluşturur.
-- PRIMARY KEY, her kaydın benzersiz şekilde tanımlanmasını sağlar.
CREATE TABLE CUSTOMERS
(
    ID INT PRIMARY KEY,
    CUSTOMERNAME VARCHAR(50),
    CITY VARCHAR(50),
    BIRTHDATE DATE,
    DISTRICT VARCHAR(50),
    GENDER VARCHAR(10)
);
GO

-- CUSTOMERS tablosuna NATION kolonu ekler.
ALTER TABLE CUSTOMERS
ADD NATION VARCHAR(50);

-- CUSTOMERS tablosundan NATION kolonunu siler.
-- DROP COLUMN, tablo yapısından ilgili kolonu tamamen kaldırır.
ALTER TABLE CUSTOMERS
DROP COLUMN NATION;

-- CUSTOMERS tablosuna birden fazla kolon ekler.
ALTER TABLE CUSTOMERS
ADD
    NATION VARCHAR(50),
    AGE INT;

-- CUSTOMERS tablosundaki tüm kayıtları hızlıca siler.
-- Tablo yapısı kalır, sadece veriler silinir.
-- Not: TRUNCATE TABLE, WHERE şartı ile kullanılamaz.
TRUNCATE TABLE CUSTOMERS;


------------------------------------------------------------------------------------------------
-- DELETE VS TRUNCATE
------------------------------------------------------------------------------------------------

-- DELETE:
-- DML komutudur.
-- WHERE ile belirli kayıtlar silinebilir.
-- Tablo yapısını silmez.
-- WHERE kullanılmazsa tablodaki tüm kayıtları siler.

-- TRUNCATE:
-- DDL komutudur.
-- WHERE ile kullanılamaz.
-- Tablodaki tüm kayıtları siler.
-- Tablo yapısını silmez.
-- DELETE'e göre genellikle daha hızlıdır.

-- ID değeri 18 olan kaydı siler.
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Tablodaki tüm kayıtları siler.
TRUNCATE TABLE CUSTOMERS;


------------------------------------------------------------------------------------------------
