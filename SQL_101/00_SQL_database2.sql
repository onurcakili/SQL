------------------------------------------------------------------------------------------------
-- ETRADE2 DATABASE OLUŞTURMA
------------------------------------------------------------------------------------------------

IF DB_ID('ETRADE2') IS NULL
BEGIN
    CREATE DATABASE ETRADE2;
END
GO

USE ETRADE2;
GO


------------------------------------------------------------------------------------------------
-- TABLOLAR VARSA SİLME
-- Not: Foreign key ilişkileri olduğu için önce bağlı tablolar silinir.
------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS SALES;
DROP TABLE IF EXISTS TELEPHONES;
DROP TABLE IF EXISTS CUSTOMERS;
DROP TABLE IF EXISTS ITEMS;
DROP TABLE IF EXISTS CITY_DISTRICT;
DROP TABLE IF EXISTS CITIES;
DROP TABLE IF EXISTS NAMES;
DROP TABLE IF EXISTS SURNAMES;
GO


------------------------------------------------------------------------------------------------
-- CITIES TABLOSU
-- Şehir bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE CITIES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CITYNAME NVARCHAR(50) NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- CITY_DISTRICT TABLOSU
-- Şehirlere bağlı ilçe bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE CITY_DISTRICT
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CITYID INT NOT NULL,
    DISTRICTNAME NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_CITY_DISTRICT_CITIES
    FOREIGN KEY (CITYID) REFERENCES CITIES(ID)
);
GO


------------------------------------------------------------------------------------------------
-- NAMES TABLOSU
-- İsim havuzunu tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE NAMES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NAME_ NVARCHAR(50) NOT NULL,
    GENDER NVARCHAR(10) NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- SURNAMES TABLOSU
-- Soyisim havuzunu tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE SURNAMES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    SURNAME_ NVARCHAR(50) NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- CUSTOMERS TABLOSU
-- Müşteri bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NAMEID INT NOT NULL,
    SURNAMEID INT NOT NULL,
    CITYID INT NOT NULL,
    DISTRICTID INT NOT NULL,
    BIRTHDATE DATE NOT NULL,
    GENDER NVARCHAR(10) NOT NULL,
    EMAIL NVARCHAR(100),
    CREATEDDATE DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_CUSTOMERS_NAMES
    FOREIGN KEY (NAMEID) REFERENCES NAMES(ID),

    CONSTRAINT FK_CUSTOMERS_SURNAMES
    FOREIGN KEY (SURNAMEID) REFERENCES SURNAMES(ID),

    CONSTRAINT FK_CUSTOMERS_CITIES
    FOREIGN KEY (CITYID) REFERENCES CITIES(ID),

    CONSTRAINT FK_CUSTOMERS_CITY_DISTRICT
    FOREIGN KEY (DISTRICTID) REFERENCES CITY_DISTRICT(ID)
);
GO


------------------------------------------------------------------------------------------------
-- TELEPHONES TABLOSU
-- Müşterilere ait telefon bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE TELEPHONES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CUSTOMERID INT NOT NULL,
    PHONETYPE NVARCHAR(20) NOT NULL,
    PHONENUMBER NVARCHAR(20) NOT NULL,

    CONSTRAINT FK_TELEPHONES_CUSTOMERS
    FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(ID)
);
GO


------------------------------------------------------------------------------------------------
-- ITEMS TABLOSU
-- Satışı yapılacak ürün bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE ITEMS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ITEMNAME NVARCHAR(100) NOT NULL,
    CATEGORY NVARCHAR(50) NOT NULL,
    UNITPRICE DECIMAL(10,2) NOT NULL,
    STOCK INT NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- SALES TABLOSU
-- Müşteri satış hareketlerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE SALES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CUSTOMERID INT NOT NULL,
    ITEMID INT NOT NULL,
    SALEDATE DATETIME NOT NULL,
    AMOUNT INT NOT NULL,
    UNITPRICE DECIMAL(10,2) NOT NULL,
    TOTALPRICE AS (AMOUNT * UNITPRICE),

    CONSTRAINT FK_SALES_CUSTOMERS
    FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(ID),

    CONSTRAINT FK_SALES_ITEMS
    FOREIGN KEY (ITEMID) REFERENCES ITEMS(ID)
);
GO


