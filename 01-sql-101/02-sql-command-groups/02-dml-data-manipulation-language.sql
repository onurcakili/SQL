------------------------------------------------------------------------------------------------
-- DML (DATA MANIPULATION LANGUAGE)
------------------------------------------------------------------------------------------------
-- DML changes table records. INSERT adds new rows, UPDATE changes existing rows,
-- and DELETE removes rows.
--
-- The key safety habit is simple: test the target rows with SELECT before UPDATE or DELETE.
--
-- 2. DML (DATA MANIPULATION LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
-- INSERT KULLANIMI
------------------------------------------------------------------------------------------------

-- INSERT INTO komutu tabloya yeni kayıt eklemek için kullanılır.

-- CUSTOMERS tablosuna tek kayıt ekler.
INSERT INTO CUSTOMERS
(ID, CUSTOMERNAME, CITY, BIRTHDATE, DISTRICT, GENDER)
VALUES
(1, 'Fatma Gur', 'ISTANBUL', '1990-10-15', 'Cekmekoy', 'F');

-- ID kolonu belirtilmeden kayıt ekleme örneği.
-- Not: Bu tablodaki ID kolonu IDENTITY değildir.
-- Bu nedenle ID değeri verilmezse sorgu hata verir.
-- ID değerinin otomatik artmasını istiyorsak tablo oluştururken IDENTITY kullanılmalıdır.
--
-- Örnek:
-- ID INT IDENTITY(1,1) PRIMARY KEY

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

-- UPDATE komutu mevcut kayıtları güncellemek için kullanılır.
-- Dikkat: WHERE kullanılmazsa tablodaki tüm kayıtlar güncellenir.

-- Tüm müşterilerin NATION ve AGE bilgilerini günceller.
UPDATE CUSTOMERS
SET NATION = 'TR',
    AGE = 35;

-- BIRTHDATE kolonuna göre AGE kolonunu günceller.
-- DATEDIFF(YEAR, BIRTHDATE, GETDATE()) doğum tarihi ile bugünün tarihi arasındaki yıl farkını hesaplar.
UPDATE CUSTOMERS
SET AGE = DATEDIFF(YEAR, BIRTHDATE, GETDATE());

-- GENDER değeri M olan kayıtları MALE olarak günceller.
UPDATE CUSTOMERS
SET GENDER = 'MALE'
WHERE GENDER = 'M';

-- GENDER değeri F olan kayıtları FEMALE olarak günceller.
UPDATE CUSTOMERS
SET GENDER = 'FEMALE'
WHERE GENDER = 'F';


------------------------------------------------------------------------------------------------
-- DELETE KULLANIMI
------------------------------------------------------------------------------------------------

-- DELETE komutu tablodan kayıt silmek için kullanılır.
-- Dikkat: WHERE kullanılmazsa tablodaki tüm kayıtlar silinir.

-- ID değeri 18 olan müşteriyi siler.
DELETE FROM CUSTOMERS
WHERE ID = 18;

-- Tüm kayıtları siler.
-- Eğitim dosyasında riskli olduğu için yorum satırında bırakılmıştır.
-- DELETE FROM CUSTOMERS;


------------------------------------------------------------------------------------------------
