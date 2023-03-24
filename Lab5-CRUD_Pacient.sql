USE Spital;
GO
--LAB5 CRUD PACIENT

--validare nume
CREATE FUNCTION validareNume (@nume VARCHAR(100))
RETURNS BIT AS
BEGIN
	IF(@nume IS NULL OR @nume='')
		RETURN 0;
	RETURN 1;
END;
GO
--testare validareNume
PRINT dbo.validareNume('');
PRINT dbo.validareNume('Andrei');
GO
--validare adresa
CREATE FUNCTION validareAdresa (@adresa VARCHAR(50))
RETURNS BIT AS
BEGIN
	IF(@adresa IS NULL OR @adresa='')
		RETURN 0;
	RETURN 1;
END;
GO
--testare validareAdresa
PRINT dbo.validareAdresa('');
PRINT dbo.validareAdresa('Teodor Mihali 60');
GO

--validare telefon
CREATE FUNCTION validareTelefon (@telefon VARCHAR(50))
RETURNS BIT AS
BEGIN
	IF(@telefon IS NULL)
		RETURN 0;
	IF(ISNUMERIC(@telefon)=0)
		RETURN 0;
	RETURN 1;
END;
GO
--testare validareTelefon
PRINT dbo.validareTelefon('0228as22');
PRINT dbo.validareTelefon('0757345999');
GO

--PROCEDURA CREATE
CREATE PROCEDURE adaugaPacient @nume VARCHAR(100), @adresa VARCHAR(50), @telefon VARCHAR(50)
AS
BEGIN
	IF(dbo.validareNume(@nume)=0)
		THROW 50003,'Numele nu poate sa fie null!!',1;
	IF(dbo.validareAdresa(@adresa)=0)
		THROW 50003,'Adresa nu este valida!!',1;
	IF(dbo.validareTelefon(@telefon)=0)
		THROW 50003,'Telefonul nu este valid!!',1;
	ELSE
		INSERT INTO  Pacient(nume_p,adresa_p,telefon_p) VALUES (@nume, @adresa, @telefon);
END;
GO
--testare adaugaPacient
exec adaugaPacient @nume='Mihai', @adresa='Neajlov 7', @telefon='0757345999'
select * from Pacient;
GO

--PROCEDURA READ
CREATE PROCEDURE returneazaPacientAdresa @adresa VARCHAR(50)
AS
BEGIN
	SELECT * FROM Pacient WHERE adresa_p=@adresa;
END;
--testare returneazaPacientAdresa
EXEC returneazaPacientAdresa @adresa='Neajlov 4';
EXEC returneazaPacientAdresa @adresa='Neajlov 7';
GO

--PROCEDURA UPDATE
CREATE PROCEDURE modificaPacientTelefon @cod_p INT, @telefon VARCHAR(50)
AS
BEGIN
	IF(dbo.validareTelefon(@telefon)=0)
		THROW 50003,'Telefonul este invalid!!',1

	UPDATE Pacient SET telefon_p=@telefon WHERE cod_p=@cod_p;

END;
GO
--testare modificaPacientTelefon
exec modificaPacientTelefon @cod_p=3292,@telefon='0757444888';
exec modificaPacientTelefon @cod_p=3289,@telefon='07574aa888';
select * from Pacient;
GO

--PROCEDURA DELETE
CREATE PROCEDURE stergePacient @cod_p INT
AS
BEGIN
	DELETE FROM Pacient WHERE cod_p=@cod_p;
END;
GO
--testare stergePacient
exec stergePacient @cod_p=3292;
select * from Pacient;
select * from Internare;
select * from Medic;