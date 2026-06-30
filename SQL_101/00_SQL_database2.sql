USE ETRADE2;
GO


------------------------------------------------------------------------------------------------
-- MEVCUT FACT YAPISI VARSA TEMİZLEME
------------------------------------------------------------------------------------------------

DROP VIEW IF EXISTS VW_SALES_FACT_DETAIL;
GO

DROP TABLE IF EXISTS SALES_FACT;
DROP TABLE IF EXISTS SALES_FICHES;
DROP TABLE IF EXISTS STORES;
DROP TABLE IF EXISTS ITEM_CATEGORIES;
DROP TABLE IF EXISTS BRANDS;
GO


------------------------------------------------------------------------------------------------
-- BRANDS TABLOSU
-- Ürün markalarını tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE BRANDS
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    BRANDCODE NVARCHAR(20) NOT NULL UNIQUE,
    BRANDNAME NVARCHAR(100) NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- ITEM_CATEGORIES TABLOSU
-- Ürün kategori kırılımlarını tutar.
-- CATEGORY1 > CATEGORY2 > CATEGORY3 > CATEGORY4 şeklinde detaylandırılır.
------------------------------------------------------------------------------------------------

CREATE TABLE ITEM_CATEGORIES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CATEGORY1 NVARCHAR(100) NOT NULL,
    CATEGORY2 NVARCHAR(100) NOT NULL,
    CATEGORY3 NVARCHAR(100) NOT NULL,
    CATEGORY4 NVARCHAR(100) NOT NULL
);
GO


------------------------------------------------------------------------------------------------
-- STORES TABLOSU
-- Satış yapılan mağaza / şube bilgilerini tutar.
------------------------------------------------------------------------------------------------

CREATE TABLE STORES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    STORECODE NVARCHAR(20) NOT NULL UNIQUE,
    STORENAME NVARCHAR(100) NOT NULL,
    CITYID INT NOT NULL,
    DISTRICTID INT NOT NULL,
    STORETYPE NVARCHAR(50) NOT NULL,
    OPENINGDATE DATE NOT NULL,
    ISACTIVE BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_STORES_CITIES
    FOREIGN KEY (CITYID) REFERENCES CITIES(ID),

    CONSTRAINT FK_STORES_CITY_DISTRICT
    FOREIGN KEY (DISTRICTID) REFERENCES CITY_DISTRICT(ID)
);
GO


------------------------------------------------------------------------------------------------
-- ITEMS TABLOSUNU PROFESYONEL SATIŞ ANALİZİ İÇİN GENİŞLETME
------------------------------------------------------------------------------------------------

IF COL_LENGTH('ITEMS', 'ITEMCODE') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD ITEMCODE NVARCHAR(30) NULL;
END
GO

IF COL_LENGTH('ITEMS', 'BRANDID') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD BRANDID INT NULL;
END
GO

IF COL_LENGTH('ITEMS', 'CATEGORYID') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD CATEGORYID INT NULL;
END
GO

IF COL_LENGTH('ITEMS', 'BARCODE') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD BARCODE NVARCHAR(50) NULL;
END
GO

IF COL_LENGTH('ITEMS', 'VAT_RATE') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD VAT_RATE DECIMAL(5,2) NULL;
END
GO

IF COL_LENGTH('ITEMS', 'ISACTIVE') IS NULL
BEGIN
    ALTER TABLE ITEMS ADD ISACTIVE BIT NOT NULL DEFAULT 1;
END
GO


------------------------------------------------------------------------------------------------
-- SALES_FICHES TABLOSU
-- Satış fişi / belge başlık bilgilerini tutar.
-- Bir fişin altında birden fazla ürün satırı olabilir.
------------------------------------------------------------------------------------------------

CREATE TABLE SALES_FICHES
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FICHENO NVARCHAR(30) NOT NULL UNIQUE,
    DATE_ DATETIME NOT NULL,
    CUSTOMERID INT NOT NULL,
    STOREID INT NOT NULL,
    PAYMENTTYPE NVARCHAR(30) NOT NULL,
    STATUS_ NVARCHAR(30) NOT NULL DEFAULT N'Tamamlandı',

    CONSTRAINT FK_SALES_FICHES_CUSTOMERS
    FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(ID),

    CONSTRAINT FK_SALES_FICHES_STORES
    FOREIGN KEY (STOREID) REFERENCES STORES(ID)
);
GO


