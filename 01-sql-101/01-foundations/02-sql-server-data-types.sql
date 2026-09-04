-----------------------------------------------------------------------------------------------
-- # SQL SERVER VERİ TİPLERİNE GİRİŞ
-----------------------------------------------------------------------------------------------

-- ## Veri Tipi Nedir?
--
-- Veri tipi (Data Type), bir kolonun hangi türde veri saklayacağını belirleyen temel veritabanı tanımıdır.
-- Bir kolona atanan veri tipi; o kolonda metin, sayı, tarih, mantıksal değer veya ikili veri gibi hangi tür bilginin tutulacağını belirler.
--
-- Örneğin:
-- - Bir kişinin adı için metinsel bir veri tipi kullanılır.
-- - Ürün fiyatı için ondalıklı ve kesin hesaplama yapabilen bir veri tipi seçilir.
-- - Sipariş tarihi için tarih veya tarih-saat veri tipi tercih edilir.
-- - Aktif/pasif durumu için BIT veri tipi kullanılabilir.

-- ## Veri Tipi Seçiminin Önemi
--
-- Doğru veri tipi seçimi yalnızca verinin saklanmasını değil; performansı, depolama maliyetini, veri bütünlüğünü ve sorgu doğruluğunu da doğrudan etkiler:
--
-- - Gereksiz depolama kullanımını azaltır.
-- - Verinin beklenen formatta saklanmasını sağlar.
-- - Sorgu ve indeks performansını etkiler.
-- - Analitik işlemlerin daha doğru yapılmasına yardımcı olur.
-- - Hatalı veya tutarsız veri girişlerini azaltır.
--
-- Bu nedenle her kolon için veri tipi seçilirken verinin anlamı, değer aralığı, uzunluğu, hassasiyet ihtiyacı ve kullanım senaryosu birlikte değerlendirilmelidir.

-- ## Veri Tipi Kategorileri
--
-- 1. Sayısal (Numeric) Veri Tipleri
-- 2. Karakter (Character) Veri Tipleri
-- 3. Tarih & Saat (Date & Time) Veri Tipleri
-- 4. Mantıksal (Boolean) Veri Tipleri
-- 5. İkili (Binary) Veri Tipleri
-- 6. Özel Amaçlı (Special Purpose) Veri Tipleri


-----------------------------------------------------------------------------------------------
-- # 1. SAYISAL (NUMERIC) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 1.1 TINYINT
--
-- Küçük ve yalnızca pozitif tam sayıları saklamak için kullanılır.
--
-- - Değer aralığı  : 0 - 255
-- - Depolama alanı : 1 Byte
--
-- Geniş sayı aralıklarına ihtiyaç duyulmayan alanlarda depolama açısından avantaj sağlar.
--
-- Kullanım alanları:
-- - Yaş bilgisi
-- - Puan değeri
-- - Seviye bilgisi
-- - Durum kodları
--
-- Örnek: Bir müşterinin üyelik seviyesi 1, 2, 3 gibi küçük değerlerle tutulacaksa TINYINT uygun bir seçimdir.


-- ## 1.2 SMALLINT
--
-- TINYINT'e göre daha geniş aralıklı, INT'e göre daha az depolama alanı kullanan tam sayı veri tipidir.
--
-- - Değer aralığı  : -32.768 - 32.767
-- - Depolama alanı : 2 Byte
--
-- Kullanım alanları:
-- - Yıl bilgisi
-- - Küçük sayaç değerleri
-- - Sınırlı aralığa sahip sayısal bilgiler
--
-- Örnek: Bir ürünün stok uyarı limiti SMALLINT ile saklanabilir.


-- ## 1.3 INT
--
-- SQL Server'da genel amaçlı tam sayı değerleri için en sık kullanılan veri tipidir.
--
-- - Değer aralığı  : -2.147.483.648 - 2.147.483.647 (~2,14 milyar)
-- - Depolama alanı : 4 Byte
--
-- Geniş değer aralığı sunduğu için kimlik alanları, sayaçlar ve birçok standart sayısal kolon için uygundur.
--
-- Kullanım alanları:
-- - CustomerID
-- - ProductID
-- - Sipariş numarası
-- - Sayaç değerleri
--
-- Örnek: Bir müşteri tablosunda her müşteriyi benzersiz tanımlamak için CustomerID, INT veri tipiyle oluşturulabilir.


