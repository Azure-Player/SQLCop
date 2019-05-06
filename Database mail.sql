ALTER PROCEDURE [SQLCop].[test Database Mail]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#Database_Mail_XPs
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
	Set @Output = ''

    select @Output = @Output + 'Status: Database Mail procedures are enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'Database Mail XPs'
           and value_in_use = 1
                   
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#Database_Mail_XPs'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End  
  
END;