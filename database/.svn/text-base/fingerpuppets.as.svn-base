/*
Entry point for the main application.
*/

package
{
	import flash.display.Sprite;
	import database.Connection;
	import database.Schema;

	// Standard dimentions for the playbook.
	[SWF(height='600', width='1024', frameRate='30', backgroundColor='#000000')]

	public class fingerpuppets extends Sprite
	{
		private var connection:Connection = null;

		public function fingerpuppets()
		{
			trace('[fingerpuppets]', 'Hello World!');
			connection = new Connection();
			connection.open();

			var schema:Schema = new Schema();
			//theSchema.create(connection);
			//theSchema.drop(connection);

			connection.close();
		}
	}
}
