USE Spital;
GO
--=======VIEWS==========================

--afiseaza numele si telefonul pacientilor care au adresa 'Teodor Mihali 60'
CREATE VIEW view_1 AS
	SELECT P.nume_p,P.telefon_p FROM Pacient P WHERE P.adresa_p='Teodor Mihali 60';

GO
SELECT * FROM view_1;
GO

--afiseaza toti pacientii care au fost internati intr-una din lunile iulie sau august din 2022
CREATE VIEW view_2 AS
	SELECT DISTINCT P.nume_p FROM Pacient P, Internare I WHERE P.cod_p=I.cod_p AND data_internare>='2022-07-01' AND I.data_externare<='2022-08-31';
	

GO
SELECT * FROM view_2;
GO

--afiseaza totalul de pacienti ingrijiti de fiecare asistent dintr-un anumit salon
CREATE VIEW view_3 AS
	SELECT A.nume_a, COUNT(I.cod_p) AS nr_pacienti FROM Internare I,Asistent A WHERE A.cod_a=I.cod_a AND I.cod_s=260370 GROUP BY A.nume_a;

GO

--==========================================================================================================
select * from Tables;
select * from Views;
INSERT INTO Tables(Name) VALUES ('Pacient'),('Internare'),('Salon_Asistent');
INSERT INTO Views(Name) VALUES ('view_1'),('view_2'),('view_3');
INSERT INTO Tests(Name) VALUES ('test_1')
INSERT INTO TestViews(TestID,ViewID) VALUES (4,1),(4,2),(4,3)
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES (4,1,1000,3),(4,2,1000,2),(4,3,1000,1)
go

exec main_test @test_name='test_1'

go
select * from Tables;
select * from Views;
select * from Tests;
select * from TestViews
select * from TestTables;
select * from TestRuns
select * from TestRunTables
select * from TestRunViews

delete from TestRuns
delete from TestRunTables
delete from TestRunViews


/*
select * from Salon
select * from Sectie
select * from Asistent

declare @contor int
set @contor=1
while (@contor<=10000)
begin
	insert into Salon(numar_s,capacitate_s,cod_se) values(@contor,5,1)
	insert into Asistent(nume_a) values ('nume' + CONVERT(varchar(5),@contor))
	set @contor = @contor+1
end
*/


