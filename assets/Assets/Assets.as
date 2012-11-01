package Assets 
{
	import Database.Connection;

	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.Bitmap;

	import flash.events.Event;

	import flash.net.URLRequest;
	import flash.filesystem.File;

	/*
	Loads all files into memory. Right now this is just
	an image loader.
	*/
	public class Assets
	{
		// A lookup table for the loaded bitmaps.
		private var images:Array = new Array;

		// The result of the sql query to the database.
		// The paths array is popped until all entires
		// have been loaded.
		private var paths:Array = null;

		// The name of the image being loaded.
		private var nextName:String = null;

		// Called when all assets have been loaded.
		private var onLoad:Function = null;

		// Stores the connection so that multiple assets
		// can be loaded.
		private var connection:Connection = null;

		/*
		Loads assets listed in the asset table into memory.
		After the load is complete, the function calls onLoad.
		*/
		public function load(connection:Connection,
		                     onLoad:Function):void
		{
			trace('[Assets]', 'Creating the database.');

			// Copy in the parameters for later use.
			this.connection = connection;
			this.onLoad = onLoad;

			// Querry the database for the list of paths to
			// be loaded.
			var querry:String = 'select name,path from assets\
			                     where type = :type'
			var parameters:Array = new Array();
			// For now, this is just an image loader.
			parameters[':type'] = 'image';
			paths = connection.execute(querry,parameters);

			// Exit early.
			if (paths == null)
			{
				throw new Error('[Assets] No assets found.');
			}

			// Get the path of the element to be loaded.
			var row:Object = paths.pop();
			nextName = row.name;

			// Load the first image.
			loadPath(row.path,loaded);
		}

		/*
		Retrieves a sprite object containing the named image.
		*/
		public function getImage(name:String):Sprite
		{
			// Create a new sprite to contain the bitmap.
			// This way, we don't have to copy the bitmap,
			// just treat the images array like a library.
			var image:Sprite = new Sprite();
			image.addChild(images[name]);
			return image;
		}

		/*
		Loads the given path. onLoad is called to handle the load.
		*/
		private function loadPath(path:String, onLoad:Function):void
		{
			trace('[Assets]', 'Loading image:',path);

			// Look up the file in the local file system.
			var appDirectory:File = File.applicationDirectory;
			var file:File = appDirectory.resolvePath(path);

			// Create a URLRequest for the file; it's a wrapper
			// for the loader's path structure.
			var urlRequest:URLRequest = new URLRequest(file.url);

			// Create the loader, load the file and set a callback.
			var loader:Loader = new Loader();
			loader.load(urlRequest);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
			                                          onLoad);
		}

		private function loaded(event:Event):void
		{
			// Save the loaded bitmap to the images array.
			var image:Bitmap = (Bitmap)(event.target.content);

			// Store the loaded image.
			images[nextName] = image;

			// Check to see if we've finished.
			if (paths.length < 1)
			{
				// Call the on load function.
				onLoad();
			}
			else
			{
				// Move to the next image.
				var row:Object = paths.pop();
				nextName = row.name;

				// Load the next image.
				loadPath(row.path,loaded);
			}
		}
	} //public class Assets 
} //package objects

