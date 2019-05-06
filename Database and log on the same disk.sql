ALTER PROCEDURE [SQLCop].[test Database and Log files on the same disk]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://www.brentozar.com/archive/2009/02/when-should-you-put-data-and-logs-on-the-same-drive/
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
	Set @Output = ''

    Select @Output = @Output + db_name() + Char(13) + Char(10)
    FROM   sys.database_files
    Having Count(*) != Count(Distinct Left(Physical_Name, 3)) 
    
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://www.brentozar.com/archive/2009/02/when-should-you-put-data-and-logs-on-the-same-drive/'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End
END;