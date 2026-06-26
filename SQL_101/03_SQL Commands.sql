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

-- CUSTOMERS tablosundaki tüm verileri hızlıca siler.
-- Tablo yapısı kalır, sadece kayıtlar silinir.
TRUNCATE TABLE CUSTOMERS;

------------------------------------------------------------------------------------------------
-- DELETE VS TRUNCATE
------------------------------------------------------------------------------------------------

-- DELETE:
-- DML komutudur.
-- WHERE ile belirli kayıtlar silinebilir.
-- Tablo yapısını silmez.
-- Koşul verilmezse tablodaki tüm kayıtları siler.

-- TRUNCATE:
-- DDL komutudur.
-- WHERE ile kullanılamaz.
-- Tablodaki tüm kayıtları siler.
-- Tablo yapısını silmez.
-- DELETE'e göre genellikle daha hızlıdır.

-- Örnek DELETE:
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Örnek TRUNCATE:
TRUNCATE TABLE CUSTOMERS;

------------------------------------------------------------------------------------------------
-- 2. DML (DATA MANIPULATION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- CUSTOMERS tablosuna tek kayıt ekle
INSERT INTO CUSTOMERS
(ID, CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES 
(1, 'FATMA GÜR', 'ISTANBUL', '1990-10-15', 'CEKMEKOY', 'F');

-- CUSTOMERS tablosuna birden fazla kayıt ekle
INSERT INTO CUSTOMERS
(ID, CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES
(2, 'Ahmet Yilmaz', 'Istanbul', '1995-03-12', 'Kadikoy', 'M'),
(3, 'Ayse Demir', 'Ankara', '1998-07-25', 'Cankaya', 'F'),
(4, 'Mehmet Kaya', 'Izmir', '1992-11-08', 'Bornova', 'M'),
(5, 'Fatma Celik', 'Bursa', '1997-05-17', 'Nilufer', 'F'),
(6, 'Ali Sahin', 'Antalya', '1990-01-20', 'Muratpasa', 'M'),
(7, 'Zeynep Arslan', 'Adana', '1999-09-14', 'Seyhan', 'F'),
(8, 'Mustafa Koc', 'Konya', '1994-04-03', 'Selcuklu', 'M'),
(9, 'Elif Aydin', 'Gaziantep', '1996-12-29', 'Sehitkamil', 'F'),
(10, 'Hasan Kurt', 'Kayseri', '1991-08-15', 'Melikgazi', 'M'),
(11, 'Merve Oz', 'Mersin', '2000-02-10', 'Yenisehir', 'F'),
(12, 'Emre Yildiz', 'Samsun', '1993-06-21', 'Atakum', 'M'),
(13, 'Busra Ak', 'Trabzon', '1997-01-13', 'Ortahisar', 'F'),
(14, 'Onur Polat', 'Eskisehir', '1994-10-09', 'Tepebasi', 'M'),
(15, 'Derya Tas', 'Kocaeli', '1998-03-04', 'Izmit', 'F'),
(16, 'Can Karaca', 'Sakarya', '1991-07-19', 'Adapazari', 'M'),
(17, 'Seda Eren', 'Hatay', '1999-11-22', 'Iskenderun', 'F'),
(18, 'Burak Yalcin', 'Malatya', '1996-08-30', 'Battalgazi', 'M'),
(19, 'Ece Gunes', 'Denizli', '1995-05-11', 'Pamukkale', 'F'),
(20, 'Serkan Turan', 'Balikesir', '1993-02-17', 'Karesi', 'M'),
(21, 'Gizem Korkmaz', 'Tekirdag', '1997-09-28', 'Suleymanpasa', 'F'),
(22, 'Sabahattin Ali', 'Tekirdag', '1997-09-28', 'Suleymanpasa', 'M'),
(23, 'Ali Faruk', 'Tekirdag', '1997-09-28', 'Suleymanpasa', 'M');

-- Tüm müşterilerin NATION ve AGE bilgilerini güncelle
UPDATE CUSTOMERS
SET NATION = 'TR', AGE = 35;

-- BIRTHDATE kolonuna göre AGE kolonunu güncelle
UPDATE CUSTOMERS
SET AGE = DATEDIFF(YEAR, BIRTHDATE, GETDATE());

-- GENDER değeri M olan kayıtları MALE olarak güncelle
UPDATE CUSTOMERS
SET GENDER = 'MALE'
WHERE GENDER IN ('M');

-- GENDER değeri F olan kayıtları FEMALE olarak güncelle
UPDATE CUSTOMERS
SET GENDER = 'FEMALE'
WHERE GENDER IN ('F');

-- ID değeri 18 olan müşteriyi sil
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Dikkat:
-- WHERE kullanılmadan DELETE yazılırsa tablodaki tüm kayıtlar silinir.
DELETE FROM CUSTOMERS;

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

-- Doğum tarihine göre yıl farkı hesapla
SELECT DATEDIFF(YEAR, '2000-01-01', '2025-01-01');

-- Bugünün tarihini getir
SELECT GETDATE();

------------------------------------------------------------------------------------------------
-- WHERE KULLANIMI
------------------------------------------------------------------------------------------------

-- CITY değeri ISTANBUL olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL';

-- CITY değeri ISTANBUL olmayan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE CITY <> 'ISTANBUL';

-- NOT kullanımı da yukarıdaki sorguyla benzer anlamdadır.
SELECT * 
FROM CUSTOMERS
WHERE NOT CITY = 'ISTANBUL';

-- CITY değeri ISTANBUL ve DISTRICT değeri Kadikoy olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL' 
  AND DISTRICT = 'Kadikoy';

-- CITY değeri ISTANBUL veya Izmir olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL' 
   OR CITY = 'Izmir';

-- GENDER değeri F olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE GENDER = 'F';

-- BIRTHDATE değeri 1995-01-01 tarihinden büyük olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE > '1995-01-01';

-- SQL Server için tarih yazarken dil ayarlarından daha az etkilenmek adına
-- YYYYMMDD formatı tercih edilebilir.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE > '19950101';

------------------------------------------------------------------------------------------------
-- BETWEEN KULLANIMI
------------------------------------------------------------------------------------------------

-- BETWEEN, verilen iki sınır değeri de dahil eder.
-- Yani BETWEEN '19900101' AND '19931231' yazıldığında
-- 1990-01-01 ve 1993-12-31 tarihleri de sonuca dahil edilir.

SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231';

-- > ve < kullanımında sınır değerler dahil değildir.
-- Örneğin BIRTHDATE > '19900101' yazılırsa,
-- BIRTHDATE değeri tam olarak 1990-01-01 olan kişi sonuca gelmez.

SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE > '19900101'
  AND BIRTHDATE < '19931231';

-- AGE değeri 20 ile 30 arasında olan kayıtları getir
SELECT * 
FROM CUSTOMERS
WHERE AGE BETWEEN 20 AND 30;

------------------------------------------------------------------------------------------------
-- ORDER BY KULLANIMI
------------------------------------------------------------------------------------------------

-- Sorgu sonucunu BIRTHDATE kolonuna göre küçükten büyüğe sırala
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE asc;

-- Sorgu sonucunu BIRTHDATE kolonuna göre büyükten küçüğe sırala
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE DESC;

-- ASC (Ascending)   = Kucukten buyuge sıralama yapar.
-- DESC (Descending) = Buyukten kucuge sıralama yapar.


------------------------------------------------------------------------------------------------
-- LIKE, NOT LIKE, IN, NOT IN KULLANIMI
------------------------------------------------------------------------------------------------

-- LIKE ifadesi, metinsel verilerde belirli bir desene göre arama yapmak için kullanılır.
-- % işareti, "burada herhangi bir karakter veya karakterler olabilir" anlamına gelir.

-- Ali ile başlayan müşterileri getir
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'Ali%';

-- Sonucu örnek:
-- Ali Faruk
-- Ali Sahin

-- Ali ile biten müşterileri getir
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE '%Ali';

-- Sonucu örnek:
-- Sabahattin Ali

-- İçerisinde An geçen müşterileri getir
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE '%An%';

-- Ali ile bitmeyen müşterileri getir
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME NOT LIKE '%Ali';

------------------------------------------------------------------------------------------------
-- IN KULLANIMI
------------------------------------------------------------------------------------------------

-- IN, bir kolonun birden fazla değerden herhangi birine eşit olup olmadığını kontrol eder.
-- Genelde birden fazla değeri karşılaştırmak için kullanılır.

SELECT * 
FROM CUSTOMERS
WHERE CITY IN ('ISTANBUL', 'ANKARA')
ORDER BY CITY;

-- NOT IN, belirtilen değerlerin dışında kalan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE CITY NOT IN ('ISTANBUL', 'ANKARA')
ORDER BY CITY;

------------------------------------------------------------------------------------------------
-- ID İLE KAYIT SORGULAMA VE SİLME
------------------------------------------------------------------------------------------------

-- ID değeri 18 olan müşteriyi getir
SELECT * 
FROM CUSTOMERS
WHERE ID = 18;

-- ID değeri 18 olan müşteriyi sil
DELETE FROM CUSTOMERS
WHERE ID = 18;