------------------------------------------------------------------------------------------------
-- CITIES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CITIES (CITYNAME)
VALUES
(N'İstanbul'),
(N'Ankara'),
(N'İzmir'),
(N'Bursa'),
(N'Antalya'),
(N'Konya'),
(N'Adana'),
(N'Samsun'),
(N'Tekirdağ'),
(N'Kocaeli');
GO


------------------------------------------------------------------------------------------------
-- CITY_DISTRICT VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CITY_DISTRICT (CITYID, DISTRICTNAME)
VALUES
(1, N'Kadıköy'),
(1, N'Beşiktaş'),
(1, N'Üsküdar'),
(1, N'Beylikdüzü'),
(2, N'Çankaya'),
(2, N'Keçiören'),
(2, N'Yenimahalle'),
(3, N'Bornova'),
(3, N'Karşıyaka'),
(3, N'Konak'),
(4, N'Nilüfer'),
(4, N'Osmangazi'),
(5, N'Muratpaşa'),
(5, N'Kepez'),
(6, N'Selçuklu'),
(6, N'Meram'),
(7, N'Seyhan'),
(7, N'Çukurova'),
(8, N'Atakum'),
(8, N'İlkadım'),
(9, N'Süleymanpaşa'),
(9, N'Çorlu'),
(10, N'İzmit'),
(10, N'Gebze');
GO


------------------------------------------------------------------------------------------------
-- NAMES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO NAMES (NAME_, GENDER)
VALUES
(N'Ahmet', N'Erkek'),
(N'Mehmet', N'Erkek'),
(N'Ali', N'Erkek'),
(N'Mustafa', N'Erkek'),
(N'Emre', N'Erkek'),
(N'Burak', N'Erkek'),
(N'Onur', N'Erkek'),
(N'Fatma', N'Kadın'),
(N'Ayşe', N'Kadın'),
(N'Zeynep', N'Kadın'),
(N'Elif', N'Kadın'),
(N'Merve', N'Kadın'),
(N'Derya', N'Kadın'),
(N'Seda', N'Kadın'),
(N'Ece', N'Kadın');
GO


------------------------------------------------------------------------------------------------
-- SURNAMES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SURNAMES (SURNAME_)
VALUES
(N'Yılmaz'),
(N'Demir'),
(N'Kaya'),
(N'Çelik'),
(N'Şahin'),
(N'Arslan'),
(N'Koç'),
(N'Aydın'),
(N'Kurt'),
(N'Öz'),
(N'Yıldız'),
(N'Polat'),
(N'Taş'),
(N'Karaca'),
(N'Eren');
GO


------------------------------------------------------------------------------------------------
-- CUSTOMERS VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CUSTOMERS
(NAMEID, SURNAMEID, CITYID, DISTRICTID, BIRTHDATE, GENDER, EMAIL)
VALUES
(1, 1, 1, 1, '1995-03-12', N'Erkek', N'ahmet.yilmaz@mail.com'),
(8, 4, 1, 4, '1990-10-15', N'Kadın', N'fatma.celik@mail.com'),
(9, 2, 2, 5, '1998-07-25', N'Kadın', N'ayse.demir@mail.com'),
(2, 3, 3, 8, '1992-11-08', N'Erkek', N'mehmet.kaya@mail.com'),
(10, 6, 7, 17, '1999-09-14', N'Kadın', N'zeynep.arslan@mail.com'),
(3, 5, 5, 13, '1990-01-20', N'Erkek', N'ali.sahin@mail.com'),
(4, 7, 6, 15, '1994-04-03', N'Erkek', N'mustafa.koc@mail.com'),
(11, 8, 10, 23, '1996-12-29', N'Kadın', N'elif.aydin@mail.com'),
(5, 11, 8, 19, '1993-06-21', N'Erkek', N'emre.yildiz@mail.com'),
(12, 10, 9, 21, '2000-02-10', N'Kadın', N'merve.oz@mail.com'),
(7, 12, 3, 10, '1994-10-09', N'Erkek', N'onur.polat@mail.com'),
(13, 13, 4, 11, '1998-03-04', N'Kadın', N'derya.tas@mail.com'),
(6, 9, 2, 6, '1996-08-30', N'Erkek', N'burak.kurt@mail.com'),
(14, 15, 5, 14, '1999-11-22', N'Kadın', N'seda.eren@mail.com'),
(15, 8, 9, 22, '1995-05-11', N'Kadın', N'ece.aydin@mail.com');
GO


