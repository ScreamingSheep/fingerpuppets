package database
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
		private var databasePath:String = 'fingerpuppets.db';
		public var lastInsertRowID:int = 0;

		/*
		Open a connection to the database.
		*/
		public function open():void
		{
			trace('[database]','Opening database connection.');

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
			trace('[database]', 'Closing the connection.');
			connection.close();
		}

		/*
		Commits the connection.
		*/
		public function commit():void
		{
			trace('[database]', 'Committing the connection.');
			connection.commit();
		}

		/*
		Run an sql statement.
		*/
		public function execute(sql:String,
		                        parameters:Array):Array
		{
			trace('[database]', 'Executing the sql statement.');

			// Construct the sql statement.
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = connection;
			statement.text = sql;

			// Pass the parameters into the statement.
			statement.clearParameters();
			if ( parameters != null && parameters.length > 0 )
			{
				for (var i:int = 0; i < parameters.length; i++)
				{
					statement.parameters[i] = parameters[i];
				}
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

