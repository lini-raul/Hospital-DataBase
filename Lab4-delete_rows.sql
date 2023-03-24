CREATE PROCEDURE delete_rows
	@table_name varchar(20)
AS
BEGIN
	IF (@table_name = 'Pacient')
		BEGIN
			DELETE FROM Pacient
		END

	IF (@table_name = 'Internare')
		BEGIN
			DELETE FROM Internare
		END

	IF (@table_name = 'Salon_Asistent')
		BEGIN
			DELETE FROM Salon_Asistent
		END
END;



go
exec delete_rows @table_name='Salon_Asistent';
go
select * from Salon_Asistent;


INSERT Salon_Asistent(cod_s,cod_a) VALUES (1,1),(1,2),(2,3),(2,4),(3,3),(3,4),(2,5);