------------------------------------------------------------------------------------------------
-- TELEPHONES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO TELEPHONES
(CUSTOMERID, PHONETYPE, PHONENUMBER)
VALUES
(1, N'Cep', N'0555 100 10 01'),
(2, N'Cep', N'0555 100 10 02'),
(3, N'Cep', N'0555 100 10 03'),
(4, N'Cep', N'0555 100 10 04'),
(5, N'Cep', N'0555 100 10 05'),
(6, N'Cep', N'0555 100 10 06'),
(7, N'Cep', N'0555 100 10 07'),
(8, N'Cep', N'0555 100 10 08'),
(9, N'Cep', N'0555 100 10 09'),
(10, N'Cep', N'0555 100 10 10'),
(11, N'Cep', N'0555 100 10 11'),
(12, N'Cep', N'0555 100 10 12'),
(13, N'Cep', N'0555 100 10 13'),
(14, N'Cep', N'0555 100 10 14'),
(15, N'Cep', N'0555 100 10 15'),
(1, N'Ev', N'0216 300 20 01'),
(2, N'İş', N'0212 400 30 02');
GO


------------------------------------------------------------------------------------------------
-- ITEMS VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO ITEMS
(ITEMNAME, CATEGORY, UNITPRICE, STOCK)
VALUES
(N'Laptop', N'Elektronik', 24500.00, 25),
(N'Akıllı Telefon', N'Elektronik', 18500.00, 40),
(N'Kablosuz Kulaklık', N'Elektronik', 1750.00, 120),
(N'Mekanik Klavye', N'Bilgisayar Aksesuarı', 2250.00, 70),
(N'Oyuncu Mouse', N'Bilgisayar Aksesuarı', 950.00, 95),
(N'Monitor', N'Elektronik', 5200.00, 35),
(N'Ofis Sandalyesi', N'Mobilya', 3800.00, 30),
(N'Çalışma Masası', N'Mobilya', 4500.00, 20),
(N'Sırt Çantası', N'Aksesuar', 850.00, 80),
(N'USB Bellek 64GB', N'Bilgisayar Aksesuarı', 320.00, 150);
GO


------------------------------------------------------------------------------------------------
-- SALES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SALES
(CUSTOMERID, ITEMID, SALEDATE, AMOUNT, UNITPRICE)
VALUES
(1, 1, '2025-01-10 10:30:00', 1, 24500.00),
(1, 3, '2025-01-10 10:35:00', 2, 1750.00),
(2, 2, '2025-01-12 14:20:00', 1, 18500.00),
(3, 9, '2025-01-13 16:45:00', 1, 850.00),
(4, 6, '2025-01-15 11:10:00', 1, 5200.00),
(5, 4, '2025-01-17 09:25:00', 1, 2250.00),
(6, 5, '2025-01-18 13:50:00', 2, 950.00),
(7, 10, '2025-01-20 15:30:00', 3, 320.00),
(8, 7, '2025-01-22 12:05:00', 1, 3800.00),
(9, 8, '2025-01-25 17:40:00', 1, 4500.00),
(10, 3, '2025-01-27 10:15:00', 1, 1750.00),
(11, 2, '2025-02-01 14:00:00', 1, 18500.00),
(12, 1, '2025-02-03 11:35:00', 1, 24500.00),
(13, 5, '2025-02-04 18:10:00', 1, 950.00),
(14, 9, '2025-02-06 09:55:00', 2, 850.00),
(15, 10, '2025-02-08 16:20:00', 4, 320.00);
GO


