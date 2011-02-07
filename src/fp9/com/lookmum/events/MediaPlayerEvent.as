package com.lookmum.events {

	import com.lookmum.vo.VideoMetaData;
	import flash.events.Event;
	

	public class MediaPlayerEvent extends Event{
		public static var SEEK:String = "seek";
		public static var UPDATE:String = "updateTime";
		public static var LOAD_PROGRESS:String = "loadProgress";
		public static var LOAD_COMPLETE:String = "mediaLoadComplete";
		public static var COMPLETE:String = "mediaComplete";
		public static var PLAY:String = "play";
		public static var STOP:String = "stop";
		public static var END:String = "end";
		
		public static var META_DATA : String = "metaData";
		public static var BUFFER_FULL : String = "bufferFull";
		/*public static var STREAM : String = 'stream';
		public static var BUFFER_EMPTY : String = 'bufferEmpty';
		
		public static var INVALID_TIME : String = 'invalidTime';
		public static var PAUSE : String = 'pause';
		public static var RESIZE : String = 'resize';
		public static var SELECT : String = 'select';
		public static var STREAM_FLUSHED : String = 'streamFlushed';
		public static var STREAM_NOT_FOUND : String = 'streamNotFound';*/
		
		public var bufferLength:Number;
		public var bufferTime:Number;
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		public var currentFPS:Number;
		public var liveDelay:Number;
		public var time:Number;
		public var duration:Number;
		
		public var metaData:VideoMetaData;
		public function MediaPlayerEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			var event:MediaPlayerEvent =  new MediaPlayerEvent(type, bubbles, cancelable);
			event.bufferLength = bufferLength;
			event.bufferTime = bufferTime;
			event.bytesLoaded = bytesLoaded;
			event.bytesTotal = bytesTotal;
			event.currentFPS = currentFPS;
			event.liveDelay = liveDelay;
			event.time = time;
			//event.duration = duration;
			return event;
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MediaPlayerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}

	}
	
}
