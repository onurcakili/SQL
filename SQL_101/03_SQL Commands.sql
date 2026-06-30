------------------------------------------------------------------------------------------------
-- SQL KOMUT TİPLERİ
------------------------------------------------------------------------------------------------

-- 1. DDL (Data Definition Language)
--    Veritabanı ve tablo gibi yapıları oluşturmak, değiştirmek veya silmek için kullanılır.
--    Örnek komutlar: CREATE, ALTER, DROP, TRUNCATE

-- 2. DML (Data Manipulation Language)
--    Tablo içerisindeki verileri eklemek, güncellemek veya silmek için kullanılır.
--    Örnek komutlar: INSERT, UPDATE, DELETE

-- 3. DQL (Data Query Language)
--    Verileri sorgulamak için kullanılır.
--    Örnek komut: SELECT

-- 4. DCL (Data Control Language)
--    Yetkilendirme işlemleri için kullanılır.
--    Örnek komutlar: GRANT, REVOKE


------------------------------------------------------------------------------------------------
-- 1. DDL (DATA DEFINITION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- ETRADE veritabanını oluşturur.
CREATE DATABASE ETRADE;
GO

-- ETRADE veritabanını kullanıma alır.
USE ETRADE;
GO

-- CUSTOMERS tablosunu oluşturur.
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

-- CUSTOMERS tablosuna NATION kolonu ekler.
ALTER TABLE CUSTOMERS
ADD NATION VARCHAR(50);

-- CUSTOMERS tablosundan NATION kolonunu siler.
ALTER TABLE CUSTOMERS
DROP COLUMN NATION;

-- CUSTOMERS tablosuna birden fazla kolon ekler.
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

-- ID değeri 18 olan kaydı siler.
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Tablodaki tüm kayıtları siler.
TRUNCATE TABLE CUSTOMERS;


------------------------------------------------------------------------------------------------
-- 2. DML (DATA MANIPULATION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- INSERT KULLANIMI
------------------------------------------------------------------------------------------------

-- CUSTOMERS tablosuna tek kayıt ekler.
INSERT INTO CUSTOMERS
(ID, CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES 
(1, 'FATMA GÜR', 'ISTANBUL', '1990-10-15', 'CEKMEKOY', 'F');

-- ID kolonu belirtilmeden kayıt ekleme örneği.
-- Not: ID kolonu IDENTITY değilse bu sorgu hata verebilir.
INSERT INTO CUSTOMERS
(CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES 
('Cevher Tan', 'Istanbul', '1997-09-28', 'Beylikduzu', 'M');

-- CUSTOMERS tablosuna birden fazla kayıt ekler.
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


------------------------------------------------------------------------------------------------
-- UPDATE KULLANIMI
------------------------------------------------------------------------------------------------

-- Tüm müşterilerin NATION ve AGE bilgilerini günceller.
UPDATE CUSTOMERS
SET NATION = 'TR', AGE = 35;

-- BIRTHDATE kolonuna göre AGE kolonunu günceller.
UPDATE CUSTOMERS
SET AGE = DATEDIFF(YEAR, BIRTHDATE, GETDATE());

-- GENDER değeri M olan kayıtları MALE olarak günceller.
-- Not: GENDER kolonu CHAR(1) tanımlandığı için 'MALE' değeri için kolon tipi uygun değildir.
UPDATE CUSTOMERS
SET GENDER = 'MALE'
WHERE GENDER = ('M');

-- GENDER değeri F olan kayıtları FEMALE olarak günceller.
-- Not: GENDER kolonu CHAR(1) tanımlandığı için 'FEMALE' değeri için kolon tipi uygun değildir.
UPDATE CUSTOMERS
SET GENDER = 'FEMALE'
WHERE GENDER = ('F');


------------------------------------------------------------------------------------------------
-- DELETE KULLANIMI
------------------------------------------------------------------------------------------------

-- ID değeri 18 olan müşteriyi siler.
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Dikkat:
-- WHERE kullanılmadan DELETE yazılırsa tablodaki tüm kayıtlar silinir.
DELETE FROM CUSTOMERS;


------------------------------------------------------------------------------------------------
-- 3. DQL (DATA QUERY LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- SELECT KULLANIMI
------------------------------------------------------------------------------------------------

-- CUSTOMERS tablosundaki tüm kolonları getirir.
SELECT * 
FROM CUSTOMERS;

-- CUSTOMERS tablosundan belirli kolonları getirir.
SELECT 
    CUSTOMERNAME,
    CITY,
    DISTRICT
FROM CUSTOMERS;

-- Doğum tarihine göre yıl farkı hesaplar.
SELECT DATEDIFF(YEAR, '2000-01-01', '2025-01-01');

-- Bugünün tarihini getirir.
SELECT GETDATE();


------------------------------------------------------------------------------------------------
-- WHERE KULLANIMI
------------------------------------------------------------------------------------------------

-- CITY değeri ISTANBUL olan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL';

-- CITY değeri ISTANBUL olmayan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE CITY <> 'ISTANBUL';

-- NOT kullanımı da yukarıdaki sorguyla benzer anlamdadır.
SELECT * 
FROM CUSTOMERS
WHERE NOT CITY = 'ISTANBUL';

-- GENDER değeri F olan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE GENDER = 'F';

-- BIRTHDATE değeri 1995-01-01 tarihinden büyük olan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE > '1995-01-01';

-- SQL Server için tarih yazarken dil ayarlarından daha az etkilenmek adına
-- YYYYMMDD formatı tercih edilebilir.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE > '19950101';

-- ID değeri 18 olan müşteriyi getirir.
SELECT * 
FROM CUSTOMERS
WHERE ID = 18;


------------------------------------------------------------------------------------------------
-- AND VE OR OPERATÖRLERİ
------------------------------------------------------------------------------------------------

-- AND operatörü, tüm koşulların aynı anda sağlanmasını ister.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Istanbul' 
  AND DISTRICT = 'Kadikoy';

-- Bir kişinin ilçesi hem 'Kadikoy' hem de 'Beylikduzu' olamayacağı için
-- bu sorgu beklenen sonucu vermeyebilir.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Istanbul' 
  AND DISTRICT = 'Kadikoy' 
  AND DISTRICT = 'Beylikduzu';

-- OR operatörü, koşullardan en az birinin sağlanmasını ister.
-- Not: AND ve OR birlikte kullanılırken parantez kullanımı sorgunun okunabilirliğini artırır.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Istanbul' 
  AND DISTRICT = 'Kadikoy' 
   OR DISTRICT = 'Beylikduzu';

-- Birden fazla koşulun AND ile doğru kullanımı.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL' 
  AND GENDER = 'MALE'
  AND DISTRICT = 'Kadikoy';

-- CITY, GENDER ve BIRTHDATE koşullarını birlikte kullanır.
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'ISTANBUL'
  AND GENDER = 'MALE'
  AND BIRTHDATE BETWEEN '19950312' AND '19951231';

-- CITY değeri Istanbul veya Izmir olan kayıtları getirir.
-- Bu kullanım IN ile de yapılabilir: CITY IN ('Istanbul', 'Izmir')
SELECT * 
FROM CUSTOMERS
WHERE CITY = 'Istanbul' 
   OR CITY = 'Izmir'
ORDER BY CITY DESC, ID ASC;


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

-- AGE değeri 20 ile 30 arasında olan kayıtları getirir.
SELECT * 
FROM CUSTOMERS
WHERE AGE BETWEEN 20 AND 30;

-- Bu tarih aralığındakileri getirmez.
-- 1995 yılındaki belirtilen tarih aralığının dışında kalanları getirir.
SELECT * 
FROM CUSTOMERS
WHERE NOT BIRTHDATE BETWEEN '19950101' AND '19951231';

-- Yukarıdaki sorgunun operatörlerle yazılmış versiyonu.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE <= '19950101' 
   OR BIRTHDATE >= '19951231';


------------------------------------------------------------------------------------------------
-- ORDER BY KULLANIMI
------------------------------------------------------------------------------------------------

-- Sorgu sonucunu BIRTHDATE kolonuna göre küçükten büyüğe sıralar.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE ASC;

-- Sorgu sonucunu BIRTHDATE kolonuna göre büyükten küçüğe sıralar.
SELECT * 
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE DESC;

-- ASC  (Ascending)  = Küçükten büyüğe sıralama yapar.
-- DESC (Descending) = Büyükten küçüğe sıralama yapar.


------------------------------------------------------------------------------------------------
-- LIKE VE NOT LIKE KULLANIMI
------------------------------------------------------------------------------------------------

-- LIKE ifadesi, metinsel verilerde belirli bir desene göre arama yapmak için kullanılır.
-- % işareti, "burada herhangi bir karakter veya karakterler olabilir" anlamına gelir.

-- Ali ile başlayan müşterileri getirir.
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'Ali%';

-- Sonuç örnekleri:
-- Ali Faruk
-- Ali Sahin

-- Ali ile biten müşterileri getirir.
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE '%Ali';

-- Sonuç örneği:
-- Sabahattin Ali

-- İçerisinde An geçen müşterileri getirir.
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE '%An%';

-- Ali ile bitmeyen müşterileri getirir.
SELECT * 
FROM CUSTOMERS
WHERE CUSTOMERNAME NOT LIKE '%Ali';


------------------------------------------------------------------------------------------------
-- IN VE NOT IN KULLANIMI
------------------------------------------------------------------------------------------------

-- IN, bir kolonun birden fazla değerden herhangi birine eşit olup olmadığını kontrol eder.
-- Genelde birden fazla değeri karşılaştırmak için kullanılır.
SELECT * 
FROM CUSTOMERS
WHERE CITY IN ('ISTANBUL', 'ANKARA')
ORDER BY CITY;

-- NOT IN, belirtilen değerlerin dışında kalan kayıtları getirir.
SELECT * FROM CUSTOMERS
    WHERE CITY NOT IN ('ISTANBUL', 'ANKARA')
    ORDER BY CITY;


------------------------------------------------------------------------------------------------
-- DISTINCT KULLANIMI
------------------------------------------------------------------------------------------------

-- DISTINCT, tekrar eden satırları tekilleştirmek için kullanılır.

-- CITY kolonundaki tüm değerleri getirir.
SELECT 
    CITY 
FROM CUSTOMERS; -- 42 ROWS

-- CITY kolonundaki tekrar eden değerleri tekilleştirerek getirir.
SELECT DISTINCT CITY 
FROM CUSTOMERS; -- 20 ROWS

-- Kaç farklı şehir olduğunu sayar.
SELECT 
    COUNT(DISTINCT CITY) AS SehirSayisi
FROM CUSTOMERS;

-- GENDER kolonundaki farklı değerleri getirir.
SELECT 
    DISTINCT GENDER 
FROM CUSTOMERS; -- 2 ROWS

-- Birden fazla kolon için DISTINCT kullanımı.
-- CITY ve GENDER kombinasyonlarını tekilleştirir.
SELECT 
    DISTINCT CITY, GENDER 
FROM CUSTOMERS;


------------------------------------------------------------------------------------------------
-- TOP KULLANIMI
------------------------------------------------------------------------------------------------

-- TOP, sorgu sonucundan belirli sayıda kayıt getirmek için kullanılır.

-- İlk 10 kaydı getirir.
SELECT TOP 10 
    * 
FROM CUSTOMERS;

-- İlk 5 kaydı getirir.
SELECT TOP 5
    * 
FROM CUSTOMERS;

-- Kayıtların ilk yüzde 10'luk kısmını getirir.
SELECT TOP 10 PERCENT
    * 
FROM CUSTOMERS;

-- Kayıtların tamamını yüzde olarak getirir.
SELECT TOP 100 PERCENT
    * 
FROM CUSTOMERS;


------------------------------------------------------------------------------------------------
-- ID İLE KAYIT SORGULAMA VE SİLME
------------------------------------------------------------------------------------------------

-- ID değeri 18 olan müşteriyi getirir.
SELECT * 
FROM CUSTOMERS
    WHERE ID = 18;

-- ID değeri 18 olan müşteriyi siler.
DELETE FROM CUSTOMERS
    WHERE ID = 18;







---- aggregate fonc
-- SUM, MIN, MAX, AVG, COUNT



SELECT * FROM SALES

-- SATIR SAYDIRMAK
SELECT 
    COUNT(*) 
FROM SALES

-- AMOUNTA GÖRE SIRALA
SELECT * FROM SALES
ORDER BY AMOUNT


-- MIN AMOUNT GETİRMEK
SELECT
    MIN(AMOUNT)
FROM SALES

-- MAX AMOUNT GETIRMEK
SELECT
    MAX(AMOUNT)
FROM SALES

-- MIN. MAX, COUNTR BIRLIKTE
SELECT
    SUM(AMOUNT) AS TotalAmount,
    MIN(AMOUNT) as MinAmount,
    MAX(AMOUNT) as MaxAmount,
    COUNT(AMOUNT) as CountAmount
FROM SALES

SELECT
    AVG(AMOUNT) as AvgAmount
FROM SALES

