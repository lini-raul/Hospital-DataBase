CREATE DATABASE Spital;
GO
USE Spital;

CREATE TABLE Pacient(
	cod_p INT PRIMARY KEY IDENTITY,
	nume_p VARCHAR(100) NOT NULL UNIQUE,
	adresa_p VARCHAR(50),
	telefon_p VARCHAR(50)
);

CREATE TABLE Boala(
	cod_b INT PRIMARY KEY IDENTITY,
	nume_b VARCHAR(100) NOT NULL,
	simptome_b VARCHAR(100)
);

CREATE TABLE Medicament(
	cod_m INT PRIMARY KEY IDENTITY,
	nume_m VARCHAR(100) NOT NULL
);

CREATE TABLE Medic(
	cod_m INT PRIMARY KEY IDENTITY,
	nume_m VARCHAR(100) NOT NULL,
	email_m VARCHAR(50)
);

CREATE TABLE Sectie(
	cod_s INT PRIMARY KEY IDENTITY,
	denumire_s VARCHAR(50) NOT NULL
);

CREATE TABLE Salon(
	cod_s INT PRIMARY KEY IDENTITY,
	numar_s INT NOT NULL,
	capacitate_s INT NOT NULL
);

CREATE TABLE Asistent(
	cod_a INT PRIMARY KEY IDENTITY,
	nume_a VARCHAR(100),
);


CREATE TABLE Reteta(
	cod_p INT,
	cod_b INT,
	cod_m int,
	CONSTRAINT fk_BoalaReteta FOREIGN KEY (cod_b) REFERENCES Boala(cod_b),
	CONSTRAINT fk_MedicamentReteta FOREIGN KEY (cod_m) REFERENCES Medicament(cod_m),
	CONSTRAINT fk_PacientReteta FOREIGN KEY (cod_p) REFERENCES Pacient(cod_p),
	CONSTRAINT pk_Reteta PRIMARY KEY(cod_p, cod_b, cod_m)
);

CREATE TABLE Salon_Asistent(
	cod_s INT,
	cod_a INT,
	CONSTRAINT fk_Salon FOREIGN KEY (cod_s) REFERENCES Salon(cod_s),
	CONSTRAINT fk_Asistent FOREIGN KEY (cod_a) REFERENCES Asistent(cod_a),
	CONSTRAINT pk_SalonAsistent PRIMARY KEY (cod_s,cod_a)
);


CREATE TABLE Internare(
	cod_i INT PRIMARY KEY IDENTITY,
	cod_p INT,
	cod_m INT,
	cod_a INT,
	cod_s INT,
	CONSTRAINT fk_PacientInternare FOREIGN KEY (cod_p) REFERENCES Pacient(cod_p),
	CONSTRAINT fk_MedicInternare FOREIGN KEY (cod_m) REFEReNCES Medic(cod_m),
	CONSTRAINT fk_AsistentInternare FOREIGN KEY (cod_a) REFERENCES Asistent(cod_a),
	CONSTRAINT fk_SalonInternare FOREIGN KEY (cod_s) REFERENCES Salon(cod_s)

);

ALTER TABLE Salon
ADD cod_se INT;

ALTER TABLE Salon
ADD CONSTRAINT fk_SalonSectie FOREIGN KEY (cod_se) REFERENCES Sectie (cod_s);

ALTER TABLE Internare
ADD data_internare DATE,
	data_externare DATE;

ALTER TABLE Reteta
DROP CONSTRAINT pk_reteta;

ALTER TABLE Reteta
ADD cod_r INT PRIMARY KEY IDENTITY;

CREATE TABLE Reteta_Medicament(
	cod_r INT,
	cod_m INT,
	CONSTRAINT fk_Reteta FOREIGN KEY (cod_r) REFERENCES Reteta(cod_r),
	CONSTRAINT fk_Medicament FOREIGN KEY (cod_m) REFERENCES Medicament(cod_m),
	CONSTRAINT pk_RetetaMedicament PRIMARY KEY(cod_r, cod_m)
);

ALTER TABLE Reteta
DROP CONSTRAINT fk_MedicamentReteta;

ALTER TABLE Reteta
DROP COLUMN cod_m;

--============Lab2=======================================

INSERT INTO Medic (nume_m,email_m) VALUES ('Pop Ioan','popioan@yahoo.com'),('Ionescu Vasile','ionescuv@yahoo.com');

INSERT INTO Sectie(denumire_s) VALUES ('Cardiologie'),('Pneumologie');

INSERT INTO Asistent(nume_a) VALUES ('Lapuste Andreea'),('Mulcutan Vlad'),('Paul Teodora'),('Ardelean Maria');

INSERT INTO Pacient(nume_p, adresa_p,telefon_p) VALUES ('Variu Andrei', 'Castanelor 2','0742123123'),('Aciu Elena','Rasaritului 70','0742859463'),
														('Badic Mihai','Tarnavei 8','0748264987'),('Bicu Aida','Dorobantilor 35','0742379726'),
														('Cernat Mihai','Portelanului 22','0742845658');

INSERT INTO Boala(nume_b, simptome_b) VALUES('Coronariana','durere in piept, lipsa de aer'),('Miocardita','durere toracica, oboseala'),
											('Astm', 'dificultati in respiratie,tuse'),('Bronsita','tuse, sinusuri blocate');

INSERT INTO Medicament(nume_m) VALUES ('nitroglicerina'),('betablocante'),('vasodilatatoare'),('diuretice'),('budesonid'),('beclometazona'),('fluticazona'),
										('aerosoli');


INSERT INTO Salon(numar_s,capacitate_s,cod_se) VALUES (1,5,1),(1,6,2),(2,6,2);


INSERT Salon_Asistent(cod_s,cod_a) VALUES (1,1),(1,2),(2,3),(2,4),(3,3),(3,4);

INSERT Internare(cod_p, cod_m, cod_a, cod_s, data_internare, data_externare) VALUES
								(1, 1, 1, 1, '2022-08-20', '2022-08-25'),
								(2, 1, 2, 1, '2022-05-12', '2022-05-15'),
								(3, 1, 2, 1, '2022-05-14', '2022-05-18'),
								(4, 2, 3, 2, '2022-07-23', '2022-07-25'),
								(5, 2, 3, 3, '2022-09-28', '2022-10-04');

INSERT INTO Reteta(cod_p,cod_b) VALUES (1, 1),
								  (2, 1),
								  (3, 2),
								  (4, 3),
								  (5, 4);

INSERT INTO Reteta_Medicament(cod_r,cod_m) VALUES (1, 1),
												  (1, 2),
												  (1, 3),
												  (2, 1),
												  (2, 2),
												  (2, 3),
												  (3, 4),
												  (3, 5),
												  (4, 6),
												  (4, 7),
												  (5, 7),
												  (5, 8);



select * from Pacient;
select * from Medic;
select * from Salon;
select * from Boala;
select * from Medicament;
select * from Internare;
select * from Reteta;
select * from Reteta_Medicament;

--INSERT INTO Salon(numar_s,capacitate_s,)
--USE master;
--DROP DATABASE Spital;