package pong 
{
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	/**
	 * ...
	 * @author Sebastien Cagnon
	 */
	internal class TCPConnection 
	{
		private var sock:Socket;
		private var type:String;
		static internal var SERVER:String = 'SERVER';
		static internal var CLIENT:String = 'CLIENT';
		
		public function TCPConnection(playerType:String) 
		{
			sock = new Socket('127.0.0.1', 5005);
			sock.addEventListener(ProgressEvent.SOCKET_DATA, socketData);
			if (playerType == SERVER)
			{
				sock.writeUTFBytes('create');
			}
		}
		
		private function socketData(e:ProgressEvent):void
		{
			var rawData:String = sock.readUTFBytes(sock.bytesAvailable);
			trace(rawData);
		}
		
	}

}