ALTER PROCEDURE [SQLCop].[test Compatibility Level]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/Database_compatibilty_level
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
	Set @Output = ''

	Select @Output = @Output + Name + Char(13) + Char(10)
	FROM   master.dbo.sysdatabases
	WHERE  cmptlevel != 10 * CONVERT(Int, CONVERT(FLOAT, CONVERT(VARCHAR(3), SERVERPROPERTY('productversion'))))

	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/Database_compatibilty_level'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End
  
END;