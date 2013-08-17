package pong 
{
	import adobe.utils.CustomActions;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class Board extends Sprite 
	{
		private var midBarWidth:int;
		private var gutterSize:int;
		private var score:Array;
		private var scoreDisplay:Array;
		
		public function Board(middleBarWidth:int, newGutterSize:int) 
		{
			midBarWidth = middleBarWidth;
			gutterSize = newGutterSize;
			score = [0, 0];
			name = "Board";
		}
		
		public function draw():void
		{
			var drawer:Shape = new Shape();
			//Background
			drawer.graphics.beginFill(0x000000, 1);
			drawer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
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
			
			// Score Display
			scoreDisplay = [new TextField(), new TextField()];
			for each (var text:TextField in scoreDisplay)
			{
				text.textColor = 0xFFFFFF;
				text.text = '0';
				text.scaleX = text.scaleY = 4;
				text.y = stage.stageHeight / 15;
			}
			scoreDisplay[0].x = stage.stageWidth / 4;
			scoreDisplay[1].x = 3 * stage.stageWidth / 4;
			
			addChild(drawer);
			addChild(scoreDisplay[0]);
			addChild(scoreDisplay[1]);
		}
		
		public function getPosition(side:String):Array
		{
			if (!stage)
			{
				throw(Error("Board needs to be added on stage first"));
			}
			if (side.toLowerCase() == "left")
			{
				return [0, 0];
			}
			else if (side.toLowerCase() == "right")
			{
				return [stage.stageWidth - gutterSize, 0];
			}
			else
			{
				throw(Error("There are only 2 possible positions: 'left' or 'right'"));
			}
		}
		
		internal function addScore(player:int):void
		{
			score[player] += 1;
			(scoreDisplay[player] as TextField).text = score[player];
		}
	}

}