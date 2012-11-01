/*
Entry point for the main application.
*/

package
{
	import flash.display.Sprite;

	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;

	import Box2D.Common.Math.b2Vec2;

	import Box2D.Collision.Shapes.b2PolygonShape;

	import flash.events.Event;

	// Standard dimentions for the playbook.
	[SWF(width='1024', height='600', frameRate='30', backgroundColor='#000000')]

	public class fingerpuppets extends Sprite
	{
		private var world:b2World = null;

		public function fingerpuppets()
		{
			trace('[fingerpuppets]', 'Hello World!');

			// Setup the update event.
			addEventListener(Event.ENTER_FRAME, update);

			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			world = new b2World(gravity, doSleep);

			// Physics scale.
			var scale:Number = 10;

			// Create the ground.
			var shape:b2PolygonShape = new b2PolygonShape();
			var bodyDef:b2BodyDef = new b2BodyDef();
			var body:b2Body;

			bodyDef.position.Set(1024 / scale / 2, 500 / scale);
			shape.SetAsBox(1024 / scale / 2, 100 / scale);
			body = world.CreateBody(bodyDef);
			body.CreateFixture2(shape);

			// Create a box.
			bodyDef.position.Set(1024 / scale / 2,0.0);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.angle = 3.1415692/5;
			shape.SetAsBox(10,10);
			body = world.CreateBody(bodyDef);
			body.CreateFixture2(shape,1.0);

			// Setup drawing.
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			dbgDraw.SetSprite(this);
			dbgDraw.SetDrawScale(scale);
			dbgDraw.SetFillAlpha(0.3);
			dbgDraw.SetLineThickness(1.0);
			dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			world.SetDebugDraw(dbgDraw);
		}

		/*
		Called to update the screen.
		*/
		public function update(event:Event):void
		{
			// Clear the screen for rendering.
			this.graphics.clear()

			// Update physics
			world.Step(1.0/30.0, 10, 10);
			world.ClearForces();

			// Redraw the world.
			world.DrawDebugData();
		}
	} // public class fingerpuppets extends Sprite
} // package

/*
Game constant values.
*/
class Constants
{
	// Database contants.
	public var database:String = 'fingerpuppets.db';

	// Screen constants; set for the playbook.
	public var width:Number = 1024;
	public var height:Number = 600;
}