------------------------------------------------------------------------------------------------
-- KONTROL SORGULARI
------------------------------------------------------------------------------------------------

SELECT * FROM CITIES;
SELECT * FROM CITY_DISTRICT;
SELECT * FROM NAMES;
SELECT * FROM SURNAMES;
SELECT * FROM CUSTOMERS;
SELECT * FROM TELEPHONES;
SELECT * FROM ITEMS;
SELECT * FROM SALES;
GO


------------------------------------------------------------------------------------------------
-- ÖRNEK RAPOR SORGUSU
-- Müşteri, şehir, ilçe, ürün ve satış bilgilerini birlikte getirir.
------------------------------------------------------------------------------------------------

SELECT
    C.ID AS CustomerID,
    N.NAME_ AS CustomerName,
    S.SURNAME_ AS CustomerSurname,
    CT.CITYNAME,
    CD.DISTRICTNAME,
    I.ITEMNAME,
    I.CATEGORY,
    SL.SALEDATE,
    SL.AMOUNT,
    SL.UNITPRICE,
    SL.TOTALPRICE
FROM SALES SL
INNER JOIN CUSTOMERS C ON SL.CUSTOMERID = C.ID
INNER JOIN NAMES N ON C.NAMEID = N.ID
INNER JOIN SURNAMES S ON C.SURNAMEID = S.ID
INNER JOIN CITIES CT ON C.CITYID = CT.ID
INNER JOIN CITY_DISTRICT CD ON C.DISTRICTID = CD.ID
INNER JOIN ITEMS I ON SL.ITEMID = I.ID
ORDER BY SL.SALEDATE;
GO


-----

------------------------------------------------------------------------------------------------
-- EK CITIES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CITIES (CITYNAME)
VALUES
(N'Eskişehir'),
(N'Gaziantep'),
(N'Kayseri'),
(N'Mersin'),
(N'Trabzon');
GO


------------------------------------------------------------------------------------------------
-- EK CITY_DISTRICT VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CITY_DISTRICT (CITYID, DISTRICTNAME)
SELECT C.ID, D.DISTRICTNAME
FROM
(
    VALUES
    (N'Eskişehir', N'Tepebaşı'),
    (N'Eskişehir', N'Odunpazarı'),
    (N'Gaziantep', N'Şehitkamil'),
    (N'Gaziantep', N'Şahinbey'),
    (N'Kayseri', N'Melikgazi'),
    (N'Kayseri', N'Kocasinan'),
    (N'Mersin', N'Yenişehir'),
    (N'Mersin', N'Mezitli'),
    (N'Trabzon', N'Ortahisar'),
    (N'Trabzon', N'Akçaabat')
) D(CITYNAME, DISTRICTNAME)
INNER JOIN CITIES C ON C.CITYNAME = D.CITYNAME;
GO


------------------------------------------------------------------------------------------------
-- EK NAMES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO NAMES (NAME_, GENDER)
VALUES
(N'Can', N'Erkek'),
(N'Kerem', N'Erkek'),
(N'Murat', N'Erkek'),
(N'Serkan', N'Erkek'),
(N'Hasan', N'Erkek'),
(N'Büşra', N'Kadın'),
(N'Gizem', N'Kadın'),
(N'İrem', N'Kadın'),
(N'Yasemin', N'Kadın'),
(N'Aslı', N'Kadın');
GO


------------------------------------------------------------------------------------------------
-- EK SURNAMES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SURNAMES (SURNAME_)
VALUES
(N'Güneş'),
(N'Turan'),
(N'Korkmaz'),
(N'Ak'),
(N'Yalçın'),
(N'Bulut'),
(N'Çetin'),
(N'Kaplan'),
(N'Aslan'),
(N'Doğan');
GO


