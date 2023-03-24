CREATE PROCEDURE select_views
	@view_name varchar(10)
AS
BEGIN
	if @view_name = 'view_1'
	begin
		select * from view_1
	end

	if @view_name = 'view_2'
	begin
		select * from view_2
	end

	if @view_name = 'view_3'
	begin
		select * from view_3
	end
END

/*
exec select_views @view_name='view_1'
exec select_views @view_name='view_2'
exec select_views @view_name='view_3'
*/