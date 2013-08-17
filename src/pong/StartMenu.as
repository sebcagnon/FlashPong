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
		
		public function StartMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			space = stage.stageHeight / 50;
			var pos:Array = [stage.stageWidth / 2, stage.stageHeight / 2];
			pos[1] = createButton('CREATE', pos) - space;
			pos[1] = createButton('CREATE', pos) - space;
			pos[1] = createButton('START', pos) - space;
		}
		
		private function createButton (buttonText:String, position:Array):int 
		{
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
			button.x = position[0] - textUp.width / 2;
			button.y = position[1] - textUp.height / 2;
			addChild(button);
			return button.y;
		}
		
	}

}