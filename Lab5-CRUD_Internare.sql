USE Spital;
GO

--validare perioada internare
CREATE FUNCTION validarePerioadaInternare(@data_internare DATE, @data_externare DATE)
RETURNS BIT AS
BEGIN
	--IF(ISDATE(@data_internare)=0 OR ISDATE(@data_externare)=0)
		--RETURN 0;
	IF(@data_internare>@data_externare)
		RETURN 0;
	IF(@data_internare>GETDATE() OR @data_externare>GETDATE())
		RETURN 0;
	RETURN 1;
END;
GO
--testare validare perioada internare
print dbo.validarePerioadaInternare('2022-08-20','2022-08-25')
print dbo.validarePerioadaInternare('2022-08-26','2023-08-25')
select * from Internare
GO

--validare cod pacient
CREATE FUNCTION validareCod_p(@cod_p INT)
RETURNS BIT AS
BEGIN
	IF((SELECT COUNT(*) FROM Pacient WHERE cod_p=@cod_p)=0)
		RETURN 0;
	RETURN 1;

END;
GO
--testare validareCod_p
PRINT dbo.validareCod_p(2300);
PRINT dbo.validareCod_p(9999);
GO

--validare cod medic
CREATE FUNCTION validareCod_m(@cod_m INT)
RETURNS BIT AS
BEGIN
	IF((SELECT COUNT(*) FROM Medic WHERE cod_m=@cod_m)=0)
		RETURN 0;
	RETURN 1;

END;
GO
--testare validareCod_m
PRINT dbo.validareCod_m(1);
PRINT dbo.validareCod_m(9999);
GO

--validare cod asistent
CREATE FUNCTION validareCod_a(@cod_a INT)
RETURNS BIT AS
BEGIN
	IF((SELECT COUNT(*) FROM Asistent WHERE cod_a=@cod_a)=0)
		RETURN 0;
	RETURN 1;

END;
GO
--testare validareCod_a
PRINT dbo.validareCod_a(260371);
PRINT dbo.validareCod_a(1);
GO

--validare cod salon
CREATE FUNCTION validareCod_s(@cod_s INT)
RETURNS BIT AS
BEGIN
	IF((SELECT COUNT(*) FROM Salon WHERE cod_s=@cod_s)=0)
		RETURN 0;
	RETURN 1;

END;
GO
--testare validareCod_s
PRINT dbo.validareCod_s(260371);
PRINT dbo.validareCod_s(1);
GO


--PROCEDURA CREATE
CREATE PROCEDURE adaugaInternare @cod_p INT, @cod_m INT, @cod_a INT, @cod_s INT, @data_internare DATE, @data_externare DATE
AS
BEGIN
	IF(dbo.validarePerioadaInternare(@data_internare, @data_externare)=0)
		THROW 50003,'Perioada de internare nu este valida!!',1;
	IF(dbo.validareCod_p(@cod_p)=0)
		THROW 50003,'Codul pacientului nu este valid!!',1;
	IF(dbo.validareCod_m(@cod_m)=0)
		THROW 50003,'Codul medicului nu este valid!!',1;
	IF(dbo.validareCod_a(@cod_a)=0)
		THROW 50003,'Codul asistentului nu este valid!!',1;
	IF(dbo.validareCod_s(@cod_s)=0)
		THROW 50003,'Codul salonului nu este valid!!',1;
	ELSE
		INSERT INTO Internare(cod_p,cod_m,cod_a,cod_s,data_internare,data_externare) VALUES(@cod_p,@cod_m,@cod_a,@cod_s,@data_internare,@data_externare);
END;
go
exec adaugaInternare @cod_p=2289, @cod_m=1, @cod_a=260371, @cod_s=260370, @data_internare='2022-08-21', @data_externare='2022-08-25';
select * from Internare;
go

--PROCEDURA READ
CREATE PROCEDURE returneazaInternareDataInternare @data_internare DATE
AS
BEGIN
	SELECT * FROM Internare WHERE data_internare=@data_internare;
END;
GO
--testare returneazaInternareDataInternare
EXEC returneazaInternareDataInternare @data_internare='2022-08-21';
GO
--PROCEDURA UPDATE
CREATE PROCEDURE modificaInternareAsistent @cod_i INT, @cod_a INT
AS
BEGIN
	IF(dbo.validareCod_a(@cod_a)=0)
		THROW 50003,'Codul asistentului nu este valid!!',1;
	UPDATE Internare SET cod_a=@cod_a WHERE cod_i=@cod_i;
END;
GO

--testare returneazaInternareDataInternare
EXEC modificaInternareAsistent @cod_i=3090, @cod_a=260404;
select * from Internare;
GO

--PROCEDURA DELETE
CREATE PROCEDURE stergeInternare @cod_i INT
AS
BEGIN
	DELETE FROM Internare WHERE cod_i=@cod_i;
END;
GO
--testare stergeInternare
exec stergeInternare @cod_i=3090;
select * from Internare;