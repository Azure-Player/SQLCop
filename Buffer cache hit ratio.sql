ALTER PROCEDURE [SQLCop].[test Buffer cache hit ratio]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://blogs.lessthandot.com/index.php/DataMgmt/DBAdmin/MSSQLServerAdmin/use-sys-dm_os_performance_counters-to-ge
	
	SET NOCOUNT ON
	
	Declare @Output VarChar(max)
    Set @Output = ''

	If Exists(Select 1 From fn_my_permissions(NULL, 'SERVER') WHERE permission_name = 'VIEW SERVER STATE')
		SELECT	@Output = Convert(DECIMAL(4,1), (a.cntr_value * 1.0 / b.cntr_value) * 100.0)
		FROM	sys.dm_os_performance_counters  a
				JOIN  (
					SELECT cntr_value,OBJECT_NAME
					FROM   sys.dm_os_performance_counters  
					WHERE  counter_name collate SQL_LATIN1_GENERAL_CP1_CI_AI = 'Buffer cache hit ratio base'
							AND OBJECT_NAME collate SQL_LATIN1_GENERAL_CP1_CI_AI like '%Buffer Manager%'
					) b 
					ON  a.OBJECT_NAME = b.OBJECT_NAME
		WHERE	a.counter_name collate SQL_LATIN1_GENERAL_CP1_CI_AI = 'Buffer cache hit ratio'
				AND a.OBJECT_NAME collate SQL_LATIN1_GENERAL_CP1_CI_AI like '%:Buffer Manager%'
				and Convert(DECIMAL(4,1), (a.cntr_value * 1.0 / b.cntr_value) * 100.0) < 95
	Else
		Set @Output = 'You do not have VIEW SERVER STATE permissions within this instance.'
    
	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://blogs.lessthandot.com/index.php/DataMgmt/DBAdmin/MSSQLServerAdmin/use-sys-dm_os_performance_counters-to-ge'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End 
END;