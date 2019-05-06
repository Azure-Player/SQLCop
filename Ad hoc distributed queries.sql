ALTER PROCEDURE [SQLCop].[test Ad hoc distributed queries]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#Ad_Hoc_Distributed_Queries
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
	Set @Output = ''

    select	@Output = 'Status: Ad Hoc Distributed Queries are enabled'
    from	sys.configurations
    where	name = 'Ad Hoc Distributed Queries'
			and value_in_use = 1
           
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#Ad_Hoc_Distributed_Queries'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End
END;