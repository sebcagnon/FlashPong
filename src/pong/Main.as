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
			var barSize:Array = [7, stage.stageHeight / 4];
			var board:Board = new Board(10, barSize[0]);
			addChild(board);
			board.draw();
			var barLeft:Bar = new Bar(barSize, board.getPosition("Left"), 38, 40);
			var barRight:Bar = new Bar(barSize, board.getPosition("right"), 87, 83);
			//var ball:Ball = new Ball(40);
			addChild(barLeft);
			addChild(barRight);
			//addChild(ball);
			//ball.setSpeed([7, -5]);
		}
	}
	
}