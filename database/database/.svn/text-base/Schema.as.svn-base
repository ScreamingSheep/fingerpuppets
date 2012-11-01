package database
{
	import database.Connection;

	/*
	Used to manage the schema.
	*/
	public class Schema
	{
		/*
		Upgrades the database to the current revision.
		*/
		public function create(connection:Connection):void
		{
			trace('[database]', 'Creating the database.');
			connection.execute('create table objects\
			              (id int primary key autoincrement)',[]);
		}

		/*
		Drops a schema entirely. Useful for resetting if
		something goes wrong.
		*/
		public function drop(connection:Connection):void
		{
			trace('[database]', 'Dropping the database.');
			connection.execute('drop table if exists objects;',[]);
		}
	} //class Schema
} //package database
