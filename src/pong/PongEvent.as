package pong 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class PongEvent extends Event 
	{
		static internal var BALL_OUT:String = "BALL_OUT";
		internal var param;
		
		public function PongEvent(eventType:String, eventParam = '', bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(eventType, bubbles, cancelable);
			param = eventParam;
		}
	}

}