------------------------------------------------------------------------------------------------
-- SALES_FACT TABLOSU
-- Detaylı satış hareketlerini tutan fact table'dır.
-- Her satır bir ürün satış hareketini temsil eder.
------------------------------------------------------------------------------------------------

CREATE TABLE SALES_FACT
(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FICHEID INT NOT NULL,
    ITEMID INT NOT NULL,
    CUSTOMERID INT NOT NULL,
    STOREID INT NOT NULL,
    DATE_ DATETIME NOT NULL,

    AMOUNT INT NOT NULL,
    PRICE DECIMAL(12,2) NOT NULL,
    DISCOUNT_RATE DECIMAL(5,2) NOT NULL DEFAULT 0,
    DISCOUNT_AMOUNT DECIMAL(12,2) NOT NULL DEFAULT 0,
    VAT_RATE DECIMAL(5,2) NOT NULL DEFAULT 20,
    VAT_AMOUNT DECIMAL(12,2) NOT NULL DEFAULT 0,

    LINETOTAL AS (AMOUNT * PRICE),
    TOTALPRICE DECIMAL(12,2) NOT NULL,

    CONSTRAINT FK_SALES_FACT_FICHES
    FOREIGN KEY (FICHEID) REFERENCES SALES_FICHES(ID),

    CONSTRAINT FK_SALES_FACT_ITEMS
    FOREIGN KEY (ITEMID) REFERENCES ITEMS(ID),

    CONSTRAINT FK_SALES_FACT_CUSTOMERS
    FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(ID),

    CONSTRAINT FK_SALES_FACT_STORES
    FOREIGN KEY (STOREID) REFERENCES STORES(ID)
);
GO


------------------------------------------------------------------------------------------------
-- BRANDS VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO BRANDS (BRANDCODE, BRANDNAME)
VALUES
(N'BRD001', N'MUJDE'),
(N'BRD002', N'TECHNOX'),
(N'BRD003', N'HOMEPLUS'),
(N'BRD004', N'OFFICELINE'),
(N'BRD005', N'SPORTIVA'),
(N'BRD006', N'MOBILUX'),
(N'BRD007', N'FASTSTORE'),
(N'BRD008', N'DIGICOM');
GO


------------------------------------------------------------------------------------------------
-- ITEM_CATEGORIES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO ITEM_CATEGORIES
(CATEGORY1, CATEGORY2, CATEGORY3, CATEGORY4)
VALUES
(N'EV', N'TEKSTİL-GİYİM-AKSESUAR', N'ÇORAPLAR', N'BAYAN ÇORAP'),
(N'EV', N'TEKSTİL-GİYİM-AKSESUAR', N'ÇORAPLAR', N'ERKEK ÇORAP'),
(N'ELEKTRONİK', N'BİLGİSAYAR', N'DİZÜSTÜ BİLGİSAYAR', N'LAPTOP'),
(N'ELEKTRONİK', N'TELEFON', N'AKILLI TELEFON', N'ANDROID TELEFON'),
(N'ELEKTRONİK', N'AKSESUAR', N'KULAKLIK', N'KABLOSUZ KULAKLIK'),
(N'ELEKTRONİK', N'AKSESUAR', N'DEPOLAMA', N'USB BELLEK'),
(N'EV', N'MOBİLYA', N'OFİS MOBİLYASI', N'ÇALIŞMA MASASI'),
(N'EV', N'MOBİLYA', N'OFİS MOBİLYASI', N'OFİS SANDALYESİ'),
(N'EV', N'KÜÇÜK EV ALETLERİ', N'TEMİZLİK', N'ROBOT SÜPÜRGE'),
(N'GİYİM', N'AYAKKABI', N'SPOR AYAKKABI', N'GÜNLÜK SPOR');
GO


------------------------------------------------------------------------------------------------
-- STORES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO STORES
(STORECODE, STORENAME, CITYID, DISTRICTID, STORETYPE, OPENINGDATE)
SELECT
    X.STORECODE,
    X.STORENAME,
    C.ID,
    CD.ID,
    X.STORETYPE,
    X.OPENINGDATE
