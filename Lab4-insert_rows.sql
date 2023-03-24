CREATE PROCEDURE insert_rows
	@no_of_rows INT,
	@table_name varchar(30)
AS
BEGIN
	DECLARE @contor INT
	SET @contor = 1

	declare @nume_p varchar(100)
	declare @adresa_p varchar(50)
	set @adresa_p = 'Teodor Mihali 60'
	declare @telefon_p varchar(50)
	set @telefon_p = '0757345678'


	declare @cod_p INT
	
	declare @cod_m INT
	set @cod_m  = 1
	declare @cod_a INT
	set @cod_a = 260371
	declare @cod_s INT
	set @cod_s = 260370
	declare @data_internare DATE
	set @data_internare = '2022-08-20'
	declare @data_externare DATE
	set @data_externare = '2022-08-25'

	declare @cod_sa INT
	declare @cod_as INT

	WHILE (@contor <= @no_of_rows)
	BEGIN
		IF (@table_name = 'Pacient')
		BEGIN
			SET @nume_p = 'nume' + CONVERT(varchar(5),@contor)
			INSERT INTO Pacient(nume_p,adresa_p,telefon_p) VALUES (@nume_p,@adresa_p,@telefon_p)
		END

		IF (@table_name = 'Internare')
		BEGIN
			SET @cod_p = (select min(cod_p) from Pacient)+@contor-1
			INSERT INTO Internare(cod_p, cod_m, cod_a, cod_s, data_internare, data_externare) VALUES(@cod_p,@cod_m,@cod_a,@cod_s,@data_internare,@data_externare)
		END

		IF (@table_name = 'Salon_Asistent')
		BEGIN
		SET @cod_sa = (select min(cod_s) from Salon)+@contor-1
		SET @cod_as = (select min(cod_a) from Asistent)+@contor-1
		INSERT INTO Salon_Asistent(cod_s,cod_a) VALUES(@cod_sa,@cod_as)
		END

		SET @contor = @contor + 1
	END

END

/*
go
select * from Asistent
select * from Salon

exec delete_rows @table_name ='Pacient'
exec insert_rows @no_of_rows=10,@table_name='Pacient'
select * from Pacient

exec delete_rows @table_name ='Internare'
exec insert_rows @no_of_rows=10,@table_name='Internare'
select * from Internare

exec delete_rows @table_name ='Salon_Asistent'
exec insert_rows @no_of_rows=10,@table_name='Salon_Asistent'
select * from Salon_Asistent
*/