-- ## 1.4 BIGINT
--
-- Çok büyük tam sayıların saklanması gereken durumlarda kullanılır.
--
-- - Değer aralığı  : -9.223.372.036.854.775.808 - 9.223.372.036.854.775.807 (~9,22 kentilyon)
-- - Depolama alanı : 8 Byte
--
-- INT veri tipinin değer aralığının yetersiz kaldığı yüksek hacimli sistemlerde tercih edilir.
--
-- Kullanım alanları:
-- - Büyük ölçekli log kayıtları
-- - Çok yüksek işlem hacmine sahip sistemler
-- - Büyük veri platformlarındaki sayaçlar
-- - Dağıtık sistemlerde üretilen büyük ID değerleri
--
-- Örnek: Milyarlarca işlem kaydı tutan bir finans sisteminde işlem numarası BIGINT olarak tanımlanabilir.


-- ## 1.5 DECIMAL
--
-- Kesinlik gerektiren ondalıklı sayıları saklamak için kullanılır.
-- Yaklaşık değil, belirlenen basamak sayısına göre kesin değer saklar.
--
-- Kullanım biçimi : DECIMAL(p, s)
-- - p (precision) : Sayının toplam basamak sayısı.
-- - s (scale)     : Ondalık kısmın basamak sayısı.
--
-- Örnek: DECIMAL(10,2) tanımı, toplam 10 basamaklı ve virgülden sonra 2 basamaklı değerlerin saklanabileceği anlamına gelir (örn. 125000.75).
--
-- Depolama alanı (basamak sayısına göre):
-- - 1-9 basamak   : 5 Byte
-- - 10-19 basamak : 9 Byte
-- - 20-28 basamak : 13 Byte
-- - 29-38 basamak : 17 Byte
--
-- Kullanım alanları:
-- - Ürün fiyatı
-- - Maaş bilgisi
-- - Vergi oranı
-- - Bakiye
-- - Finansal hesaplamalar
--
-- Not: Para ve finans işlemlerinde FLOAT yerine DECIMAL kullanılması daha doğrudur; çünkü FLOAT yaklaşık değer saklarken DECIMAL kesin değer üretir.


-- ## 1.6 NUMERIC
--
-- SQL Server'da DECIMAL ile aynı işlevi gören kesin sayısal veri tipidir.
--
-- Kullanım biçimi : NUMERIC(p, s) — DECIMAL ile aynı mantıkla kullanılır.
-- Örnek           : NUMERIC(8,2) ifadesi, toplam 8 basamaklı ve virgülden sonra 2 basamaklı değerleri saklayabilir.
--
-- Kullanım alanları:
-- - Finansal hesaplamalar
-- - Ölçülü maliyet değerleri
-- - Komisyon oranları
--
-- Not: SQL Server'da DECIMAL ve NUMERIC işlevsel olarak eşdeğerdir.


-- ## 1.7 FLOAT
--
-- Yaklaşık sayısal değerleri saklamak için kullanılır.
-- Çok büyük veya çok küçük sayıları saklayabilir; ancak kesinlik garantisi DECIMAL kadar güçlü değildir.
--
-- - Değer aralığı  : Yaklaşık ±1.79E+308
-- - Depolama alanı : FLOAT(1-24) için 4 Byte, FLOAT(25-53) için 8 Byte
--
-- Kullanım alanları:
-- - Bilimsel hesaplamalar
-- - Sensör verileri
-- - İstatistiksel hesaplamalar
-- - Yaklaşık ölçüm değerleri
--
-- Örnek: Sıcaklık, basınç veya mesafe gibi ölçüm verilerinde küçük hassasiyet farkları kabul edilebilir olduğundan FLOAT tercih edilebilir.
--
-- Not: Ürün fiyatı, maaş veya bakiye gibi kesinlik gerektiren alanlarda FLOAT yerine DECIMAL veya NUMERIC kullanılmalıdır.


-----------------------------------------------------------------------------------------------
-- # 2. KARAKTER (CHARACTER) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 2.1 CHAR
--
-- Sabit uzunluklu metin verilerini saklamak için kullanılır.
--
-- Kullanım biçimi : CHAR(n)
-- Depolama alanı  : Her zaman n Byte (girilen değerin uzunluğundan bağımsız olarak).
--
-- Saklanacak metnin uzunluğu her kayıtta aynıysa uygundur.
--
-- Kullanım alanları:
-- - Ülke kodu (TR, US, DE)
-- - Cinsiyet kodu (E, K)
-- - Sabit uzunluklu durum kodları
--
-- Örnek: CountryCode CHAR(2) olarak tanımlanırsa her kayıt için 2 karakterlik alan ayrılır.