FROM
(
    VALUES
    (N'ST001', N'İstanbul Kadıköy Mağazası', N'İstanbul', N'Kadıköy', N'Fiziksel Mağaza', '2018-03-15'),
    (N'ST002', N'İstanbul Beşiktaş Mağazası', N'İstanbul', N'Beşiktaş', N'Fiziksel Mağaza', '2019-05-20'),
    (N'ST003', N'Ankara Çankaya Mağazası', N'Ankara', N'Çankaya', N'Fiziksel Mağaza', '2020-01-10'),
    (N'ST004', N'İzmir Bornova Mağazası', N'İzmir', N'Bornova', N'Fiziksel Mağaza', '2021-07-01'),
    (N'ST005', N'Bursa Nilüfer Mağazası', N'Bursa', N'Nilüfer', N'Fiziksel Mağaza', '2022-02-12'),
    (N'ST006', N'Online Satış Kanalı', N'İstanbul', N'Üsküdar', N'Online Mağaza', '2017-09-01')
) X(STORECODE, STORENAME, CITYNAME, DISTRICTNAME, STORETYPE, OPENINGDATE)
INNER JOIN CITIES C ON C.CITYNAME = X.CITYNAME
INNER JOIN CITY_DISTRICT CD ON CD.CITYID = C.ID AND CD.DISTRICTNAME = X.DISTRICTNAME;
GO


------------------------------------------------------------------------------------------------
-- ITEMS TABLOSUNU MARKA, KATEGORİ VE ÜRÜN KODLARI İLE GÜNCELLEME
------------------------------------------------------------------------------------------------

UPDATE I
SET
    ITEMCODE = X.ITEMCODE,
    BRANDID = B.ID,
    CATEGORYID = IC.ID,
    BARCODE = X.BARCODE,
    VAT_RATE = X.VAT_RATE
FROM ITEMS I
INNER JOIN
(
    VALUES
    (N'Laptop', N'ITM000001', N'TECHNOX', N'ELEKTRONİK', N'BİLGİSAYAR', N'DİZÜSTÜ BİLGİSAYAR', N'LAPTOP', N'8690000000011', 20.00),
    (N'Akıllı Telefon', N'ITM000002', N'DIGICOM', N'ELEKTRONİK', N'TELEFON', N'AKILLI TELEFON', N'ANDROID TELEFON', N'8690000000028', 20.00),
    (N'Kablosuz Kulaklık', N'ITM000003', N'DIGICOM', N'ELEKTRONİK', N'AKSESUAR', N'KULAKLIK', N'KABLOSUZ KULAKLIK', N'8690000000035', 20.00),
    (N'USB Bellek 64GB', N'ITM000004', N'TECHNOX', N'ELEKTRONİK', N'AKSESUAR', N'DEPOLAMA', N'USB BELLEK', N'8690000000042', 20.00),
    (N'Çalışma Masası', N'ITM000005', N'HOMEPLUS', N'EV', N'MOBİLYA', N'OFİS MOBİLYASI', N'ÇALIŞMA MASASI', N'8690000000059', 10.00),
    (N'Ofis Sandalyesi', N'ITM000006', N'OFFICELINE', N'EV', N'MOBİLYA', N'OFİS MOBİLYASI', N'OFİS SANDALYESİ', N'8690000000066', 10.00),
    (N'Robot Süpürge', N'ITM000007', N'HOMEPLUS', N'EV', N'KÜÇÜK EV ALETLERİ', N'TEMİZLİK', N'ROBOT SÜPÜRGE', N'8690000000073', 20.00),
    (N'Spor Ayakkabı', N'ITM000008', N'SPORTIVA', N'GİYİM', N'AYAKKABI', N'SPOR AYAKKABI', N'GÜNLÜK SPOR', N'8690000000080', 10.00)
) X(ITEMNAME, ITEMCODE, BRANDNAME, CATEGORY1, CATEGORY2, CATEGORY3, CATEGORY4, BARCODE, VAT_RATE)
ON I.ITEMNAME = X.ITEMNAME
INNER JOIN BRANDS B ON B.BRANDNAME = X.BRANDNAME
INNER JOIN ITEM_CATEGORIES IC
    ON IC.CATEGORY1 = X.CATEGORY1
   AND IC.CATEGORY2 = X.CATEGORY2
   AND IC.CATEGORY3 = X.CATEGORY3
   AND IC.CATEGORY4 = X.CATEGORY4;
