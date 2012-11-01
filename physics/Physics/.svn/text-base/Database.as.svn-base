package Assets
{
	import Database.Connection;

	/*
	Used to manage the schema for the objects library.
	*/
	public class Database
	{
		/*
		Upgrades the database to the current revision.
		*/
		public function create(connection:Connection):void
		{
			trace('[Assets]', 'Creating the schema.');

			// Create the assets table.
			connection.execute('\
				create table if not exists assets\
				(\
					id int primary key autoincrement,\
					name varchar(32) not null unique,\
					type varchar(32) not null,\
					path varchar(256) not null\
				)',[]);
		}

		/*
		Inserts an asset into the database. name must be 32
		chars or shorter. path must be 256 chars or shorter.
		path is given relative to the application directory.

		Type can be one of 'image'.
		*/
		public function insertAsset(connection:Connection,
		                            name:String,
		                            type:String,
		                            path:String):void
		{
			trace('[Assets]',
			      'Inserting asset:',
			      name,'(',type,'): ',path);

			// Generate the parameters list.
			var parameters:Array = new Array();
			parameters[':name'] = name;
			parameters[':type'] = type;
			parameters[':path'] = path;

			// Insert the asset.
			connection.execute('insert into assets values \
			                    (null,:name,:type,:path)',
			                    parameters);
		}

		/*
		Drops a schema entirely. Useful for resetting if
		something goes wrong.
		*/
		public function drop(connection:Connection):void
		{
			trace('[Assets]', 'Dropping the database.');

			// Drop the assets table.
			connection.execute('drop table if exists assets',[]);

			// Free up the space used on disk.
			connection.compact();
		}
	} //class Schema
} //package objects