------------------------------------------------------------------------------------------------
-- EK ITEMS VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO ITEMS
(ITEMNAME, CATEGORY, UNITPRICE, STOCK)
VALUES
(N'Tablet', N'Elektronik', 9800.00, 45),
(N'Akıllı Saat', N'Elektronik', 4200.00, 60),
(N'Bluetooth Hoparlör', N'Elektronik', 1450.00, 85),
(N'Webcam', N'Bilgisayar Aksesuarı', 1100.00, 75),
(N'Harici Disk 1TB', N'Bilgisayar Aksesuarı', 2500.00, 55),
(N'Kitaplık', N'Mobilya', 3100.00, 25),
(N'Kahve Makinesi', N'Ev Aletleri', 6800.00, 30),
(N'Robot Süpürge', N'Ev Aletleri', 12500.00, 18),
(N'Spor Ayakkabı', N'Giyim', 2200.00, 90),
(N'Mont', N'Giyim', 3400.00, 50);
GO


------------------------------------------------------------------------------------------------
-- EK CUSTOMERS VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO CUSTOMERS
(NAMEID, SURNAMEID, CITYID, DISTRICTID, BIRTHDATE, GENDER, EMAIL)
SELECT
    N.ID,
    S.ID,
    C.ID,
    CD.ID,
    X.BIRTHDATE,
    X.GENDER,
    X.EMAIL
FROM
(
    VALUES
    (N'Can', N'Güneş', N'Eskişehir', N'Tepebaşı', '1991-04-18', N'Erkek', N'can.gunes@mail.com'),
    (N'Kerem', N'Turan', N'Gaziantep', N'Şehitkamil', '1997-12-05', N'Erkek', N'kerem.turan@mail.com'),
    (N'Murat', N'Korkmaz', N'Kayseri', N'Melikgazi', '1989-09-22', N'Erkek', N'murat.korkmaz@mail.com'),
    (N'Serkan', N'Ak', N'Mersin', N'Yenişehir', '1994-06-14', N'Erkek', N'serkan.ak@mail.com'),
    (N'Hasan', N'Yalçın', N'Trabzon', N'Ortahisar', '1992-01-30', N'Erkek', N'hasan.yalcin@mail.com'),
    (N'Büşra', N'Bulut', N'İstanbul', N'Üsküdar', '1998-08-09', N'Kadın', N'busra.bulut@mail.com'),
    (N'Gizem', N'Çetin', N'Ankara', N'Yenimahalle', '1996-03-27', N'Kadın', N'gizem.cetin@mail.com'),
    (N'İrem', N'Kaplan', N'İzmir', N'Karşıyaka', '2001-11-11', N'Kadın', N'irem.kaplan@mail.com'),
    (N'Yasemin', N'Aslan', N'Bursa', N'Osmangazi', '1993-05-06', N'Kadın', N'yasemin.aslan@mail.com'),
    (N'Aslı', N'Doğan', N'Antalya', N'Kepez', '1999-02-19', N'Kadın', N'asli.dogan@mail.com')
) X(NAME_, SURNAME_, CITYNAME, DISTRICTNAME, BIRTHDATE, GENDER, EMAIL)
INNER JOIN NAMES N ON N.NAME_ = X.NAME_ AND N.GENDER = X.GENDER
INNER JOIN SURNAMES S ON S.SURNAME_ = X.SURNAME_
INNER JOIN CITIES C ON C.CITYNAME = X.CITYNAME
INNER JOIN CITY_DISTRICT CD ON CD.CITYID = C.ID AND CD.DISTRICTNAME = X.DISTRICTNAME;
GO


