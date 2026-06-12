---------------------------------------------------------------------------
-- SQL & Veritabanına Giriş - 101
---------------------------------------------------------------------------

-- 1. VERİ NEDİR VE NEDEN YÖNETİLMELİDİR?
--
-- Günümüz dijital sistemlerinde veri, sistemlerin en temel bileşenidir.
-- Ancak ham veri tek başına anlamlı değildir; organize edilmediği sürece:
-- - tutarsızlık oluşur
-- - tekrarlar artar
-- - erişim zorlaşır
-- - analiz yapılamaz hale gelir
--
-- Bu nedenle verinin yapılandırılmış ve yönetilebilir bir sistem içinde saklanması gerekir.


-- 2. VERİTABANI (DATABASE) NEDİR?
--
-- Veritabanı, ilişkili verilerin mantıksal bir model içinde organize edilerek saklandığı yapıdır.
--
-- İlişkisel modelde veri:
-- - tablolar (relations)
-- - satırlar (tuples / records)
-- - sütunlar (attributes / fields)
-- şeklinde temsil edilir.
--
-- Temel amaç:
-- Veriyi tekrar etmeden, tutarlı ve erişilebilir şekilde saklamaktır.


-- 3. VERİTABANI YÖNETİM SİSTEMİ (DBMS)
--
-- DBMS, veritabanını doğrudan yöneten yazılım katmanıdır.
--
-- Görevleri:
-- - Veri oluşturma ve saklama
-- - Veri sorgulama ve güncelleme
-- - Eşzamanlı kullanıcı yönetimi (concurrency)
-- - Güvenlik ve yetkilendirme
-- - Veri bütünlüğünü sağlama
--
-- DBMS, kullanıcı ile fiziksel veri arasında bir soyutlama katmanı oluşturur.


-- 4. İLİŞKİSEL VERİTABANI (RDBMS)
--
-- RDBMS, verileri tablolar halinde saklayan ve bu tablolar arasında ilişkiler kuran DBMS türüdür.
--
-- İlişkiler genellikle:
-- - Primary Key (PK)
-- - Foreign Key (FK)
-- ile sağlanır.
--
-- Amaç:
-- - Veri tekrarını azaltmak (normalization)
-- - Veri tutarlılığını sağlamak (integrity)
-- - Güvenilir veri ilişkileri kurmak


-- 5. CLIENT – SERVER MİMARİSİ
--
-- Veritabanı sistemleri genellikle client-server mimarisi ile çalışır:
--
-- Client (İstemci):
-- - Veri talep eden taraf
--
-- Server (Sunucu):
-- - Veriyi işleyen ve döndüren taraf
--
-- İşleyiş:
-- Client SQL sorgusu gönderir → Server işler → Sonuç geri döner
--
-- Avantajlar:
-- - merkezi kontrol
-- - güvenlik
-- - ölçeklenebilirlik


-- 6. DBMS VE SQL İLİŞKİSİ
--
-- SQL, DBMS üzerinde çalışan standart sorgu dilidir.
--
-- SQL tek başına bir yazılım değildir.
--
-- İlişki:
-- - SQL → ne yapılacağını söyler
-- - DBMS → nasıl yapılacağını uygular


-- 7. SQL NEDİR?
--
-- SQL (Structured Query Language), ilişkisel veritabanlarında veri yönetimi için kullanılan standart dildir.
--
-- SQL kategorileri:
-- - DDL (Data Definition Language) → CREATE, ALTER, DROP
-- - DML (Data Manipulation Language) → INSERT, UPDATE, DELETE
-- - DQL (Data Query Language) → SELECT
-- - DCL / TCL → yetki ve işlem kontrolü


-- 8. MSSQL (MICROSOFT SQL SERVER)
--
-- MSSQL, Microsoft tarafından geliştirilen bir RDBMS sistemidir.
--
-- Özellikleri:
-- - T-SQL (Transact-SQL) kullanır
-- - transaction yönetimi destekler
-- - kurumsal ölçekli veri yönetimi sağlar
-- - güvenlik ve performans mekanizmaları içerir