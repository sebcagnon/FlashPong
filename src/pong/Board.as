package pong 
{
	import adobe.utils.CustomActions;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class Board extends Sprite 
	{
		private var midBarWidth:int;
		private var gutterSize:int;
		
		public function Board(middleBarWidth:int, newGutterSize:int) 
		{
			midBarWidth = middleBarWidth;
			gutterSize = newGutterSize;
		}
		
		public function draw():void
		{
			var drawer:Shape = new Shape();
			// Middle bar
			drawer.graphics.lineStyle(1);
			drawer.graphics.beginFill(0xFFFFFF, 1);
			drawer.graphics.drawRect((stage.stageWidth - midBarWidth) / 2, 0, midBarWidth, stage.stageHeight);
			
			// Left gutter
			drawer.graphics.beginFill(0xFFFFFF, 0.8);
			drawer.graphics.drawRect(gutterSize, 0, 2, stage.stageHeight);
			
			// Right gutter
			drawer.graphics.beginFill(0xFFFFFF, 0.8);
			drawer.graphics.drawRect(stage.stageWidth - gutterSize-3, 0, 2, stage.stageHeight);
			
			addChild(drawer);
		}
	}

}