------------------------------------------------------------------------------------------------
-- EK TELEPHONES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO TELEPHONES
(CUSTOMERID, PHONETYPE, PHONENUMBER)
SELECT C.ID, T.PHONETYPE, T.PHONENUMBER
FROM
(
    VALUES
    (N'can.gunes@mail.com', N'Cep', N'0555 200 20 01'),
    (N'kerem.turan@mail.com', N'Cep', N'0555 200 20 02'),
    (N'murat.korkmaz@mail.com', N'Cep', N'0555 200 20 03'),
    (N'serkan.ak@mail.com', N'Cep', N'0555 200 20 04'),
    (N'hasan.yalcin@mail.com', N'Cep', N'0555 200 20 05'),
    (N'busra.bulut@mail.com', N'Cep', N'0555 200 20 06'),
    (N'gizem.cetin@mail.com', N'Cep', N'0555 200 20 07'),
    (N'irem.kaplan@mail.com', N'Cep', N'0555 200 20 08'),
    (N'yasemin.aslan@mail.com', N'Cep', N'0555 200 20 09'),
    (N'asli.dogan@mail.com', N'Cep', N'0555 200 20 10'),
    (N'can.gunes@mail.com', N'İş', N'0222 300 40 01'),
    (N'gizem.cetin@mail.com', N'Ev', N'0312 300 40 07')
) T(EMAIL, PHONETYPE, PHONENUMBER)
INNER JOIN CUSTOMERS C ON C.EMAIL = T.EMAIL;
GO


------------------------------------------------------------------------------------------------
-- EK SALES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SALES
(CUSTOMERID, ITEMID, SALEDATE, AMOUNT, UNITPRICE)
SELECT
    C.ID,
    I.ID,
    X.SALEDATE,
    X.AMOUNT,
    I.UNITPRICE
FROM
(
    VALUES
    (N'can.gunes@mail.com', N'Tablet', '2025-02-10 10:15:00', 1),
    (N'can.gunes@mail.com', N'Webcam', '2025-02-10 10:20:00', 1),
    (N'kerem.turan@mail.com', N'Akıllı Saat', '2025-02-12 13:40:00', 1),
    (N'kerem.turan@mail.com', N'Bluetooth Hoparlör', '2025-02-12 13:45:00', 2),
    (N'murat.korkmaz@mail.com', N'Harici Disk 1TB', '2025-02-15 09:30:00', 1),
    (N'serkan.ak@mail.com', N'Kahve Makinesi', '2025-02-18 16:10:00', 1),
    (N'hasan.yalcin@mail.com', N'Robot Süpürge', '2025-02-20 11:50:00', 1),
    (N'busra.bulut@mail.com', N'Spor Ayakkabı', '2025-02-22 15:25:00', 1),
    (N'gizem.cetin@mail.com', N'Mont', '2025-02-24 12:05:00', 1),
    (N'irem.kaplan@mail.com', N'USB Bellek 64GB', '2025-02-26 18:30:00', 5),
    (N'yasemin.aslan@mail.com', N'Kitaplık', '2025-02-28 14:45:00', 1),
    (N'asli.dogan@mail.com', N'Kablosuz Kulaklık', '2025-03-02 10:00:00', 1),
    (N'ahmet.yilmaz@mail.com', N'Akıllı Saat', '2025-03-04 17:20:00', 1),
    (N'fatma.celik@mail.com', N'Robot Süpürge', '2025-03-06 11:15:00', 1),
    (N'ayse.demir@mail.com', N'Spor Ayakkabı', '2025-03-08 19:05:00', 2),
    (N'mehmet.kaya@mail.com', N'Harici Disk 1TB', '2025-03-10 09:50:00', 1),
    (N'zeynep.arslan@mail.com', N'Tablet', '2025-03-12 13:35:00', 1),
    (N'ali.sahin@mail.com', N'Bluetooth Hoparlör', '2025-03-14 16:40:00', 1),
    (N'mustafa.koc@mail.com', N'Webcam', '2025-03-16 12:25:00', 2),
    (N'elif.aydin@mail.com', N'Kahve Makinesi', '2025-03-18 10:10:00', 1)
) X(EMAIL, ITEMNAME, SALEDATE, AMOUNT)
INNER JOIN CUSTOMERS C ON C.EMAIL = X.EMAIL
INNER JOIN ITEMS I ON I.ITEMNAME = X.ITEMNAME;
GO