package pong
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	public class Main extends Sprite 
	{
		private var ball:Ball;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var barSize:Array = [stage.stageWidth / 20, stage.stageHeight / 4];
			var board:Board = new Board(10, barSize[0]);
			addChild(board);
			board.draw();
			var barLeft:Bar = new Bar(barSize, board.getPosition("Left"), 87, 83, "Left"); // w and s keys
			var barRight:Bar = new Bar(barSize, board.getPosition("Right"), 38, 40, "Right"); // arrow keys
			ball = new Ball(stage.stageWidth / 40);
			addChild(barLeft);
			addChild(barRight);
			addChild(ball);
			ball.addEventListener(PongEvent.BALL_OUT, ballOutListener);
			ball.setSpeed([randomSpeed(5, 10), randomSpeed(5, 10)]);
		}
		
		internal function ballOutListener(e:PongEvent):void
		{
			removeChild(ball);
			var newSpeed:Array = [randomSpeed(5, 10), randomSpeed(5, 10)]
			if ((e.param as String) == 'right')
			{
				newSpeed[0] *= -1;
				(getChildByName("Board") as Board).addScore(0);
			}
			else
			{
				(getChildByName("Board") as Board).addScore(1);
			}
			addChild(ball);
			ball.setSpeed(newSpeed);
		}
		
		private function randomSpeed(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;
		}
	}
	
}