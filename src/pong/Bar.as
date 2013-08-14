package pong 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class Bar extends Sprite 
	{
		private static var MAXSPEED:Number = 8;
		internal var size:Array;
		private var upKey:Number;
		private var downKey:Number;
		private var maxSpeed:Number;
		private var up:Number;
		private var down:Number;
		private var intervalID:uint;
		private var direction:int;
		
		public function Bar(inSize:Array, startPos:Array, up_key:Number, down_key:Number, sideName:String, max_speed:Number = 0) 
		{
			size = inSize;
			upKey = up_key;
			downKey = down_key;
			maxSpeed = max_speed || Bar.MAXSPEED;
			up = 0;
			down = 0;
			name = sideName;
			
			x = startPos[0];
			y = startPos[1];
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFFFFFF, 1);
			shape.graphics.drawRect(0, 0, size[0], size[1]);
			addChild(shape);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function init(e:Event):void
		{
			y = (stage.stageHeight - size[1]) / 2;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardListener);
			intervalID = setInterval(updatePosition, 40);
			addEventListener(Event.REMOVED_FROM_STAGE, deactivate);
		}
		
		internal function deactivate(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, deactivate);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardListener);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardListener);
			clearInterval(intervalID);
			intervalID = 0;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function getSpeed():int 
		{
			return direction*maxSpeed;
		}
		
		private function keyboardListener(e:KeyboardEvent):void
		{
			var sign:int = int((e.type == KeyboardEvent.KEY_UP)) - int((e.type == KeyboardEvent.KEY_DOWN));
			if (e.keyCode == upKey)
			{
				up = 1 - sign;
			}
			else if (e.keyCode == downKey)
			{
				down = 1 - sign;
			}
		}
		
		private function updatePosition():void
		{
			direction = down - up;
			var newY:int = y + direction * maxSpeed;
			if (newY < 0)
			{
				y = 0;
			}
			else if (newY + size[1] >= stage.stageHeight)
			{
				y = stage.stageHeight - size[1];
			}
			else
			{
				y = newY;
			}
		}
	}

}