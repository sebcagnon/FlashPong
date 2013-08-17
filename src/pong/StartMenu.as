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
		public function StartMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var textUp:TextField = new TextField();
			textUp.backgroundColor = 0x000000;
			textUp.textColor = 0xFFFFFF;
			textUp.text = 'START';
			textUp.scaleX = 3;
			textUp.scaleY = 3;
			textUp.autoSize = TextFieldAutoSize.LEFT;
			var textDown:TextField = new TextField();
			textDown.backgroundColor = 0x000000;
			textDown.textColor = 0xFFFFFF;
			textDown.text = 'START';
			textDown.scaleX = 3.2;
			textDown.scaleY = 3.2;
			textDown.autoSize = TextFieldAutoSize.LEFT;
			var button:SimpleButton = new SimpleButton(textUp, textDown, textDown, textUp);
			button.visible = true;
			x = (stage.stageWidth - textUp.width) / 2;
			y = (stage.stageHeight - textUp.height) / 2;
			addChild(button);
		}
		
	}

}