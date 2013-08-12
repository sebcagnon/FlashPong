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
		private var size:int;
		private var speed:Array;
		private var intervalID:uint;
		
		public function Ball(inSize:int) 
		{
			size = inSize;
			speed = [0, 0];
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFFFFFF, 1);
			shape.graphics.drawCircle(0, 0, 40);
			addChild(shape);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function init (e:Event):void
		{
			x = (stage.stageWidth - size[0]) / 2;
			y = (stage.stageHeight - size[1]) / 2;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			intervalID = setInterval(updatePosition, 50);
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
			if (newX < 0)
			{
				x = 0;
				speed[0] *= -1;
			}
			else if (newX >= stage.stageWidth)
			{
				x = stage.stageWidth - 1;
				speed[0] *= -1;
			}
			else
			{
				x = newX;
			}
			if (newY < 0)
			{
				y = 0;
				speed[1] *= -1;
			}
			else if (newY >= stage.stageHeight)
			{
				y = stage.stageWidth - 1;
				speed[1] *= -1;
			}
			else
			{
				y = newY;
			}
		}
		
	}

}