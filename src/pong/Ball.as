package pong 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.*;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class Ball extends Sprite 
	{
		static private var SIDES:Array = ["Left", "Right"];
		private var size:int;
		private var speed:Array;
		private var intervalID:uint;
		
		public function Ball(inSize:int) 
		{
			size = inSize;
			speed = [0, 0];
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 1);
			shape.graphics.drawCircle(0, 0, size);
			addChild(shape);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function init (e:Event):void
		{
			x = (stage.stageWidth - size) / 2;
			y = (stage.stageHeight - size) / 2;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			intervalID = setInterval(updatePosition, 40);
			addEventListener(Event.REMOVED_FROM_STAGE, deactivate);
		}
		
		internal function deactivate(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, deactivate);
			clearInterval(intervalID);
			intervalID = 0;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function setSpeed(newSpeed:Array):void
		{
			speed = newSpeed;
		}
		
		internal function getSpeed():Array
		{
			return speed;
		}
		
		private function updatePosition():void
		{
			var newX:int = x + speed[0];
			var newY:int = y + speed[1];
			if (newX < size)
			{
				x = size;
				speed[0] *= -1;
			}
			else if (newX >= stage.stageWidth-size)
			{
				x = stage.stageWidth - size - 1;
				speed[0] *= -1;
			}
			else
			{
				x = newX;
			}
			if (newY < size)
			{
				y = size;
				speed[1] *= -1;
			}
			else if (newY >= stage.stageHeight-size)
			{
				y = stage.stageHeight - size - 1;
				speed[1] *= -1;
			}
			else
			{
				y = newY;
			}
			for each (var side:String in SIDES)
			{
				if (hitTestObject(parent.getChildByName(side)))
				{
					checkCollision(side);
				}
			}
		}
		
		private function checkCollision(side:String)
		{
			var bar:Bar = parent.getChildByName(side) as Bar;
			var center:Array = [x + size / 2, y + size / 2];
			if (center[1] >= bar.y && center[1] < bar.y + bar.size[1]) // normal bounce
			{
				speed[0] *= -1;
				if (bar.x - bar.size[0] < 0)
				{
					x = bar.x + bar.size[0] + size;
				}
				else
				{
					x = bar.x - size;
				}
			}
		}
		
	}

}