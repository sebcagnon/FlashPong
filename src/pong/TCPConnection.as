package pong 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.*;
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class TCPConnection extends Sprite
	{
		private var sock:Socket;
		private var ID:String;
		public var event:PongEvent;
		private var ball:Ball;
		static internal var WAITING:String = 'WAITING';
		static internal var STARTED:String = 'STARTED';
		static internal var NEW_USER:String = 'NEW_USER';
		
		public function TCPConnection() 
		{
			event = new PongEvent('BALL_UPDATE');
			sock = new Socket('127.0.0.1', 5005);
			sock.addEventListener(ProgressEvent.SOCKET_DATA, socketData);
			sock.writeUTFBytes(NEW_USER);
		}
		
		private function socketData(e:ProgressEvent):void
		{
			var rawData:String = sock.readUTFBytes(sock.bytesAvailable);
			trace('data: ' + rawData);
			var data:Array = rawData.split(':');
			if (data[0] == 'ID')
			{
				ID = data[1];
				trace('Got my ID: ' + ID);
				setInterval(requestUpdate, 50);
			}
			if (data[0] == 'ball')
			{
				var pos:Array = data[1].split(',');
				trace(pos);
				event.param = pos;
				if (ball)
				{
					ball.updateFromServer(event);
				}
			}
		}
		
		internal function setBall(b:Ball):void 
		{
			ball = b;
		}
		
		private function requestUpdate():void 
		{
			sock = new Socket('127.0.0.1', 5005);
			sock.writeUTFBytes('update:' + ID);
			sock.addEventListener(ProgressEvent.SOCKET_DATA, socketData);
		}
		
	}

}