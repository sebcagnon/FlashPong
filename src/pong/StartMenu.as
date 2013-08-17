package pong 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class StartMenu extends Sprite 
	{
		private var space:int;
		private var pos:Array;
		
		public function StartMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			space = stage.stageHeight / 50;
			pos = [stage.stageWidth / 2, stage.stageHeight / 2];
		}
		
		internal function createButton (buttonText:String):void 
		{
			if (!stage)
			{
				throw(Error("Menu must first be added to stage"));
			}
			var textUp:TextField = new TextField();
			textUp.backgroundColor = 0x000000;
			textUp.textColor = 0xFFFFFF;
			textUp.text = buttonText;
			textUp.scaleX = 3;
			textUp.scaleY = 3;
			textUp.autoSize = TextFieldAutoSize.LEFT;
			var textDown:TextField = new TextField();
			textDown.backgroundColor = 0x000000;
			textDown.textColor = 0xFFFFFF;
			textDown.text = buttonText;
			textDown.scaleX = 3.2;
			textDown.scaleY = 3.2;
			textDown.autoSize = TextFieldAutoSize.LEFT;
			var button:SimpleButton = new SimpleButton(textUp, textDown, textDown, textUp);
			button.name = buttonText;
			button.x = pos[0] - textUp.width / 2;
			button.y = pos[1] - textUp.height / 2;
			addChild(button);
			pos[1] = button.y - space;
		}
		
	}

}