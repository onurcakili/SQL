------------------------------------------------------------------------------------------------
-- SQL Komut Tipleri
------------------------------------------------------------------------------------------------

-- 1. DDL (Data Definition Language)      : CREATE, ALTER, DROP, TRUNCATE
-- 2. DML (Data Manipulation Language)    : INSERT, UPDATE, DELETE
-- 3. DQL (Data Query Language)           : SELECT
-- 4. DCL (Data Control Language)         : GRANT, REVOKE
-- 5. TCL (Transaction Control Language)  : BEGIN TRANSACTION, COMMIT, ROLLBACK, SAVEPOINT

------------------------------------------------------------------------------------------------
-- 1. DDL (DATA DEFINITION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- ETRADE veritabanını oluştur
CREATE DATABASE ETRADE;
GO

-- ETRADE veritabanını kullan
USE ETRADE;
GO

-- CUSTOMERS tablosunu oluştur
CREATE TABLE CUSTOMERS
(
    ID INT PRIMARY KEY,
    CUSTOMERNAME VARCHAR(50),
    CITY VARCHAR(50),
    BIRTHDATE DATE,
    DISTRICT VARCHAR(50),
    GENDER CHAR(1)
);
GO

-- CUSTOMERS tablosuna NATION kolonu ekle
ALTER TABLE CUSTOMERS
ADD NATION VARCHAR(50);

-- CUSTOMERS tablosundan NATION kolonunu sil
ALTER TABLE CUSTOMERS
DROP COLUMN NATION;

-- CUSTOMERS tablosuna birden fazla kolon ekle
ALTER TABLE CUSTOMERS
ADD
    NATION VARCHAR(50),
    AGE INT;

------------------------------------------------------------------------------------------------
-- 2. DML (DATA MANIPULATION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- CUSTOMERS tablosuna tek kayıt ekle
INSERT INTO CUSTOMERS
(CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES 
('FATMA GÜR', 'ISTANBUL', '1990-10-15', 'CEKMEKOY', 'F');

-- CUSTOMERS tablosuna birden fazla kayıt ekle
INSERT INTO CUSTOMERS
(CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES
('Ahmet Yilmaz', 'Istanbul', '1995-03-12', 'Kadikoy', 'M'),
('Ayse Demir', 'Ankara', '1998-07-25', 'Cankaya', 'F'),
('Mehmet Kaya', 'Izmir', '1992-11-08', 'Bornova', 'M'),
('Fatma Celik', 'Bursa', '1997-05-17', 'Nilufer', 'F'),
('Ali Sahin', 'Antalya', '1990-01-20', 'Muratpasa', 'M'),
('Zeynep Arslan', 'Adana', '1999-09-14', 'Seyhan', 'F'),
('Mustafa Koc', 'Konya', '1994-04-03', 'Selcuklu', 'M'),
('Elif Aydin', 'Gaziantep', '1996-12-29', 'Sehitkamil', 'F'),
('Hasan Kurt', 'Kayseri', '1991-08-15', 'Melikgazi', 'M'),
('Merve Oz', 'Mersin', '2000-02-10', 'Yenisehir', 'F'),
('Emre Yildiz', 'Samsun', '1993-06-21', 'Atakum', 'M'),
('Busra Ak', 'Trabzon', '1997-01-13', 'Ortahisar', 'F'),
('Onur Polat', 'Eskisehir', '1994-10-09', 'Tepebasi', 'M'),
('Derya Tas', 'Kocaeli', '1998-03-04', 'Izmit', 'F'),
('Can Karaca', 'Sakarya', '1991-07-19', 'Adapazari', 'M'),
('Seda Eren', 'Hatay', '1999-11-22', 'Iskenderun', 'F'),
('Burak Yalcin', 'Malatya', '1996-08-30', 'Battalgazi', 'M'),
('Ece Gunes', 'Denizli', '1995-05-11', 'Pamukkale', 'F'),
('Serkan Turan', 'Balikesir', '1993-02-17', 'Karesi', 'M'),
('Gizem Korkmaz', 'Tekirdag', '1997-09-28', 'Suleymanpasa', 'F');

-- Tüm müşterilerin NATION ve AGE bilgilerini güncelle
UPDATE CUSTOMERS
SET NATION = 'TR', AGE = 35;

-- Doğum tarihine göre yaş hesapla
SELECT DATEDIFF(YEAR, '2000-01-01', '2025-01-01');

-- Bugünün tarihini getir
SELECT GETDATE();

-- BIRTHDATE kolonuna göre AGE kolonunu güncelle
UPDATE CUSTOMERS
SET AGE = DATEDIFF(YEAR, BIRTHDATE, GETDATE());

------------------------------------------------------------------------------------------------
-- 3. DQL (DATA QUERY LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- CUSTOMERS tablosundaki tüm kolonları getir
SELECT * 
FROM CUSTOMERS;

-- CUSTOMERS tablosundan belirli kolonları getir
SELECT 
    CUSTOMERNAME,
    CITY,
    DISTRICT
FROM CUSTOMERS;

