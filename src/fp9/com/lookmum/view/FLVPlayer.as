package com.lookmum.view{
	import com.lookmum.events.ComponentEvent;
	import com.lookmum.events.MediaPlayerEvent;
	import com.lookmum.util.IMediaPlayer;
	import com.lookmum.vo.VideoMetaData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	[Event(name = "update", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "loadProgress", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "end", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "bufferFull", type = "com.lookmum.events.MediaPlayerEvent")]
	
	public class FLVPlayer extends Component implements IMediaPlayer
	{
		public var loop:Boolean;
		protected var videoArea:Video;
		private var _url:String;
		private var _netStream:NetStream;
		private var _nc:NetConnection;
		private var _playing:Boolean = false;
		private var _loadProgressDelegate:Function;
		private var _loadProgressInterval:Number;
		private var _loadProgressTime:Number = 100;
		private var _metaData:VideoMetaData;
		private var _bufferTime:Number = 0;
		private var videoWidth:Number;
		private var videoHeight:Number;
		public function FLVPlayer (target:MovieClip)
		{
			super (target);
			_nc = new NetConnection();
			_nc.connect(null);
			videoArea = new Video(1, 1);
			videoWidth = width;
			videoHeight = height;
			addChild(videoArea);
		}
		/**
		 * Load a video from the specified URL
		 * 
		 * @param url A file location of an flv file
		 */
		public function load(url:String, autoPlay:Boolean = true):void {

			if (url.indexOf('\\') != -1) trace('WARNING: the file path ' + url + ' contains backslashes, this may be incorrect');

			_url = url;
			if(_netStream)_netStream.close();
			_netStream = new NetStream(_nc);
			_netStream.bufferTime = _bufferTime;
			_netStream.addEventListener(NetStatusEvent.NET_STATUS,onStatus);
			_netStream.client = new Object();
			_netStream.client.onCuePoint = onCuePoint;
			_netStream.client.onMetaData = onMetaData;
			_netStream.client.onPlayStatus = onPlayStatus;		
			videoArea.clear();
			videoArea.attachNetStream(_netStream);
			videoArea.width = width;
			videoArea.height = height;
			_netStream.play(url);
			addEventListener(Event.ENTER_FRAME,onLoadProgress);
			if(autoPlay){
				addEventListener(Event.ENTER_FRAME,onUpdate);
				_playing = true;
			}else{
				pause();
			}
			onLoadProgress(new Event(Event.ENTER_FRAME));
		}
		
		/*public function getVideoWidth():int {
			return videoArea.videoWidth;
		}
		public function getVideoHeight():int {
			return videoArea.videoHeight;
		}*/
		/*
		public function unLoad():void
		{
			videoArea.clear();
		}
		*/
		/*
		 * Play the currently loading video
		 */
		override public function play():void {
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.PLAY));
			addEventListener(Event.ENTER_FRAME,onUpdate);
			_playing = true;
			_netStream.resume();			
		}
		
		/*
		 * Pause the current playing video
		 */
		public function pause():void {
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.STOP));
			removeEventListener(Event.ENTER_FRAME,onUpdate);
			_playing = false;
			if(_netStream)_netStream.pause();
		}
		public function get playing():Boolean{
			return _playing;
		}
		public function get time():Number{
			return _netStream.time;
		}
		/**
		* Seek to time
		* @param	time Seconds
		*/
		public function seek(time:Number):void
		{
			
			//trace('trying to seek');
			//if (time > _metaData.lastkeyframetimestamp) time = _metaData.lastkeyframetimestamp;
			if (_netStream)_netStream.seek(time);
		}
		
		private function onUpdate(event:Event):void {
			
			var e:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.UPDATE);
			
			e.bufferLength = _netStream.bufferLength;
			e.bufferTime = _netStream.bufferTime;
			e.bytesLoaded = _netStream.bytesLoaded;
			e.bytesTotal = _netStream.bytesTotal;
			e.currentFPS = _netStream.currentFPS;
			e.liveDelay = _netStream.liveDelay;
			e.time = _netStream.time;
			
			videoArea.width = videoWidth;
			videoArea.height = videoHeight;
			
			dispatchEvent(e);
			//trace( "getDuration() : " + getDuration() );
		}
		
		private function onLoadProgress(event:Event):void {
			//trace( "FLVPlayer.onLoadProgress > event : " );
			var loaded:Number = _netStream.bytesLoaded;
			var total:Number = _netStream.bytesTotal;
			if (loaded == total) removeEventListener(Event.ENTER_FRAME, onLoadProgress);
			
			var e:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.LOAD_PROGRESS);
			
			e.bufferLength = _netStream.bufferLength;
			e.bufferTime = _netStream.bufferTime;
			e.bytesLoaded = _netStream.bytesLoaded;
			e.bytesTotal = _netStream.bytesTotal;
			e.currentFPS = _netStream.currentFPS;
			e.liveDelay = _netStream.liveDelay;
			e.time = _netStream.time;
			
			dispatchEvent(e);
		}
		
		public function get loadLevel():Number{
			return _netStream.bytesLoaded/_netStream.bytesTotal;
		}
		protected function onStatus(event:NetStatusEvent):void
		{
			
			//trace( "FLVPlayer.onStatus > event : " + event.info.code );
			//for( var i:String in event ) trace( "key : " + i + ", value : " + event[ i ] );
			//dispatchEvent(event);
			switch (event.info.code){
				case 'NetStream.Seek.InvalidTime':
				//trace('NetStream.Seek.InvalidTime');
				seek(event.info.details);
				//trace( "event.info.details : " + event.info.details );
				break;
				case 'NetStream.Play.Stop':
				pause();
				dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.END));
				if (loop) {
					seek(0);
					play();
				}
				break;
				case 'NetStream.Buffer.Full':
				
				var e:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.BUFFER_FULL);
			
				e.bufferLength = _netStream.bufferLength;
				e.bufferTime = _netStream.bufferTime;
				e.bytesLoaded = _netStream.bytesLoaded;
				e.bytesTotal = _netStream.bytesTotal;
				e.currentFPS = _netStream.currentFPS;
				e.liveDelay = _netStream.liveDelay;
				e.time = _netStream.time;
					
				dispatchEvent(e);
				break;
			}
		}
		private function onPlayStatus(status:Object):void
		{
			//trace( "FLVPlayer.onPlayStatus > status : " + status );
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.END));
		}
		private function onCuePoint(cuePoint:Object):void
		{
			//trace( "FLVPlayer.onCuePoint > cuePoint : " + cuePoint );
		}
		private function onMetaData(metadata:Object):void
		{
			//trace( "FLVPlayer.onMetaData > metadata : "  );
			//for( var i:String in metadata ) trace( "key : " + i + ", value : " + metadata[ i ] );
			_metaData = new VideoMetaData();
			_metaData.videoWidth = metadata.width;
			_metaData.videoHeight = metadata.height;
			_metaData.duration = metadata.duration;
			_metaData.lastkeyframetimestamp = metadata.lastkeyframetimestamp;
			_metaData.creationDate = new Date(metadata.creationdate);
			_metaData.audioCodecID = metadata.audiocodecid;
			_metaData.audioDataRate = metadata.audiodatarate;
			_metaData.videoCodecID = metadata.videocodecid;
			_metaData.videoDataRate = metadata.videodatarate;
			_metaData.canSeekToEnd = metadata.canSeekToEnd;
			_metaData.frameRate = metadata.framerate;
			
			
			var event:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.META_DATA);
			
			event.bufferLength = _netStream.bufferLength;
			event.bufferTime = _netStream.bufferTime;
			event.bytesLoaded = _netStream.bytesLoaded;
			event.bytesTotal = _netStream.bytesTotal;
			event.currentFPS = _netStream.currentFPS;
			event.liveDelay = _netStream.liveDelay;
			event.time = _netStream.time;
			
			event.metaData = _metaData;
			
			dispatchEvent(event);
		}
		
		public function get loadedBytes():Number{
		return _netStream.bytesLoaded;
	}
	
		public function get totalBytes():Number{
			return _netStream.bytesTotal;
		}
		
		public function set videoDataRate(value:int):void{
			_metaData.videoDataRate = value;
		}
	
		public function get videoDataRate():int{
			return _metaData.videoDataRate;
		}
		public function get bufferLength():Number {
			return _netStream.bufferLength;
		}
		public function set canSeekToEnd(value:Boolean):void{
			_metaData.canSeekToEnd = value;
		}
	
		public function get canSeekToEnd():Boolean{
			return _metaData.canSeekToEnd;
		}
		
		public function set videoCodecID(value:int):void{
			_metaData.videoCodecID = value;
		}
	
		public function get videoCodecID():int{
			return _metaData.videoCodecID
		}
		public function set audioDataRate(number:int):void {
			_metaData.audioDataRate = number;
		}
		public function get audioDataRate():int {
			return _metaData.audioDataRate;
		}
		public function set audioCodecID(number:int):void {
			_metaData.audioCodecID = number;
		}
		public function get audioCodecID():int {
			return _metaData.audioCodecID;
		}
		public function set framerate(number:Number):void {
			_metaData.frameRate = number;
		}
		public function get framerate():Number {
			return _metaData.frameRate;
		}
		public function set creationdate(date:Date):void {
			_metaData.creationDate = date;
		}
		public function get creationdate():Date {
			return _metaData.creationDate;
		}
		public function get metaData():VideoMetaData{
			return _metaData;
		}
		public function get duration():Number
		{
			if (!_metaData) return 0;
			return _metaData.duration;
		}
		public function set duration(value:Number):void
		{
			_metaData.duration = value;
		}	
	
		public function clear():void{
			videoArea.clear();
			if(_netStream)_netStream.close();
		}
		
		public function get bufferTime():Number {
			return _netStream.bufferTime;
		}
		
		public function set bufferTime(value:Number):void 
		{
			if (_netStream)_netStream.bufferTime = value;
			_bufferTime = value;
		}
		
	}
}
