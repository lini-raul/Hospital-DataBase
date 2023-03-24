USE Spital;
GO

--validare email
CREATE FUNCTION validareEmail (@email VARCHAR(50))
RETURNS BIT AS
BEGIN
	IF(@email IS NULL OR @email='')
		RETURN 0;
	RETURN 1;
END;
GO

--validare specializare
CREATE FUNCTION validareSpecializare (@specializare VARCHAR(20))
RETURNS BIT AS
BEGIN
	IF(@specializare IS NULL OR @specializare='')
		RETURN 0;
	RETURN 1;
END;
GO


--PROCEDURA CREATE
CREATE PROCEDURE adaugaMedic @nume_m VARCHAR(100), @email_m VARCHAR(50),@specializare VARCHAR(20)
AS
BEGIN
	IF(dbo.validareNume(@nume_m)=0)
		THROW 50003,'Numele nu este valid!!',1;
	IF(dbo.validareEmail(@email_m)=0)
		THROW 50003,'Email-ul nu este valid!!',1;
	IF(dbo.validareSpecializare(@specializare)=0)
		THROW 50003,'Specializarea nu este valida!!',1;

	INSERT INTO Medic(nume_m,email_m,specializare) VALUES (@nume_m, @email_m, @specializare);
END;

exec adaugaMedic @nume_m='Dan George', @email_m='dgeorge@yahoo.com',@specializare='Stomatologie';
select * from Medic;
GO
--PROCEDURA READ
CREATE PROCEDURE returneazaMedicSpecializare @specializare VARCHAR(20)
AS
BEGIN
	SELECT * FROM Medic WHERE specializare=@specializare;
END;
GO

EXEC returneazaMedicSpecializare @specializare='Cardiologie';
GO
--PROCEDURA UPDATE
CREATE PROCEDURE modificaMedicEmail @cod_m INT, @email_m VARCHAR(50)
AS
BEGIN
	IF(dbo.validareEmail(@email_m)=0)
		THROW 50003,'Email-ul nu este valid!!',1;

	UPDATE Medic SET email_m=@email_m WHERE cod_m=@cod_m;
END;
GO
--testare modificaMedicEmail
exec modificaMedicEmail @cod_m=4,@email_m='dangeorge123@yahoo.com';
select * from Medic;
GO

--PROCEDURA DELETE
CREATE PROCEDURE stergeMedic @cod_m INT
AS
BEGIN
	DELETE FROM Medic WHERE cod_m=@cod_m;
END;
go
--test delete
exec stergeMedic @cod_m=4;
select * from Medic;
