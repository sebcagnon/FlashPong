package pong 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class Bar extends Sprite 
	{
		private var size:Array;
		private var upKey:Number;
		private var downKey:Number;
		private var maxSpeed:Number;
		private var speed:Number;
		
		public function Bar(inSize:Array, up_key:Number, down_key:Number, max_speed:Number) 
		{
			size = inSize;
			upKey = up_key;
			downKey = down_key;
			maxSpeed = max_speed;
			speed = 0;
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFFFFFF, 1);
			shape.graphics.drawRect(0, 0, size[0], size[1]);
			addChild(shape);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardListener);
		}
		
		public function keyboardListener(e:KeyboardEvent):void
		{
			var sign:int = int((e.type == KeyboardEvent.KEY_UP)) - int((e.type == KeyboardEvent.KEY_DOWN));
			trace(sign);
			if (e.keyCode == upKey)
			{
				speed += sign * maxSpeed;
			}
			else if (e.keyCode == downKey)
			{
				speed -= sign * maxSpeed;
			}
		}
		
	}

}