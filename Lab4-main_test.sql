USE Spital;
go
CREATE PROCEDURE main_test
	@test_name varchar(50)
AS
BEGIN

	--=========================================================
	--get the name of the table with position 1
	declare @tableID_1 INT
	declare @tableName_1 varchar(20)
	set @tableID_1 = (select TableID from TestTables where Position = 1 and TestID = (select TestID from Tests where Name=@test_name))
	set @tableName_1 = (select Name from Tables where TableID = @tableID_1)
	print(@tableID_1)
	print(@tableName_1)
	
	--get the name of the table with posiotion 2
	declare @tableID_2 INT
	declare @tableName_2 varchar(20)
	set @tableID_2 = (select TableID from TestTables where Position = 2 and TestID = (select TestID from Tests where Name=@test_name))
	set @tableName_2 = (select Name from Tables where TableID = @tableID_2)
	
	--get the name of the table with position 3

	declare @tableID_3 INT
	declare @tableName_3 varchar(20)
	set @tableID_3 = (select TableID from TestTables where Position = 3 and TestID = (select TestID from Tests where Name=@test_name))
	set @tableName_3 = (select Name from Tables where TableID = @tableID_3)

	

	--===========================================================

	declare @all_start datetime
	set @all_start = GETDATE();

	--DELETE
	declare @table_1_delete_start datetime
	set @table_1_delete_start = GETDATE()
	exec delete_rows @table_name = @tableName_1
	declare @table_1_delete_stop datetime
	set @table_1_delete_stop = GETDATE()

	declare @table_2_delete_start datetime
	set @table_2_delete_start = GETDATE()
	exec delete_rows @table_name = @tableName_2
	declare @table_2_delete_stop datetime
	set @table_2_delete_stop = GETDATE()

	declare @table_3_delete_start datetime
	set @table_3_delete_start = GETDATE()
	exec delete_rows @table_name = @tableName_3
	declare @table_3_delete_stop datetime
	set @table_3_delete_stop = GETDATE()


	--INSERT
	declare @noOfRows INT

	declare @table_3_insert_start datetime
	set @noOfRows = (select NoOfRows from TestTables where TableID = @tableID_3)
	set @table_3_insert_start = GETDATE()
	exec insert_rows @no_of_rows =@noOfRows, @table_name = @tablename_3;
	declare @table_3_insert_stop datetime
	set @table_3_insert_stop = GETDATE()

	declare @table_2_insert_start datetime
	set @noOfRows = (select NoOfRows from TestTables where TableID = @tableID_2)
	set @table_2_insert_start = GETDATE()
	exec insert_rows @no_of_rows =@noOfRows, @table_name = @tablename_2;
	declare @table_2_insert_stop datetime
	set @table_2_insert_stop = GETDATE()

	declare @table_1_insert_start datetime
	set @noOfRows = (select NoOfRows from TestTables where TableID = @tableID_1)
	set @table_1_insert_start = GETDATE()
	exec insert_rows @no_of_rows =@noOfRows, @table_name = @tablename_1;
	declare @table_1_insert_stop datetime
	set @table_1_insert_stop = GETDATE()

	--VIEWS
	declare @view_1_start datetime
	set @view_1_start = GETDATE()
	execute select_views @view_name = 'view_1'
	declare @view_1_stop datetime
	set @view_1_stop = GETDATE()

	declare @view_2_start datetime
	set @view_2_start = GETDATE()
	execute select_views @view_name = 'view_2'
	declare @view_2_stop datetime
	set @view_2_stop = GETDATE()

	declare @view_3_start datetime
	set @view_3_start = GETDATE()
	execute select_views @view_name = 'view_3'
	declare @view_3_stop datetime
	set @view_3_stop = GETDATE()


	declare @all_stop datetime
	set @all_stop = GETDATE()


	declare @description varchar(50)
	set @description = 'Testare '+@test_name


	insert into TestRuns(Description,StartAt,EndAt) values (@description,@all_start,@all_stop)

	--get the current TestRunID
	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);
	

	--inserting results of the inserts
	insert into TestRunTables(TestRunID,TableID,StartAt,EndAt)
	values	(@lastTestRunID, @tableID_1, @table_1_insert_start, @table_1_insert_stop),
			(@lastTestRunID, @tableID_2, @table_2_insert_start, @table_2_insert_stop),
			(@lastTestRunID, @tableID_3, @table_3_insert_start, @table_3_insert_stop);

	--inserting results of the views
	insert into TestRunViews(TestRunID, ViewID, StartAt, EndAt)
	values	(@lastTestRunID, 1, @view_1_start,@view_1_stop),
			(@lastTestRunID, 2, @view_2_start,@view_2_stop),
			(@lastTestRunID, 3, @view_3_start,@view_3_stop);


END

