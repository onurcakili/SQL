------------------------------------------------------------------------------------------------
-- DQL (DATA QUERY LANGUAGE)
------------------------------------------------------------------------------------------------
-- DQL reads and analyzes data. SELECT is the center of this family, and it grows with
-- WHERE, ORDER BY, GROUP BY, HAVING, aggregate functions, aliases, and joins.
--
-- For data analysis, DQL is where business questions become repeatable queries.
--
-- 3. DQL (DATA QUERY LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- SELECT KULLANIMI
------------------------------------------------------------------------------------------------

-- SELECT komutu tablodaki verileri sorgulamak için kullanılır.

-- CUSTOMERS tablosundaki tüm kolonları getirir.
SELECT *
FROM CUSTOMERS;

-- CUSTOMERS tablosundan belirli kolonları getirir.
SELECT
    CUSTOMERNAME,
    CITY,
    DISTRICT
FROM CUSTOMERS;

-- Doğum tarihine göre iki tarih arasındaki yıl farkını hesaplar.
SELECT DATEDIFF(YEAR, '2000-01-01', '2025-01-01') AS YearDifference;

-- Bugünün tarih ve saat bilgisini getirir.
SELECT GETDATE() AS CurrentDateTime;


------------------------------------------------------------------------------------------------
-- WHERE KULLANIMI
------------------------------------------------------------------------------------------------

-- WHERE, sorgu sonucunu belirli bir koşula göre filtrelemek için kullanılır.

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

-- GENDER değeri FEMALE olan kayıtları getirir.
SELECT *
FROM CUSTOMERS
WHERE GENDER = 'FEMALE';

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

-- Bir kişinin ilçesi aynı anda hem Kadikoy hem Beylikduzu olamayacağı için
-- bu sorgu sonuç döndürmez.
SELECT *
FROM CUSTOMERS
WHERE CITY = 'Istanbul'
  AND DISTRICT = 'Kadikoy'
  AND DISTRICT = 'Beylikduzu';

-- OR operatörü, koşullardan en az birinin sağlanmasını ister.
-- AND ve OR birlikte kullanılırken parantez kullanmak sonucu daha okunabilir hale getirir.
SELECT *
FROM CUSTOMERS
WHERE CITY = 'Istanbul'
  AND (DISTRICT = 'Kadikoy' OR DISTRICT = 'Beylikduzu');

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
-- Bu kullanım IN ile de yapılabilir.
SELECT *
FROM CUSTOMERS
WHERE CITY = 'Istanbul'
   OR CITY = 'Izmir'
ORDER BY CITY DESC, ID ASC;


------------------------------------------------------------------------------------------------
-- BETWEEN KULLANIMI
------------------------------------------------------------------------------------------------

-- BETWEEN, verilen iki sınır değeri de dahil eder.
SELECT *
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231';

-- > ve < kullanımında sınır değerler dahil değildir.
SELECT *
FROM CUSTOMERS
WHERE BIRTHDATE > '19900101'
  AND BIRTHDATE < '19931231';

-- AGE değeri 20 ile 30 arasında olan kayıtları getirir.
SELECT *
FROM CUSTOMERS
WHERE AGE BETWEEN 20 AND 30;

-- 1995 yılı içerisindeki belirtilen tarih aralığının dışında kalan kayıtları getirir.
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

-- ORDER BY, sorgu sonucunu belirli bir kolona göre sıralamak için kullanılır.

-- BIRTHDATE kolonuna göre küçükten büyüğe sıralar.
SELECT *
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE ASC;

-- BIRTHDATE kolonuna göre büyükten küçüğe sıralar.
SELECT *
FROM CUSTOMERS
WHERE BIRTHDATE BETWEEN '19900101' AND '19931231'
ORDER BY BIRTHDATE DESC;

-- ASC  (Ascending)  = Küçükten büyüğe sıralama yapar.
-- DESC (Descending) = Büyükten küçüğe sıralama yapar.


------------------------------------------------------------------------------------------------
-- LIKE VE NOT LIKE KULLANIMI
------------------------------------------------------------------------------------------------

-- LIKE, metinsel verilerde belirli bir desene göre arama yapmak için kullanılır.
-- % işareti, bulunduğu yerde herhangi bir karakter veya karakterler olabilir anlamına gelir.

-- Ali ile başlayan müşterileri getirir.
SELECT *
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'Ali%';

-- Ali ile biten müşterileri getirir.
SELECT *
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE '%Ali';

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
-- DISTINCT KULLANIMI
------------------------------------------------------------------------------------------------

-- DISTINCT, tekrar eden satırları tekilleştirmek için kullanılır.

-- CITY kolonundaki tüm değerleri getirir.
SELECT
    CITY
FROM CUSTOMERS;

-- CITY kolonundaki tekrar eden değerleri tekilleştirerek getirir.
SELECT DISTINCT
    CITY
FROM CUSTOMERS;

-- Kaç farklı şehir olduğunu sayar.
SELECT
    COUNT(DISTINCT CITY) AS SehirSayisi
FROM CUSTOMERS;

-- GENDER kolonundaki farklı değerleri getirir.
SELECT DISTINCT
    GENDER
FROM CUSTOMERS;

-- CITY ve GENDER kombinasyonlarını tekilleştirir.
SELECT DISTINCT
    CITY,
    GENDER
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
-- Bu örnek DELETE komutunu tekrar hatırlatmak için burada gösterilmiştir.
DELETE FROM CUSTOMERS
WHERE ID = 18;


------------------------------------------------------------------------------------------------
-- 4. AGGREGATE FUNCTIONS
------------------------------------------------------------------------------------------------

-- Aggregate function, birden fazla satır üzerinde hesaplama yapıp tek bir sonuç döndürür.
--
-- Sık kullanılan aggregate function'lar:
-- SUM   : Toplam alır.
-- MIN   : En küçük değeri getirir.
-- MAX   : En büyük değeri getirir.
-- AVG   : Ortalama hesaplar.
-- COUNT : Satır veya değer sayar.


------------------------------------------------------------------------------------------------
-- SALES TABLOSU ÜZERİNDE TEMEL SORGULAR
------------------------------------------------------------------------------------------------

-- SALES tablosundaki tüm kayıtları getirir.
SELECT
    *
FROM SALES;

-- SALES tablosundaki toplam satır sayısını getirir.
SELECT
    COUNT(*) AS RowCount
FROM SALES;

-- SALES tablosunu AMOUNT kolonuna göre küçükten büyüğe sıralar.
SELECT
    *
FROM SALES
ORDER BY AMOUNT;


------------------------------------------------------------------------------------------------
-- MIN, MAX, SUM, COUNT VE AVG KULLANIMI
------------------------------------------------------------------------------------------------

-- SALES tablosundaki en küçük AMOUNT değerini getirir.
SELECT
    MIN(AMOUNT) AS MinAmount
FROM SALES;

-- SALES tablosundaki en büyük AMOUNT değerini getirir.
SELECT
    MAX(AMOUNT) AS MaxAmount
FROM SALES;

-- SUM, MIN, MAX ve COUNT fonksiyonlarını birlikte kullanır.
SELECT
    SUM(AMOUNT) AS TotalAmount,
    MIN(AMOUNT) AS MinAmount,
    MAX(AMOUNT) AS MaxAmount,
    COUNT(AMOUNT) AS CountAmount
FROM SALES;

-- AMOUNT kolonunun ortalamasını getirir.
SELECT
    AVG(AMOUNT) AS AvgAmount
FROM SALES;


------------------------------------------------------------------------------------------------
-- WHERE İLE AGGREGATE FUNCTION KULLANIMI
------------------------------------------------------------------------------------------------

-- CATEGORY değeri Elektronik olan ürünlerin toplam stok miktarını getirir.
SELECT
    SUM(STOCK) AS ElektronikToplamStok
FROM ITEMS
WHERE CATEGORY = 'Elektronik';


------------------------------------------------------------------------------------------------
-- CONVERT KULLANIMI
------------------------------------------------------------------------------------------------

-- CONVERT, veri tiplerini dönüştürmek için kullanılır.
-- Aşağıdaki örnekte SALEDATE kolonundan tarih, saat ve tarih-saat bilgileri ayrı ayrı alınır.

SELECT
    CONVERT(DATE, SALEDATE) AS SaleDate,
    CONVERT(TIME, SALEDATE) AS SaleTime,
    CONVERT(DATETIME, SALEDATE) AS SaleDateTime,
    *
FROM SALES;

-- TOTALPRICE kolonunu sorgu sonucunda en başta göstermek için kullanılır.
SELECT
    TOTALPRICE,
    *
FROM SALES;

-- SALEDATE kolonundan tarih ve saat bilgilerini ayrı ayrı getirir.
-- Not: Bu sorgunun çalışması için SALES tablosunda CATEGORY kolonu bulunmalıdır.
SELECT
    CONVERT(DATE, SALEDATE) AS SaleDate,
    CONVERT(TIME, SALEDATE) AS SaleTime,
    *
FROM SALES
WHERE CATEGORY = 'Elektronik';

------------------------------------------------------------------------------------------------
-- DATEPART, DATENAME VE DATEFROMPARTS KULLANIMI
------------------------------------------------------------------------------------------------

-- DATEPART, tarihin yıl, ay, gün gibi parçalarını sayısal olarak döndürür.
-- DATENAME, tarihin ay veya haftanın günü gibi parçalarını metinsel olarak döndürür.
-- DATEFROMPARTS, yıl, ay ve gün değerlerinden yeni bir DATE üretir.

SELECT
    SALEDATE,

    DATEPART(YEAR, SALEDATE) AS SaleYear,
    -- Örnek çıktı: 2026

    DATEPART(MONTH, SALEDATE) AS SaleMonth,
    -- Örnek çıktı: 1, 2, 3 ... 12

    DATENAME(MONTH, SALEDATE) AS MonthName,
    -- Örnek çıktı: January, February, March ...

    DATENAME(WEEKDAY, SALEDATE) AS DayName,
    -- Örnek çıktı: Monday, Tuesday, Wednesday ...

    DATEFROMPARTS(
        YEAR(SALEDATE),
        MONTH(SALEDATE),
        1
    ) AS YearMonth
    -- Örnek çıktı: 2026-01-01, 2026-02-01, 2026-03-01 ...

FROM SALES;


------------------------------------------------------------------------------------------------
-- RAPORLAMA İÇİN YARDIMCI KOLON EKLEME
------------------------------------------------------------------------------------------------

-- SALES tablosuna ay adı ve yıl bilgisini tutacak iki yeni kolon eklenir.
-- Bu işlem DDL kapsamındadır; ancak raporlama akışını tamamladığı için burada gösterilmiştir.

SELECT *
FROM SALES;

ALTER TABLE SALES
ADD MONTHNAME_ VARCHAR(20),
    YEAR_ INT;

-- MONTHNAME_ kolonuna satış tarihinin ay adı yazılır.
UPDATE SALES
SET MONTHNAME_ = DATENAME(MONTH, SALEDATE);

-- YEAR_ kolonuna satış tarihinin yıl bilgisi yazılır.
UPDATE SALES
SET YEAR_ = DATEPART(YEAR, SALEDATE);


------------------------------------------------------------------------------------------------
-- TARİH FONKSİYONLARI KISA ÖRNEKLER
------------------------------------------------------------------------------------------------

-- Yıl bilgisini getirir.
SELECT DATEPART(YEAR, '1990-03-15') AS YearValue;

-- Ay bilgisini getirir.
SELECT DATEPART(MONTH, '1990-03-15') AS MonthValue;

-- Gün bilgisini getirir.
SELECT DATEPART(DAY, '1990-03-15') AS DayValue;

-- Ay adını getirir.
SELECT DATENAME(MONTH, '1990-03-15') AS MonthName;

-- Haftanın gün adını getirir.
SELECT DATENAME(WEEKDAY, '1990-03-15') AS WeekDayName;

-- Yıl, ay ve gün değerlerinden yeni bir tarih oluşturur.
SELECT DATEFROMPARTS(1990, 3, 1) AS FirstDayOfMonth;


------------------------------------------------------------------------------------------------
-- GROUP BY KULLANIMI
------------------------------------------------------------------------------------------------

-- GROUP BY, kayıtları belirli kolonlara veya hesaplanmış değerlere göre gruplamak için kullanılır.
-- Genellikle SUM, COUNT, AVG, MIN, MAX gibi aggregate function'lar ile birlikte kullanılır.
--
-- Temel kural:
-- SELECT kısmında aggregate function dışında yazılan her kolon,
-- GROUP BY kısmında da yer almalıdır.
--
-- WHERE ve HAVING farkı:
-- WHERE, satırları gruplamadan önce filtreler.
-- HAVING, gruplama yapıldıktan sonra oluşan sonuç gruplarını filtreler.


------------------------------------------------------------------------------------------------
-- KATEGORİ BAZINDA GROUP BY
------------------------------------------------------------------------------------------------

-- Kategori bazında toplam stok miktarını getirir.
SELECT
    CATEGORY,
    SUM(STOCK) AS SumStock
FROM ITEMS
GROUP BY CATEGORY
ORDER BY SumStock;

-- Toplam stok miktarına göre ilk 3 kategoriyi getirir.
SELECT TOP 3
    CATEGORY,
    SUM(STOCK) AS SumStock
FROM ITEMS
GROUP BY CATEGORY
ORDER BY SumStock;


------------------------------------------------------------------------------------------------
-- ŞEHİR VE TARİH BAZINDA GROUP BY
------------------------------------------------------------------------------------------------

-- Şehir ve tarih bazında toplam satış tutarını getirir.
-- Not: Bu sorgunun çalışması için SALES tablosunda CITIES, DATE2 ve TOTALPRICE kolonları bulunmalıdır.
SELECT
    CITIES,
    DATE2,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
WHERE CITIES = 'ANKARA'
GROUP BY CITIES, DATE2
ORDER BY CITIES, DATE2;


------------------------------------------------------------------------------------------------
-- FORMAT İLE AYLIK SATIŞ RAPORU
------------------------------------------------------------------------------------------------

-- FORMAT ile SALEDATE alanı yıl-ay formatına çevrilir.
-- Böylece satışlar ay bazında gruplanır.
-- Not: FORMAT okunabilirliği artırır fakat büyük veri setlerinde performans maliyeti olabilir.
SELECT
    FORMAT(SALEDATE, 'yyyy-MM') AS YearMonth,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY FORMAT(SALEDATE, 'yyyy-MM')
ORDER BY FORMAT(SALEDATE, 'yyyy-MM');


------------------------------------------------------------------------------------------------
-- DATEFROMPARTS İLE AYLIK SATIŞ RAPORU
------------------------------------------------------------------------------------------------

-- DATEFROMPARTS ile her satış tarihi ilgili ayın ilk gününe çekilir.
-- Bu yöntem, FORMAT kullanımına göre performans açısından daha avantajlı.
SELECT
    DATEFROMPARTS(YEAR(SALEDATE), MONTH(SALEDATE), 1) AS YearMonth,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY DATEFROMPARTS(YEAR(SALEDATE), MONTH(SALEDATE), 1)
ORDER BY YearMonth;


------------------------------------------------------------------------------------------------
-- AY İSMİYLE GROUP BY
------------------------------------------------------------------------------------------------

-- Ay ismini de rapora eklemek için DATENAME kullanılır.
-- Gruplama yine DATEFROMPARTS üzerinden yapılır.
SELECT
    DATEFROMPARTS(YEAR(SALEDATE), MONTH(SALEDATE), 1) AS YearMonth,
    DATENAME(MONTH, DATEFROMPARTS(YEAR(SALEDATE), MONTH(SALEDATE), 1)) AS MonthName,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY DATEFROMPARTS(YEAR(SALEDATE), MONTH(SALEDATE), 1)
ORDER BY YearMonth;


------------------------------------------------------------------------------------------------
-- YIL VE AY KOLONLARI İLE GROUP BY
------------------------------------------------------------------------------------------------

-- Daha önce SALES tablosuna MONTHNAME_ ve YEAR_ kolonları eklenmişse,
-- bu kolonlar üzerinden yıl ve ay bazında raporlama yapılabilir.
SELECT
    YEAR_,
    MONTHNAME_,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY
    YEAR_,
    MONTHNAME_;


------------------------------------------------------------------------------------------------
-- HAVING KULLANIMI
------------------------------------------------------------------------------------------------

-- HAVING, aggregate function sonucu üzerinden filtreleme yapmak için kullanılır.
-- Aşağıdaki sorgu yıl ve ay bazında satışları gruplar,
-- toplam satış tutarı 50000'den büyük olan grupları getirir.
SELECT
    YEAR_,
    MONTHNAME_,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY
    YEAR_,
    MONTHNAME_
HAVING SUM(TOTALPRICE) > 50000;


------------------------------------------------------------------------------------------------
-- MÜŞTERİ BAZINDA GROUP BY
------------------------------------------------------------------------------------------------

-- Her müşterinin toplam satış tutarını getirir.
SELECT
    CUSTOMERID,
    SUM(TOTALPRICE) AS TotalPrice
FROM SALES
GROUP BY CUSTOMERID
ORDER BY CUSTOMERID;


------------------------------------------------------------------------------------------------
-- (EKSTRA) TABLO VE KOLON BİLGİLERİNİ İNCELEME 
------------------------------------------------------------------------------------------------

-- SALES tablosundaki AMOUNT kolonunun veri tipini getirir.
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SALES'
  AND COLUMN_NAME = 'AMOUNT';

-- Veritabanındaki nesneler hakkında genel bilgi verir.
EXEC sp_help;

-- SALES tablosu hakkında detaylı bilgi verir.
EXEC sp_help 'SALES';

-- SALES tablosunu tekrar kontrol eder.
SELECT *
FROM SALES;


------------------------------------------------------------------------------------------------

-- ALIAS KULLANIMI
SELECT 
    U.NAMESURNAME, 
    U.EMAIL, 
    O.TOTALPRICE
FROM ORDERS O, USERS U
WHERE O.USERID = U.ID
AND
U.ID = 1



-- AS ILE ORNEK

SELECT 
    U.NAMESURNAME AS KULLANICIADI, 
    U.EMAIL AS KULLANICIEMAIL, 
    O.TOTALPRICE AS TOPLAMTUTAR 
FROM ORDERS O, USERS U
WHERE O.USERID = U.ID
AND
U.ID = 1



---------------------
-- JOIN Kavramları--
---------------------


-- INNER JOIN : (KESİŞİM) İki tabloda da eşleşen kayıtları getirmek için kullanılır.

-- LEFT JOIN : Sol tablodaki tüm kayıtları ve sağ tabloda eşleşen kayıtları getirmek için kullanılır.
-- Sağ tabloda eşleşme yoksa ilgili alanlar NULL gelir.

-- RIGHT JOIN : Sağ tablodaki tüm kayıtları ve sol tabloda eşleşen kayıtları getirmek için kullanılır.
-- Sol tabloda eşleşme yoksa ilgili alanlar NULL gelir.

-- FULL OUTER JOIN : Her iki tablodaki tüm kayıtları getirmek için kullanılır.
-- Eşleşmeyen tarafın alanları NULL gelir.

-- CROSS JOIN : İki tablodaki tüm kayıtların birbiriyle kombinasyonunu oluşturmak için kullanılır.
-- Örneğin bir tabloda 3, diğerinde 4 kayıt varsa sonuç 12 satır olur.

-- SELF JOIN : Bir tabloyu yine kendisiyle birleştirmek için kullanılır.
-- Genellikle çalışan-yönetici veya kategori-alt kategori ilişkilerinde kullanılır.


-- INNER JOIN KULLANIMI
SELECT
 U.NAMESURNAME,
 U.EMAIL,
 O.TOTALPRICE,
 O.STATUS_
FROM USERS U
JOIN ORDERS O    -- JOIN IFADESI DEFAULT : INNER JOIN
ON U.ID = O.USERID




-- BIRDEN FAZLA JOIN BIRLIKTE KULLANIMI
SELECT
    U.NAMESURNAME,
    O.TOTALPRICE,
    O.DATE_,
    P.DATE_
FROM USERS U
JOIN ORDERS O ON O.USERID = U.ID
JOIN PAYMENTS P ON P.ORDERID = O.ID



---------------
-- DİGER JOIN UYG. ORNEKLERI
---------------

-- BIRDEN FAZLA JOIN BIRLIKTE KULLANIMI

SELECT * FROM ORDERS
SELECT * FROM ITEMS

-- SADECE SATILAN URUNLERI GETİREN SORGU
SELECT 
    O.ID,
    I.ID,
    I.ITEMNAME
FROM ORDERS O
INNER JOIN ITEMS I ON O.ID = I.ID


-- SADECE SATILMAYAN URUNLERI GETİREN SORGU
SELECT 
    O.ID,
    I.ID,
    I.ITEMNAME
FROM ORDERS O
RIGHT JOIN ITEMS I ON O.ID = I.ID
WHERE O.ID IS NULL

SELECT * FROM ORDERS

-- SIPARIS VEREN MUSTERILER
SELECT
	U.USERNAME_,
	U.EMAIL,
	O.TOTALPRICE,
	O.STATUS_
FROM ORDERS O
INNER JOIN USERS U
ON O.USERID = U.ID 


-- SIPARIS VEREN + VERMEYEN MUSTERILER
SELECT
	U.USERNAME_,
	U.EMAIL,
	O.TOTALPRICE,
	O.STATUS_
FROM USERS U
LEFT JOIN ORDERS O
ON U.ID = O.USERID



-- SIPARIS VERMEYENLER + NULL ILE KONTROL
SELECT
	U.USERNAME_,
	U.EMAIL
FROM USERS U
LEFT JOIN ORDERS O
ON U.ID = O.USERID
WHERE O.ID IS NULL



-- Tüm siparişler  + Kullanıcısı bulunmayan siparişler
SELECT
    O.ID,
    O.TOTALPRICE,
    U.USERNAME_,
    U.EMAIL
FROM USERS U
RIGHT JOIN ORDERS O
    ON U.ID = O.USERID;



-- sipariş vermemiş kullanıcılar + hem de kullanıcısı bulunmayan siparişler 
SELECT
	U.USERNAME_,
	U.EMAIL,
	O.ID,
	O.TOTALPRICE
FROM USERS U
FULL JOIN ORDERS O    -- FULL OUTER JOIN
ON U.ID = O.ID










