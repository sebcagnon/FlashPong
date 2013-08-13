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
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var barSize:Array = [stage.stageWidth / 80, stage.stageHeight / 4];
			var board:Board = new Board(10, barSize[0]);
			addChild(board);
			board.draw();
			var barLeft:Bar = new Bar(barSize, board.getPosition("Left"), 38, 40, "Left");
			var barRight:Bar = new Bar(barSize, board.getPosition("Right"), 87, 83, "Right");
			var ball:Ball = new Ball(stage.stageWidth / 40);
			addChild(barLeft);
			addChild(barRight);
			addChild(ball);
			ball.setSpeed([12, -10]);
		}
	}
	
}