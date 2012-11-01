package Database
{
	import flash.filesystem.File;

	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.data.SQLConnection;

	import flash.events.SQLEvent;
	import flash.events.SQLErrorEvent;

	/*
	A loose wrapper around a database connection.
	*/
	public class Connection
	{
		private var connection:SQLConnection = null;
		public var lastInsertRowID:int = 0;

		/*
		Open a connection to the database.
		*/
		public function open(databasePath:String):void
		{
			trace('[Database]','Opening database connection.');

			// Initialise the connection.
			connection = new SQLConnection();
			var appStorage:File = File.applicationStorageDirectory;
			var databaseFile:File = appStorage.resolvePath(databasePath);

			// Open the connection.
			connection.open(databaseFile);
		}

		/*
		Closes the connection to the database. Be sure that all
		operations on the database have completed before calling
		this function or you may receive an exception.
		*/
		public function close():void
		{
			trace('[Database]', 'Closing the connection.');
			connection.close();
		}

		/*
		Commits the connection. This function can only be called
		when there's an open transaction. Otherwise you get an
		exception.
		*/
		public function commit():void
		{
			trace('[Database]', 'Committing the connection.');
			connection.commit();
		}

		/*
		Frees up space in the database file by deleteing data
		that has been deleted in SQL. This function is useful
		after you've dropped a table.
		*/
		public function compact():void
		{
			trace('[Database]', 'Cleaning the database.');
			connection.compact();
		}

		/*
		Run an sql statement.
		*/
		public function execute(sql:String,
		                        parameters:Array):Array
		{
			trace('[Database]', 'Executing the sql statement:',sql);

			// Construct the sql statement.
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = connection;
			statement.text = sql;

			// Copy parameters in.
			for (var item:String in parameters)
			{
				statement.parameters[item] = parameters[item];
			}

			// Execute.
			statement.execute();

			// Get the result.
			var result:SQLResult = statement.getResult();
			lastInsertRowID = result.lastInsertRowID;
			return result.data;
		}
	} //public class Connection
} //package database

