SELECT TOP 10 * FROM Uyeler;
Create Table Kitaplar (
	kitapId INT PRIMARY KEY IDENTITY(1,1),
	ad NVARCHAR(100),
	yazar NVARCHAR(100),
	yayinevi NVARCHAR(100),
	basimYili INT,
	kategori NVARCHAR(50)
)
ALTER TABLE Uyeler
ADD uye_id INT IDENTITY(1,1);
CREATE TABLE Emanetler (
    emanet_id INT PRIMARY KEY IDENTITY(1,1),
    uye_id INT FOREIGN KEY REFERENCES Uyeler(uye_id),
    kitap_id INT FOREIGN KEY REFERENCES Kitaplar(kitapId),
    alis_tarihi DATE,
    iade_tarihi DATE,
    iade_edildi_mi BIT
)
ALTER TABLE Uyeler
ADD CONSTRAINT PK_Uyeler PRIMARY KEY (uye_id);
SELECT COUNT(*) FROM Uyeler;
SELECT uye_id FROM Uyeler;
SELECT kitap_id FROM Kitaplar;
INSERT INTO Kitaplar (ad, yazar, yayinevi, basimYili, kategori)
VALUES 
('Gece Yar�s� K�t�phanesi', 'Matt Haig', 'Domingo', 2023, 'Roman'),
('�nce Memed', 'Ya�ar Kemal', 'Can Yay�nlar�', 1955, 'Roman'),
INSERT INTO Kitaplar (ad, yazar, yayinevi, basim_yili, kategori)
VALUES 
INSERT INTO Kitaplar (ad, yazar, yayinevi, basimYili, kategori)
VALUES
('Su� ve Ceza', 'Dostoyevski', '�thaki', 1886, 'Roman'),
('�nce Memed', 'Ya�ar Kemal', 'Can Yay�nlar�', 1955, 'Roman'),
('K�rk Mantolu Madonna', 'Sabahattin Ali', 'Yap� Kredi Yay�nlar�', 1943, 'Roman'),
('Sefiller', 'Victor Hugo', '�leti�im', 1862, 'Roman'),
('Simyac�', 'Paulo Coelho', 'Can Yay�nlar�', 1988, 'Felsefe'),
('Beyaz Di�', 'Jack London', 'Penguin', 1906, 'Macera'),
('Y�zy�ll�k Yaln�zl�k', 'Gabriel Garcia Marquez', 'Can Yay�nlar�', 1967, 'Roman'),
('Karamazov Karde�ler', 'Dostoyevski', '�thaki', 1880, 'Roman'),
('�slam�n Temel �nan�lar�', 'Fazlur Rahman', 'Diyanet', 1970, 'Din'),
('Ba�lang��', 'Dan Brown', 'Alt�n Kitaplar', 2003, 'Gerilim'),
('1984', 'George Orwell', 'Can Yay�nlar�', 1949, 'Distopya'),
('Hayvan �iftli�i', 'George Orwell', 'Can Yay�nlar�', 1945, 'Roman'),
('Su�lu ve Ceza', 'Dostoyevski', '�thaki', 1886, 'Roman'),
('Cesur Yeni D�nya', 'Aldous Huxley', '�thaki', 1932, 'Distopya'),
('Yabanc�', 'Albert Camus', 'Can Yay�nlar�', 1942, 'Roman'),
('Fahrenheit 451', 'Ray Bradbury', '�thaki', 1953, 'Bilim Kurgu'),
('K�rl�k', 'Jos� Saramago', 'Can Yay�nlar�', 1995, 'Roman'),
('Tutunamayanlar', 'O�uz Atay', '�leti�im', 1972, 'Roman'),
('D�n���m', 'Franz Kafka', 'Can Yay�nlar�', 1915, 'Roman'),
('Maltepe �niversitesi Tarihi', 'A�ko Yazar', 'A�ko Yay�nlar�', 2025, 'Akademik');
SELECT u.ad, u.soyad, k.ad AS KitapAdi, e.alis_tarihi, e.iade_tarihi
FROM Emanetler e
JOIN Uyeler u ON e.uye_id = u.uye_id
JOIN Kitaplar k ON e.kitap_id = k.kitap_id
WHERE u.uye_id = 3;  -- istedi�in �ye ID
SELECT TOP 10 ad, soyad FROM Uyeler;
INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_tarihi, iade_edildi_mi)
VALUES
(1, 1, '2025-07-01', '2025-07-10', 1),
(2, 3, '2025-07-03', NULL, 0),
(3, 2, '2025-07-05', '2025-07-15', 1)
INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_tarihi, iade_edildi_mi)
VALUES
(1, 3, '2025-07-01', '2025-07-10', 1),
(2, 5, '2025-07-02', NULL, 0),
(3, 2, '2025-07-03', '2025-07-13', 1),
(4, 1, '2025-07-04', NULL, 0),
(5, 7, '2025-07-05', '2025-07-15', 1),
(6, 9, '2025-07-06', NULL, 0),
(7, 4, '2025-07-07', '2025-07-17', 1),
(8, 8, '2025-07-08', NULL, 0),
(9, 6, '2025-07-09', '2025-07-19', 1),
(10, 10, '2025-07-10', NULL, 0);
--K�TAP EMANET ETME PROSED�R
CREATE PROCEDURE KitapEmanetEt
    @uye_id INT,
    @kitap_id INT,
    @alis_tarihi DATE
