ALTER PROCEDURE [SQLCop].[test xp_cmdshell is enabled]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#xp_cmdshell
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
	Set @Output = ''

    select @Output = @Output + 'Warning: xp_cmdshell is enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'xp_cmdshell'
           and value_in_use = 1
    
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#xp_cmdshell'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End 
END;