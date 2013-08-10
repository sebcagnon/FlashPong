package pong
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
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
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownListener);
			addChild(new Bar(barSize, 38, 40, 10));
		}
		
		//private function keydownListener(e:KeyboardEvent):void
		//{
			//dispatchEvent();
		//}
	}
	
}