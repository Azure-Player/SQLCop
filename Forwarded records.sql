ALTER PROCEDURE [SQLCop].[test Forwarded Records]
AS
BEGIN
	-- Written by George Mastros
	-- February 25, 2012
	-- http://sqlcop.lessthandot.com
	-- http://wiki.lessthandot.com/index.php/Finding_Forwarded_Records_SQL_Server_2008
	
	SET NOCOUNT ON
	
	DECLARE @Output VarChar(max)
	SET @Output = ''

    If Exists(Select cmptlevel from master.dbo.sysdatabases Where dbid = db_ID() And cmptlevel > 80)
		Begin
			Create Table #Results(ProblemItem VarChar(1000))
			
			Insert Into #Results(ProblemItem)
			Exec ('	SELECT	SCHEMA_NAME(O.Schema_Id) + ''.'' + O.name As ProblemItem
					FROM	sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, ''DETAILED'') AS ps
							INNER JOIN sys.indexes AS i      
								ON ps.OBJECT_ID = i.OBJECT_ID
								AND ps.index_id = i.index_id
							INNER JOIN sys.objects as O
								On i.OBJECT_ID = O.OBJECT_ID
					WHERE  ps.forwarded_record_count > 0
					Order By SCHEMA_NAME(O.Schema_Id),O.name')
			
			If Exists(Select 1 From #Results)
				Select	@Output = @Output + ProblemItem + Char(13) + Char(10)
				From	#Results
			
		End
    Else
      Set @Output = 'Unable to check index forwarded records when compatibility is set to 80 or below'

	If @Output > '' 
		Begin
			Set @Output = Char(13) + Char(10) 
						  + 'For more information:  '
						  + 'http://wiki.lessthandot.com/index.php/Finding_Forwarded_Records_SQL_Server_2008'
						  + Char(13) + Char(10) 
						  + Char(13) + Char(10) 
						  + @Output
			EXEC tSQLt.Fail @Output
		End	  
  
END;