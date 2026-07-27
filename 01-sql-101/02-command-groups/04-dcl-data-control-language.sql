------------------------------------------------------------------------------------------------
-- DCL (DATA CONTROL LANGUAGE)
------------------------------------------------------------------------------------------------
-- DCL manages access. GRANT, REVOKE, and DENY decide who can read or change which objects.
--
-- Real data security depends on correct permissions, not only passwords.
--
-- 5. DCL (DATA CONTROL LANGUAGE) KOMUTLARI
------------------------------------------------------------------------------------------------

-- DCL komutları yetkilendirme işlemleri için kullanılır.
--
-- GRANT  : Kullanıcıya veya role yetki verir.
-- REVOKE : Daha önce verilmiş veya reddedilmiş yetkiyi geri alır.
-- DENY   : Kullanıcıya veya role belirli bir işlemi açıkça yasaklar.
--
-- Not: DCL komutlarını çalıştırmak için yeterli yetkiye sahip olmak gerekir.
-- Bu komutlar genellikle DBA veya yetkili kullanıcılar tarafından kullanılır.

-- Örnek kullanıcı oluşturma:
-- Bu örnek login oluşturmadan sadece ilgili veritabanı içinde kullanıcı oluşturur.
CREATE USER ETRADE_READER WITHOUT LOGIN;

-- ETRADE_READER kullanıcısına CUSTOMERS tablosu üzerinde SELECT yetkisi verir.
GRANT SELECT ON CUSTOMERS TO ETRADE_READER;

-- Verilmiş SELECT yetkisini geri alır.
REVOKE SELECT ON CUSTOMERS FROM ETRADE_READER;

-- ETRADE_READER kullanıcısının CUSTOMERS tablosundan kayıt silmesini açıkça engeller.
DENY DELETE ON CUSTOMERS TO ETRADE_READER;

-- DENY ile konulan DELETE yasağını kaldırır.
REVOKE DELETE ON CUSTOMERS FROM ETRADE_READER; 