-- ## 2.2 VARCHAR
--
-- Değişken uzunluklu metin verilerini saklamak için kullanılır.
--
-- Kullanım biçimi : VARCHAR(n)
-- Depolama alanı  : Girilen metnin gerçek uzunluğu kadar.
--
-- CHAR'dan farklı olarak tüm kayıtlar için sabit uzunlukta yer ayırmaz; bu nedenle uzunluğu değişebilen metinlerde daha verimlidir.
--
-- Kullanım alanları:
-- - Ad
-- - Soyad
-- - E-posta
-- - Telefon açıklaması
-- - Kısa adres bilgisi
--
-- Örnek: FirstName VARCHAR(50) olarak tanımlandığında 50 karaktere kadar ad bilgisi saklanabilir; girilen değer daha kısaysa yalnızca ihtiyaç duyulan alan kullanılır.


-- ## 2.3 VARCHAR(MAX)
--
-- Çok uzun metinsel verileri saklamak için kullanılır.
--
-- Depolama kapasitesi : Yaklaşık 2 GB'a kadar.
--
-- Kullanım alanları:
-- - Uzun açıklama metinleri
-- - Log içerikleri
-- - Makale veya yorum metinleri
-- - Serbest metin alanları
--
-- Örnek: Kullanıcıların uzun açıklama girebildiği bir Description kolonu VARCHAR(MAX) olarak tanımlanabilir.


-- ## 2.4 NCHAR
--
-- Sabit uzunluklu Unicode metin verilerini saklamak için kullanılır.
-- Unicode, uluslararası bir karakter kodlama standardıdır ve Türkçe, Arapça, Çince, Kiril alfabesi gibi farklı karakter kümelerinin güvenli biçimde saklanmasını sağlar.
--
-- Kullanım biçimi : NCHAR(n)
-- Depolama alanı  : 2 * n Byte
--
-- Kullanım alanları:
-- - Çok dilli sabit kodlar
-- - Sabit uzunluklu Unicode alanlar
--
-- Örnek: Dil kodu veya sabit uzunluklu uluslararası metinsel kodlar NCHAR ile tutulabilir.


-- ## 2.5 NVARCHAR
--
-- Değişken uzunluklu Unicode metin verilerini saklamak için kullanılır.
--
-- Kullanım biçimi : NVARCHAR(n)
-- Depolama alanı  : Girilen karakter sayısına bağlı olarak yaklaşık 2 Byte x karakter sayısı.
--
-- Modern uygulamalarda Türkçe karakterler ve farklı dillerle uyumluluk sağlamak için VARCHAR yerine çoğunlukla NVARCHAR tercih edilir.
--
-- Kullanım alanları:
-- - Ad ve soyad
-- - Adres
-- - Ürün adı
-- - Açıklama
-- - Çok dilli kullanıcı girdileri
--
-- Örnek: ProductName NVARCHAR(100) olarak tanımlanırsa ürün adları Türkçe karakterlerle güvenli şekilde saklanabilir.


-- ## 2.6 NVARCHAR(MAX)
--
-- Büyük boyutlu Unicode metin verilerini saklamak için kullanılır.
--
-- Depolama kapasitesi : Yaklaşık 2 GB'a kadar Unicode metin.
--
-- Kullanım alanları:
-- - Çok dilli uzun açıklamalar
-- - Doküman içerikleri
-- - API'den gelen büyük metinsel cevaplar
-- - JSON verileri
--
-- Örnek: SQL Server'da JSON için ayrı bir native veri tipi bulunmadığından, JSON içerikleri genellikle NVARCHAR(MAX) içinde saklanır.


-----------------------------------------------------------------------------------------------
-- # 3. TARİH & SAAT (DATE & TIME) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 3.1 DATE
--
-- Yalnızca tarih bilgisini saklamak için kullanılır; saat bilgisi içermez.
--
-- - Depolama alanı : 3 Byte
-- - Değer aralığı  : 0001-01-01 - 9999-12-31
--
-- Kullanım alanları:
-- - Doğum tarihi
-- - İşe giriş tarihi
-- - Sipariş tarihi
-- - Fatura tarihi
--
-- Örnek: BirthDate DATE olarak tanımlandığında yalnızca yıl, ay ve gün bilgisi tutulur.


-- ## 3.2 TIME
--
-- Yalnızca saat bilgisini saklamak için kullanılır; tarih bilgisi içermez.
--
-- - Depolama alanı : Hassasiyet düzeyine bağlı olarak 3-5 Byte
-- - Değer aralığı  : 00:00:00 - 23:59:59.9999999
--
-- Kullanım alanları:
-- - Vardiya başlangıç saati
-- - Ders saati
-- - Randevu saati
-- - Gün içi işlem zamanı
--
-- Örnek: MeetingTime TIME olarak tanımlandığında yalnızca toplantının saat bilgisi saklanır.


