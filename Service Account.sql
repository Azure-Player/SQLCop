ALTER PROCEDURE [SQLCop].[test Service Account]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://msdn.microsoft.com/en-us/library/ms143504.aspx#Use_startup_accounts
	
    SET NOCOUNT ON

	Declare @Output VarChar(max)
	Set @Output = ''

    --Declare a variable to hold the value
    DECLARE @serviceaccount varchar(100)

    --Retrieve the Service account from registry
    EXECUTE master.dbo.xp_instance_regread
            N'HKEY_LOCAL_MACHINE',
            N'SYSTEM\CurrentControlSet\Services\MSSQLSERVER',
            N'ObjectName',
            @ServiceAccount OUTPUT,
            N'no_output'

    --Display the Service Account
    SELECT @Output = 'Service account set to LocalSystem'
    Where  @ServiceAccount = 'LocalSystem'	
    
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://msdn.microsoft.com/en-us/library/ms143504.aspx#Use_startup_accounts'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End  
		
END;