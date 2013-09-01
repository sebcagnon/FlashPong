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
			name = 'ball';
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		internal function init (e:Event):void
		{
			x = (stage.stageWidth) / 2;
			y = (stage.stageHeight) / 2;
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
			addEventListener('BALL_UPDATE', updateFromServer);
		}
		
		internal function setSpeed(newSpeed:Array):void
		{
			speed = newSpeed;
		}
		
		internal function getSpeed():Array
		{
			return speed;
		}
		
		internal function updateFromServer(e:PongEvent):void 
		{
			var pos:Array = (e.param as Array)
			var newX:Number = Number(pos[0]);
			var newY:Number = Number(pos[1]);
			x = newX * stage.stageWidth;
			y = newY * stage.stageHeight;
		}
		
		private function updatePosition():void
		{
			var newX:int = x + speed[0];
			var newY:int = y + speed[1];
			// left and right --> out!
			if (newX < size)
			{
				dispatchEvent(new PongEvent(PongEvent.BALL_OUT, 'left'));
				return;
			}
			else if (newX >= stage.stageWidth-size)
			{
				dispatchEvent(new PongEvent(PongEvent.BALL_OUT, 'right'));
				return;
			}
			else
			{
				x = newX;
			}
			// up and down --> bounce!
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
		
		private function checkCollision(side:String):void
		{
			var bar:Bar = parent.getChildByName(side) as Bar;
			// normal bounce
			if (y >= bar.y && y < bar.y + bar.size[1]) 
			{
				speed[0] *= -1.15;
				if (bar.x - bar.size[0] < 0)
				{
					x = bar.x + bar.size[0] + size;
				}
				else
				{
					x = bar.x - size;
				}
			}
			else // bounce on horizontal edge
			{
				//speed[1] *= -1;
				if (y < bar.y) // above the bar
				{
					y = bar.y - size;
					if (speed[1] > 0)
					{
						speed[1] *= -1;
					}
					
				}
				else if (y >= bar.y + bar.size[1])
				{
					y = bar.y + bar.size[1] + size;
					if (speed[1] < 0)
					{
						speed[1] *= -1;
					}
				}
			}
			speed[1] += bar.getSpeed() / 2;
			
		}
		
	}

}