-- ## 3.3 DATETIME
--
-- Tarih ve saat bilgisini birlikte saklar.
--
-- - Depolama alanı : 8 Byte
-- - Değer aralığı  : 1753-01-01 - 9999-12-31
--
-- Kullanım alanları:
-- - Kayıt oluşturma zamanı
-- - Sipariş oluşturulma zamanı
-- - İşlem zamanı
-- - Güncelleme zamanı
--
-- Örnek: CreatedAt DATETIME olarak tanımlanırsa bir kaydın hangi tarih ve saatte oluşturulduğu saklanabilir.


-- ## 3.4 SMALLDATETIME
--
-- DATETIME'a göre daha düşük hassasiyetli (dakika düzeyinde) tarih-saat bilgisi saklar.
--
-- - Depolama alanı : 4 Byte
-- - Hassasiyet     : Dakika düzeyi
--
-- Saniye veya milisaniye hassasiyetinin önemli olmadığı durumlarda tercih edilebilir.
--
-- Kullanım alanları:
-- - Günlük raporlama zamanları
-- - Dakika düzeyinde işlem kayıtları
-- - Basit tarih-saat alanları


-- ## 3.5 DATETIMEOFFSET
--
-- Tarih ve saat bilgisinin yanında saat dilimi farkını (UTC offset) da saklar.
--
-- Örnek: 2026-06-22 14:30:00 +03:00
--
-- Kullanım alanları:
-- - Uluslararası uygulamalar
-- - Farklı saat dilimlerinde çalışan sistemler
-- - Global kullanıcı işlemleri
-- - Zaman dilimi bilgisi kritik olan kayıtlar
--
-- Örnek: Türkiye, Avrupa ve Amerika kullanıcılarının işlem zamanlarının doğru yorumlanması gereken sistemlerde DATETIMEOFFSET tercih edilebilir.


-----------------------------------------------------------------------------------------------
-- # 4. MANTIKSAL (BOOLEAN) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 4.1 BIT (0, 1, NULL)
--
-- Mantıksal değerleri saklamak için kullanılır. Alabileceği değerler: 0, 1 veya NULL.
--
-- SQL Server'da ayrı bir BOOLEAN veri tipi bulunmaz; boolean benzeri değerler genellikle BIT veri tipi ile temsil edilir.
--
-- Kullanım alanları:
-- - Aktif/pasif durumu
-- - Silindi/silinmedi bilgisi
-- - Onaylandı/onaylanmadı bilgisi
-- - E-posta doğrulama durumu
--
-- Örnek: IsActive BIT kolonu bir kullanıcının aktif olup olmadığını gösterir.
-- - 1    : Aktif
-- - 0    : Pasif
-- - NULL : Bilinmiyor veya henüz belirlenmemiş


-----------------------------------------------------------------------------------------------
-- # 5. İKİLİ (BINARY) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 5.1 BINARY
--
-- Sabit uzunluklu ikili verileri saklamak için kullanılır.
--
-- Kullanım biçimi : BINARY(n)
-- Depolama alanı  : Her zaman n Byte.
--
-- Kullanım alanları:
-- - Sabit uzunluklu hash değerleri
-- - Şifrelenmiş sabit boyutlu alanlar
-- - Binary formatta saklanan özel kodlar
--
-- Örnek: Uzunluğu her zaman aynı olan bir hash değeri BINARY ile saklanabilir.


-- ## 5.2 VARBINARY
--
-- Değişken uzunluklu ikili verileri saklamak için kullanılır.
--
-- Kullanım biçimi : VARBINARY(n)
-- Depolama alanı  : Gerçek veri uzunluğuna göre.
--
-- Kullanım alanları:
-- - Değişken uzunluklu hash çıktıları
-- - Küçük dosya parçaları
-- - Şifrelenmiş veri blokları
--
-- Örnek: Farklı uzunluklarda şifrelenmiş veri çıktıları VARBINARY ile saklanabilir.


-- ## 5.3 VARBINARY(MAX)
--
-- Büyük boyutlu ikili verileri saklamak için kullanılır.
--
-- Depolama kapasitesi : Yaklaşık 2 GB'a kadar.
--
-- Kullanım alanları:
-- - Dosyalar
-- - Resimler
-- - PDF belgeleri
-- - Medya içerikleri
--
-- Örnek: Bir kullanıcının profil fotoğrafı veya sisteme yüklenen PDF dosyası VARBINARY(MAX) içinde saklanabilir.
--
-- Not: Büyük dosyaların doğrudan veritabanında saklanması performans ve bakım maliyeti oluşturabilir; bu nedenle dosya yolu saklama veya harici depolama çözümleri de değerlendirilmelidir.