AS
BEGIN
    -- Yeni emanet kayd� ekle, iade edilmedi (0) olarak
    INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_edildi_mi)
    VALUES (@uye_id, @kitap_id, @alis_tarihi, 0);

    PRINT 'Kitap ba�ar�yla emanet edildi.';
END;
--�ADE ETME
CREATE PROCEDURE KitapIadeEt
    @emanet_id INT,
    @iade_tarihi DATE
AS
BEGIN
    -- Emanet kayd�n� g�ncelle, iade tarihi ve iade_edildi_mi=1 olarak
    UPDATE Emanetler
    SET iade_tarihi = @iade_tarihi,
        iade_edildi_mi = 1
    WHERE emanet_id = @emanet_id;

    PRINT 'Kitap ba�ar�yla iade edildi.';
END;
-- �ye 2, kitap 5'i 2025-07-20'de �d�n� al�yor:
EXEC KitapEmanetEt @uye_id = 2, @kitap_id = 5, @alis_tarihi = '2025-07-20';

-- Emanet ID 3 olan kitab� 2025-07-25'te iade ediyoruz:
EXEC KitapIadeEt @emanet_id = 3, @iade_tarihi = '2025-07-25';
CREATE TRIGGER trg_Emanet_Insert
ON Emanetler
INSTEAD OF INSERT
AS
BEGIN
    -- E�er ayn� �ye ayn� kitab� iade edilmemi�se, hata ver
    IF EXISTS (
        SELECT 1
        FROM Emanetler e
        JOIN inserted i ON e.uye_id = i.uye_id AND e.kitap_id = i.kitap_id
        WHERE e.iade_edildi_mi = 0
    )
    BEGIN
        RAISERROR('Bu �ye ayn� kitab� hen�z iade etmedi, tekrar emanet veremez.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- E�er sorun yoksa, insert i�lemini yap
    INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_tarihi, iade_edildi_mi)
    SELECT uye_id, kitap_id, alis_tarihi, iade_tarihi, iade_edildi_mi
    FROM inserted;
END;
INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_edildi_mi)
VALUES (1, 3, GETDATE(), 0);
-- �nce emanetin iadesini yap
UPDATE Emanetler SET iade_edildi_mi = 1 WHERE uye_id = 1 AND kitap_id = 3;

-- Sonra tekrar emanet ver
INSERT INTO Emanetler (uye_id, kitap_id, alis_tarihi, iade_edildi_mi)
VALUES (1, 3, GETDATE(), 0);
SELECT * FROM Emanetler WHERE uye_id = 1 AND kitap_id = 3;
CREATE VIEW vw_UyeEmanetDurumu AS
SELECT 
    u.uye_id, u.ad, u.soyad,
    k.kitap_id, k.ad AS KitapAdi,
    e.alis_tarihi, e.iade_tarihi, e.iade_edildi_mi
FROM Emanetler e
JOIN Uyeler u ON e.uye_id = u.uye_id
JOIN Kitaplar k ON e.kitap_id = k.kitap_id;
SELECT * FROM vw_UyeEmanetDurumu;
--gecikme g�n say�s�n� hesaplamak
CREATE FUNCTION fn_GecikmeGunSayisi(@emanet_id INT)
RETURNS INT
AS
BEGIN
	DECLARE @gecikme INT;

	SELECT 
		@gecikme=DATEDIFF(DAY, e.iade_tarihi, GETDATE())
	FROM Emanetler e
	WHERE e.emanet_id=@emanet_id
		AND e.iade_edildi_mi = 0;

	IF @gecikme < 0 
		SET @gecikme=0;

	RETURN ISNULL(@gecikme, 0);
END
SELECT dbo.fn_GecikmeGunSayisi(1) AS GecikmeGunSayisi;

--kitaplar� yay�nevi ad�na g�re s�ralama(A'dan Z'ye)
SELECT * FROM Kitaplar
ORDER BY yayinevi ASC
--�A� Harfiyle Ba�layan Kitap �simleri 
SELECT * FROM Kitaplar
WHERE kitap_adi LIKE 'G%'
--  Farkl� Yayinevlerini Listele
SELECT DISTINCT Yayinevi FROM Kitaplar
--ya� hesaplama
CREATE FUNCTION fn_YasHesapla (@DogumTarihi DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Yas INT;
    SET @Yas = DATEDIFF(YEAR, @DogumTarihi, GETDATE());
    
    -- E�er do�um g�n� hen�z gelmemi�se 1 ya� eksilt
    IF (MONTH(@DogumTarihi) > MONTH(GETDATE())) OR 
       (MONTH(@DogumTarihi) = MONTH(GETDATE()) AND DAY(@DogumTarihi) > DAY(GETDATE()))
       SET @Yas = @Yas - 1;

    RETURN @Yas;
END
--ya�a g�re s�ralama
SELECT 
    uye_id
    Ad,
	Soyad,
    DogumTarihi,
    dbo.fn_YasHesapla(DogumTarihi) AS Yas
FROM Uyeler
ORDER BY dbo.fn_YasHesapla(DogumTarihi) DESC;

SELECT uye_id, COUNT(*) AS alinan_kitap_sayisi
FROM emanetler
GROUP BY uye_id
ORDER BY alinan_kitap_sayisi DESC

SELECT cinsiyet, COUNT(*) AS toplam_uye
FROM Uyeler
GROUP BY cinsiyet;

















