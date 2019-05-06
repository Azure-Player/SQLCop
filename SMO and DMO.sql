ALTER PROCEDURE [SQLCop].[test SMO and DMO]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#SMO_and_DMO_XPs
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
    Set @Output = ''

    select @Output = @Output + 'Status: SMO and DMO procedures are enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'SMO and DMO XPs'
           and value_in_use = 1
    
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/SQLCop_informational_checks#SMO_and_DMO_XPs'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End 
		
END;