GO


------------------------------------------------------------------------------------------------
-- FACT TABLE İÇİN EK ÜRÜNLER
------------------------------------------------------------------------------------------------

INSERT INTO ITEMS
(ITEMNAME, CATEGORY, UNITPRICE, STOCK, ITEMCODE, BRANDID, CATEGORYID, BARCODE, VAT_RATE)
SELECT
    X.ITEMNAME,
    X.CATEGORY,
    X.UNITPRICE,
    X.STOCK,
    X.ITEMCODE,
    B.ID,
    IC.ID,
    X.BARCODE,
    X.VAT_RATE
FROM
(
    VALUES
    (N'MUJDE KACMAZ FIT 15 KILOTLU', N'Tekstil', 4.116, 500, N'19248', N'MUJDE', N'EV', N'TEKSTİL-GİYİM-AKSESUAR', N'ÇORAPLAR', N'BAYAN ÇORAP', N'8691000000018', 10.00),
    (N'MUJDE PAMUKLU DİZALTI ÇORAP', N'Tekstil', 6.250, 350, N'19249', N'MUJDE', N'EV', N'TEKSTİL-GİYİM-AKSESUAR', N'ÇORAPLAR', N'BAYAN ÇORAP', N'8691000000025', 10.00),
    (N'MUJDE ERKEK SOKET ÇORAP', N'Tekstil', 5.750, 420, N'19250', N'MUJDE', N'EV', N'TEKSTİL-GİYİM-AKSESUAR', N'ÇORAPLAR', N'ERKEK ÇORAP', N'8691000000032', 10.00)
) X(ITEMNAME, CATEGORY, UNITPRICE, STOCK, ITEMCODE, BRANDNAME, CATEGORY1, CATEGORY2, CATEGORY3, CATEGORY4, BARCODE, VAT_RATE)
INNER JOIN BRANDS B ON B.BRANDNAME = X.BRANDNAME
INNER JOIN ITEM_CATEGORIES IC
    ON IC.CATEGORY1 = X.CATEGORY1
   AND IC.CATEGORY2 = X.CATEGORY2
   AND IC.CATEGORY3 = X.CATEGORY3
   AND IC.CATEGORY4 = X.CATEGORY4;
GO


------------------------------------------------------------------------------------------------
-- SALES_FICHES VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SALES_FICHES
(FICHENO, DATE_, CUSTOMERID, STOREID, PAYMENTTYPE, STATUS_)
SELECT
    X.FICHENO,
    X.DATE_,
    C.ID,
    S.ID,
    X.PAYMENTTYPE,
    N'Tamamlandı'
FROM
(
    VALUES
    (N'0000015993', '2019-01-01 08:07:24', N'ahmet.yilmaz@mail.com', N'ST001', N'Kredi Kartı'),
    (N'0000015994', '2019-01-01 09:12:41', N'fatma.celik@mail.com', N'ST002', N'Nakit'),
    (N'0000015995', '2019-01-01 10:25:18', N'ayse.demir@mail.com', N'ST003', N'Kredi Kartı'),
    (N'0000015996', '2019-01-02 11:40:05', N'mehmet.kaya@mail.com', N'ST004', N'Banka Kartı'),
    (N'0000015997', '2019-01-02 15:21:33', N'zeynep.arslan@mail.com', N'ST006', N'Online Ödeme'),
    (N'0000015998', '2019-01-03 13:05:12', N'ali.sahin@mail.com', N'ST005', N'Nakit')
) X(FICHENO, DATE_, EMAIL, STORECODE, PAYMENTTYPE)
INNER JOIN CUSTOMERS C ON C.EMAIL = X.EMAIL
INNER JOIN STORES S ON S.STORECODE = X.STORECODE;
GO


------------------------------------------------------------------------------------------------
-- SALES_FACT VERİLERİ
------------------------------------------------------------------------------------------------

