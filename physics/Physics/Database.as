package Physics
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
			trace('[Physics]', 'Creating the schema.');

			// Create the assets table.
			connection.execute('\
				create table if not exists worlds\
				(\
					id int primary key autoincrement,\
					name varchar(32) not null unique,\
					timestep number not null,\
					velocity_iterations int not null,\
					position_iterations int not null,\
					gravity_x number not null,\
					gravity_y number not null,\
					do_sleep boolean not null
				)',[]);
		}

		/*
		Inserts a world into the database.
		*/
		public function insertWorld(connection:Connection,
		                            name:String,
		                            timeStep:Float,
		                            velocityIterations:Int,
		                            positionIterations:Int,
		                            gravityX:Float,
		                            gravityY:float,
		                            doSleep:Boolean):void
		{
			trace('[Physics]','Inserting world:',name);

			// Generate the parameters list.
			var parameters:Array = new Array();
			parameters[':name'] = name;
			parameters[':name'] = name;
			parameters[':name'] = name;
			parameters[':name'] = name;
			parameters[':name'] = name;

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
			trace('[Physics]', 'Dropping the schema.');

			// Drop the assets table.
			connection.execute('drop table if exists worlds',[]);

			// Free up the space used on disk.
			connection.compact();
		}
	} //class Schema
} //package objects

