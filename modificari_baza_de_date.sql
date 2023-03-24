USE Spital;

GO

CREATE TABLE Versiuni(
	cod_v INT PRIMARY KEY IDENTITY,
	versiune_curenta INT
);

INSERT INTO Versiuni (versiune_curenta) VALUES(0);

GO

CREATE PROCEDURE creeazaTabela  --V1
AS
BEGIN
	CREATE TABLE Vizitator(
		cod_v INT PRIMARY KEY IDENTITY,
		nume_v VARCHAR(50) NOT NULL,
		cod_p INT,
		CONSTRAINT fk_PacientVizitator FOREIGN KEY (cod_p) REFERENCES Pacient(cod_p)
	);
END

EXEC creeazaTabela;

GO

CREATE PROCEDURE stergeTabela  --V1 UNDO
AS
BEGIN
	DROP TABLE Vizitator;
END
EXEC  stergeTabela;
GO


CREATE PROCEDURE modificaTipColoana --V2
AS
BEGIN
	ALTER TABLE Vizitator
	ALTER COLUMN nume_v VARCHAR(100) NOT NULL;
END

EXEC modificaTipColoana;

GO

CREATE PROCEDURE undoModificaTipColoana  --V2 UNDO
AS
BEGIN
	ALTER TABLE Vizitator
	ALTER COLUMN nume_v VARCHAR(50) NOT NULL;
END
GO
EXEC undoModificaTipColoana;

GO

CREATE PROCEDURE adaugaCamp  --V3
AS
BEGIN
	ALTER TABLE Vizitator
	ADD data_vizita DATE;
END
EXEC adaugaCamp;

GO
CREATE PROCEDURE stergeCamp  --V3 UNDO
AS
BEGIN
	ALTER TABLE Vizitator
	DROP COLUMN data_vizita;
END
EXEC stergeCamp;

GO
CREATE PROCEDURE constrangereValoareDefault -- V4
AS
BEGIN
	ALTER TABLE Vizitator
	ADD CONSTRAINT default_data_vizita DEFAULT GETDATE() FOR data_vizita;
END
EXEC constrangereValoareDefault;

GO 
CREATE PROCEDURE undoConstrangereValoareDefault --V4 UNDO
AS
BEGIN
	ALTER TABLE Vizitator
	DROP CONSTRAINT default_data_vizita;
END
EXEC undoConstrangereValoareDefault


GO
CREATE PROCEDURE constrangereForeignKey  --V5
AS
BEGIN
	ALTER TABLE Vizitator
	DROP CONSTRAINT fk_PacientVizitator
END
EXEC constrangereForeignKey;

GO
CREATE PROCEDURE undoConstrangereForeignKey  --V5 UNDO
AS
BEGIN
	ALTER TABLE Vizitator
	ADD CONSTRAINT fk_PacientVizitator FOREIGN KEY (cod_p) REFERENCES Pacient (cod_p);
END
EXEC undoConstrangereForeignKey;

GO

CREATE PROCEDURE changeVersion @versiune INT
AS
BEGIN
	IF(@versiune>5 OR @versiune<0)
		RAISERROR('Numarul versiunii este invalid',16,1);
	DECLARE @versiuneCurenta INT;
	SELECT @versiuneCurenta= versiune_curenta FROM Versiuni;
	
	IF(@versiuneCurenta<@versiune)
		WHILE @versiuneCurenta<@versiune
			BEGIN	
				IF(@versiuneCurenta=0)
					BEGIN
					EXEC creeazaTabela;
					SET @versiuneCurenta=1;
					END
				IF(@versiuneCurenta=1)
					BEGIN
					EXEC modificaTipColoana;
					SET @versiuneCurenta=2;
					END
				IF(@versiuneCurenta=2)
					BEGIN
					EXEC adaugaCamp;
					SET @versiuneCurenta=3;
					END
				IF(@versiuneCurenta=3)
					BEGIN
					EXEC constrangereValoareDefault;
					SET @versiuneCurenta=4;
					END
				IF(@versiuneCurenta=4)
					BEGIN
					EXEC constrangereForeignKey;
					SET @versiuneCurenta=5;
					END
			END
	IF(@versiuneCurenta>@versiune)
		WHILE @versiuneCurenta>@versiune
			BEGIN	
				IF(@versiuneCurenta=1)
					BEGIN
					EXEC  stergeTabela;
					SET @versiuneCurenta=0;
					END
				IF(@versiuneCurenta=2)
					BEGIN
					EXEC undoModificaTipColoana;
					SET @versiuneCurenta=1;
					END
				IF(@versiuneCurenta=3)
					BEGIN
					EXEC stergeCamp;
					SET @versiuneCurenta=2;
					END
				IF(@versiuneCurenta=4)
					BEGIN
					EXEC undoConstrangereValoareDefault
					SET @versiuneCurenta=3;
					END
				IF(@versiuneCurenta=5)
					BEGIN
					EXEC undoConstrangereForeignKey;
					SET @versiuneCurenta=4;
					END
			END
	UPDATE Versiuni SET versiune_curenta=@versiuneCurenta;
	PRINT 'Versiune actualizata cu succes!!'

END

EXEC changeVersion @versiune=7;
select * from Versiuni;

insert into Vizitator (nume_v,cod_p) values ('andrei',101)
select * from Vizitator;
select * from Pacient;
delete from Vizitator