INSERT INTO SALES_FACT
(FICHEID, ITEMID, CUSTOMERID, STOREID, DATE_, AMOUNT, PRICE, DISCOUNT_RATE, DISCOUNT_AMOUNT, VAT_RATE, VAT_AMOUNT, TOTALPRICE)
SELECT
    F.ID,
    I.ID,
    F.CUSTOMERID,
    F.STOREID,
    F.DATE_,
    X.AMOUNT,
    X.PRICE,
    X.DISCOUNT_RATE,
    ROUND((X.AMOUNT * X.PRICE) * X.DISCOUNT_RATE / 100, 2) AS DISCOUNT_AMOUNT,
    X.VAT_RATE,
    ROUND(((X.AMOUNT * X.PRICE) - ((X.AMOUNT * X.PRICE) * X.DISCOUNT_RATE / 100)) * X.VAT_RATE / 100, 2) AS VAT_AMOUNT,
    ROUND((X.AMOUNT * X.PRICE) - ((X.AMOUNT * X.PRICE) * X.DISCOUNT_RATE / 100), 2) AS TOTALPRICE
FROM
(
    VALUES
    (N'0000015993', N'19248', 10, 4.116, 0.00, 10.00),
    (N'0000015994', N'19249', 6, 6.250, 5.00, 10.00),
    (N'0000015995', N'ITM000001', 1, 24500.00, 0.00, 20.00),
    (N'0000015995', N'ITM000003', 2, 1750.00, 10.00, 20.00),
    (N'0000015996', N'ITM000002', 1, 18500.00, 0.00, 20.00),
    (N'0000015997', N'ITM000007', 1, 12500.00, 7.50, 20.00),
    (N'0000015998', N'ITM000008', 2, 2200.00, 0.00, 10.00),
    (N'0000015998', N'19250', 12, 5.750, 0.00, 10.00)
) X(FICHENO, ITEMCODE, AMOUNT, PRICE, DISCOUNT_RATE, VAT_RATE)
INNER JOIN SALES_FICHES F ON F.FICHENO = X.FICHENO
INNER JOIN ITEMS I ON I.ITEMCODE = X.ITEMCODE;
GO


------------------------------------------------------------------------------------------------
-- FACT TABLE DETAY VIEW
-- Görseldeki yapıya benzer detaylı satış raporu üretir.
------------------------------------------------------------------------------------------------

CREATE VIEW VW_SALES_FACT_DETAIL
AS
SELECT
    SF.ID,
    F.FICHENO,
    SF.DATE_,
    I.ITEMCODE,
    I.ITEMNAME,
    B.BRANDNAME AS BRAND,
    IC.CATEGORY1,
    IC.CATEGORY2,
    IC.CATEGORY3,
    IC.CATEGORY4,
    SF.AMOUNT,
    SF.PRICE,
    SF.TOTALPRICE,
    SF.DISCOUNT_RATE,
    SF.DISCOUNT_AMOUNT,
    SF.VAT_RATE,
    SF.VAT_AMOUNT,
    ST.STORECODE,
    ST.STORENAME,
    CT.CITYNAME AS STORECITY,
    CD.DISTRICTNAME AS STOREDISTRICT,
    C.ID AS CUSTOMERID,
    N.NAME_ AS CUSTOMERNAME,
    SR.SURNAME_ AS CUSTOMERSURNAME,
    F.PAYMENTTYPE,
    F.STATUS_
FROM SALES_FACT SF
INNER JOIN SALES_FICHES F ON SF.FICHEID = F.ID
INNER JOIN ITEMS I ON SF.ITEMID = I.ID
LEFT JOIN BRANDS B ON I.BRANDID = B.ID
LEFT JOIN ITEM_CATEGORIES IC ON I.CATEGORYID = IC.ID
INNER JOIN STORES ST ON SF.STOREID = ST.ID
INNER JOIN CITIES CT ON ST.CITYID = CT.ID
INNER JOIN CITY_DISTRICT CD ON ST.DISTRICTID = CD.ID
INNER JOIN CUSTOMERS C ON SF.CUSTOMERID = C.ID
INNER JOIN NAMES N ON C.NAMEID = N.ID
INNER JOIN SURNAMES SR ON C.SURNAMEID = SR.ID;
GO


------------------------------------------------------------------------------------------------
-- KONTROL SORGUSU
------------------------------------------------------------------------------------------------

SELECT *
FROM VW_SALES_FACT_DETAIL
ORDER BY DATE_, FICHENO, ID;
GO