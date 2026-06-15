-----------------------------------------------------------------------------------------------

-- Veri Tipi (Data Type), bir kolonun hangi tür veriyi saklayacağını belirleyen veri tabanı nesnesidir.

-- Veri tipi seçimi:
-- • Performansı etkiler
-- • Depolama maliyetini belirler
-- • Veri bütünlüğünü sağlar
-- • Analitik doğruluğu etkiler


-- VERİ TİPİ KATEGORİLERİ
------------------------------------------------------------------------------------------------


-- 3. NUMERIC DATA TYPES
------------------------------------------------------------------------------------------------

----------------
-- 3.1 TINYINT
----------------

-- Küçük pozitif tam sayılar için kullanılır.
-- Değer Aralığı : 0 - 255
-- Depolama Alanı : 1 Byte
-- Yaş, puan, durum kodları

----------------
-- 3.2 SMALLINT
----------------

-- Küçük tam sayılar için kullanılır.
-- Değer Aralığı : -32,768 → 32,767
-- Depolama Alanı : 2 Byte
-- Yıl, küçük sayısal değerler

----------------
-- 3.3 INT
----------------

-- Genel amaçlı tam sayı tipi.
-- Değer Aralığı : -2,147,483,648 → 2,147,483,647
-- Depolama Alanı : 4 Byte
-- ID, sayaç, anahtar alanlar

----------------
-- 3.4 BIGINT
----------------

-- Çok büyük tam sayılar.
-- Değer Aralığı :
-- -9,223,372,036,854,775,808 →
--  9,223,372,036,854,775,807
-- Depolama Alanı : 8 Byte
-- Log, büyük veri sistemleri

----------------
-- 3.5 DECIMAL
----------------

-- Kesin sayısal veri tipi.
-- DECIMAL(p,s)
-- Precision : 1 - 38
-- Scale : 0 - p
-- Depolama:
-- 1-9 digits   : 5 Byte
-- 10-19 digits : 9 Byte
-- 20-28 digits : 13 Byte
-- 29-38 digits : 17 Byte
-- Finansal veriler (maaş, fiyat)

----------------
-- 3.6 NUMERIC
----------------

-- DECIMAL ile aynıdır.
-- Kesin hesaplamalar için kullanılır.

----------------
-- 3.7 FLOAT
----------------

-- Yaklaşık sayısal değerler.
-- Aralık : ±1.79E+308
-- Depolama:
-- FLOAT(1-24)  : 4 Byte
-- FLOAT(25-53) : 8 Byte
-- Bilimsel hesaplamalar


--------------------------------------------------------------------------------
-- 4. CHARACTER DATA TYPES
--------------------------------------------------------------------------------

----------------
-- 4.1 CHAR
----------------

-- Sabit uzunluklu metin.
-- CHAR(n)
-- Depolama : n Byte
-- TC No, ülke kodu

----------------
-- 4.2 VARCHAR
----------------

-- Değişken uzunluklu metin.
-- VARCHAR(n)
-- Depolama : Gerçek veri kadar
-- Ad, soyad, email

----------------
-- 4.3 VARCHAR(MAX)
----------------

-- Büyük metin verisi.
-- Depolama : 2 GB'a kadar
-- Açıklama, log, içerik

----------------
-- 4.4 NCHAR
----------------

-- Unicode sabit metin.
-- Depolama : 2 * n Byte
-- Çok dilli sabit alanlar

----------------
-- 4.5 NVARCHAR
----------------

-- Unicode değişken metin.
-- Depolama : 2 * gerçek uzunluk
-- Modern sistemler

----------------
-- 4.6 NVARCHAR(MAX)
----------------

-- Büyük Unicode metin.
-- Depolama : 2 GB

--------------------------------------------------------------------------------
-- 5. DATE & TIME DATA TYPES
--------------------------------------------------------------------------------

----------------
-- 5.1 DATE
----------------

-- Sadece tarih
-- Depolama : 3 Byte
-- 0001-01-01 → 9999-12-31

----------------
-- 5.2 TIME
----------------

-- Sadece saat
-- Depolama : 3–5 Byte
-- 00:00:00 → 23:59:59.9999999

----------------
-- 5.3 DATETIME
----------------

-- Tarih + saat
-- Depolama : 8 Byte
-- 1753-01-01 → 9999-12-31

----------------
-- 5.5 SMALLDATETIME
----------------

-- Daha düşük hassasiyet
-- Depolama : 4 Byte
-- Dakika hassasiyeti

----------------
-- 5.6 DATETIMEOFFSET
----------------

-- Saat dilimi destekli datetime
-- Depolama : 10 Byte
-- UTC offset içerir

--------------------------------------------------------------------------------
-- 6. BOOLEAN DATA TYPES
--------------------------------------------------------------------------------

----------------
-- 6.1 BIT
----------------

-- Boolean veri tipi
-- Değer : 0 / 1 / NULL
-- Depolama : 1 bit (mantıksal olarak 1 byte bloklar halinde)
-- Aktif/Pasif

--------------------------------------------------------------------------------
-- 7. BINARY DATA TYPES
--------------------------------------------------------------------------------

----------------
-- 7.1 BINARY
----------------

-- Sabit binary veri
-- Depolama : n Byte

----------------
-- 7.2 VARBINARY
----------------

-- Değişken binary veri
-- Depolama : gerçek veri + 2 byte overhead

----------------
-- 7.3 VARBINARY(MAX)
----------------

-- Büyük binary veri
-- Depolama : 2 GB
-- Dosya, resim, pdf

----------------
-- 8. SPECIAL PURPOSE DATA TYPES
----------------

----------------
-- 8.1 UNIQUEIDENTIFIER
----------------

-- GUID veri tipi (Global Unique Identifier)
-- Depolama : 16 Byte
-- Global unique ID

----------------
-- 8.2 XML
----------------

-- XML veri saklama
-- Depolama : değişken
-- XML indexlenebilir

----------------
-- 8.3 JSON
----------------

-- MSSQL'de native değil
-- NVARCHAR(MAX) içinde tutulur