-- ## BOOLEAN / BIT / BINARY Farkları
--
-- - BOOLEAN → Mantıksal kavram → true / false
-- - BIT     → SQL Server'da boolean benzeri veri saklamak için kullanılır → 0 / 1 / NULL
-- - BINARY  → Ham ikili veri saklamak için kullanılır → dosya, hash, şifreli veri vb.
--
-- Ham ikili veri saklamak, veriyi insanın doğrudan okuyabileceği biçimde değil, bilgisayarın işlediği düşük seviyeli byte formatında saklamak anlamına gelir (örn. metin veri "Onur" iken, ham ikili veri onun byte düzeyindeki karşılığıdır).


-----------------------------------------------------------------------------------------------
-- # 6. ÖZEL AMAÇLI (SPECIAL PURPOSE) VERİ TİPLERİ
-----------------------------------------------------------------------------------------------

-- ## 6.1 UNIQUEIDENTIFIER
--
-- GUID (Globally Unique Identifier) değerlerini saklamak için kullanılır.
--
-- Depolama alanı : 16 Byte
--
-- GUID, global ölçekte benzersiz değer üretmek için kullanılır.
-- Özellikle dağıtık sistemlerde, farklı sunucularda veya farklı uygulamalarda üretilen kayıtların çakışmadan tanımlanmasını sağlar.
--
-- Kullanım alanları:
-- - Dağıtık sistemlerde benzersiz kayıt kimliği
-- - Sistemler arası veri entegrasyonu
-- - Global müşteri veya işlem ID değerleri
--
-- Örnek: Birden fazla şubede aynı anda müşteri kaydı oluşturulan bir sistemde, çakışma riskini azaltmak için UNIQUEIDENTIFIER kullanılabilir.
--
-- Not: UNIQUEIDENTIFIER benzersizlik açısından güçlüdür; ancak indeksleme ve sıralı veri ekleme performansı açısından dikkatli kullanılmalıdır.


-- ## 6.2 XML
--
-- "Extensible Markup Language" (Genişletilebilir İşaretleme Dili) ifadesinin kısaltmasıdır.
-- Veriyi etiketler kullanarak düzenli ve hiyerarşik biçimde saklamak veya sistemler arasında taşımak için kullanılan metin tabanlı bir veri formatıdır.
-- HTML görünümü tanımlarken, XML verinin yapısını ve anlamını tanımlar.
--
-- SQL Server, XML verileri üzerinde sorgulama yapılmasına ve XML indeksleri oluşturulmasına destek verir.
--
-- Kullanım alanları:
-- - Konfigürasyon verileri
-- - Hiyerarşik veri yapıları
-- - Sistemler arası XML tabanlı veri aktarımı
-- - Eski entegrasyon sistemleri
--
-- Örnek: Bir siparişin ürün listesi, teslimat bilgileri ve ek açıklamaları hiyerarşik bir XML formatında saklanabilir.


-- ## 6.3 JSON
--
-- "JavaScript Object Notation" ifadesinin kısaltmasıdır.
-- Veriyi anahtar-değer çiftleri halinde saklamak ve sistemler arasında taşımak için kullanılan metin tabanlı bir veri formatıdır.
-- Özellikle web uygulamalarında, API cevaplarında ve yapılandırma dosyalarında yaygın olarak kullanılır.
--
-- Basit örnek:
-- {
--   "id": 1,
--   "name": "Onur",
--   "city": "Istanbul"
-- }
--
-- SQL Server'da JSON için ayrı bir native veri tipi bulunmaz; JSON verileri genellikle NVARCHAR veya NVARCHAR(MAX) veri tipi içinde saklanır.
-- SQL Server, JSON metinleri üzerinde sorgulama ve işleme yapabilmek için çeşitli JSON fonksiyonları sunar.
--
-- Kullanım alanları:
-- - API cevapları
-- - Esnek şemaya sahip kullanıcı ayarları
-- - Uygulama konfigürasyonları
-- - Yarı yapılandırılmış veri alanları
--
-- Örnek: Bir kullanıcının tema tercihi, bildirim ayarları ve dil seçimi JSON formatında tek bir NVARCHAR(MAX) kolonunda saklanabilir.
--
-- Not: JSON verisi metin olarak saklandığından, veri doğrulama, indeksleme ve performans gereksinimleri tasarım aşamasında ayrıca değerlendirilmelidir.