// Marcus

package com.lookmum.util {

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import flash.events.EventDispatcher;
	
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.net.URLRequest;

	import com.lookmum.events.MediaPlayerEvent;
	import com.lookmum.util.IMediaPlayer;

	[Event(name = "update", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "loadProgress", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "stop", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "complete", type = "com.lookmum.events.MediaPlayerEvent")]
	[Event(name = "loadComplete", type = "com.lookmum.events.MediaPlayerEvent")]
	
	public class SoundPlayer extends EventDispatcher implements IMediaPlayer {

		public var autoplay:Boolean;
		
		private var className:String = 'SoundPlayer';
		
		protected var soundChannelObject:SoundChannel;
		protected var soundTransformObject:SoundTransform;
		
		protected var _url:String;
		protected var _sound:Sound;
		protected var _time:Number = 0.1;
		protected var _id3:ID3Info;
		protected var _playing:Boolean = false;

		protected var _updateInterval:Number;
		protected var _updateTime:Number = 100;

		protected var _loadProgressInterval:Number;
		protected var _loadProgressTime:Number = 100;
		protected static const MAX_LOOPS:int = 999999;
		public var stream:Boolean = true;
		protected var _loop:Boolean
		protected var soundsLookup:Dictionary;
		private var _cacheSounds:Boolean;
		
		public function SoundPlayer() 
		{
						
			soundChannelObject = new SoundChannel();
			soundsLookup = new Dictionary();
		
		}
		
		public function load(url:String, autoPlay:Boolean = true):void 
		{
			if (url.indexOf('\\') != -1) trace('WARNING: the file path ' + url + ' contains backslashes, this may be incorrect');
			_url = url;

			// pause previous sound
			pause();
			if (cacheSounds && soundsLookup[url] != null) {
				_sound = soundsLookup[url] as Sound;
				if (autoPlay) {
					play();
				}
				return
			}
			this._sound = new Sound();
			if (cacheSounds) soundsLookup[url] = _sound;
            _sound.addEventListener(Event.ID3, id3Handler);
            _sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _sound.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			
			soundTransformObject = new SoundTransform();
						
			// set up URL Request for loading	
			var soundRequest:URLRequest = new URLRequest(url);		
			this._sound.load(soundRequest);
			
			this._time = 0;
			
			this._loadProgressInterval = setInterval(onLoadProgress, this._loadProgressTime);

			if (autoPlay) {
				this._updateInterval = setInterval(onUpdate, this._updateTime);
				_playing = true;
				var loops:int = 0;
				if (_loop) loops = MAX_LOOPS;
				soundChannelObject = this._sound.play(this._time / 1000, loops);
				soundChannelObject.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
								
			} else {
				
				pause();
				
			}
			
			this.onLoadProgress();
			
		}
		
		private function progressHandler(e:ProgressEvent):void {
			//trace( "SoundPlayer.progressHandler > e : " + e );
			
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void {
			trace( "SoundPlayer.ioErrorHandler > e : " + e );
			
		}
		
		private function id3Handler(e:Event):void {
			//trace( "SoundPlayer.id3Handler > e : " + e );
			try {
				id3 = e.target.id3; 
			} catch (e:Error) {
				
			}
			//for (var propName:String in id3)
			//{
				//trace(propName, id3[propName]);
			//}
		}
		
		private function completeHandler(e:Event):void {
			//trace( "SoundPlayer.completeHandler > e : " + e );
			
		}

		public function play():void {
			if (_playing == true) return ;
			
			this._updateInterval = setInterval(this.onUpdate,this._updateTime);
			_playing = true;
			
			var loops:int = 0;
			if (_loop) loops = MAX_LOOPS;
			soundChannelObject = this._sound.play(this._time, loops);
			soundChannelObject.soundTransform = soundTransformObject;
			soundChannelObject.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
		}
		
		public function set volume(value:Number):void {
			
			soundTransformObject.volume = value * 0.01;
			
			if (soundChannelObject) {
				soundChannelObject.soundTransform = soundTransformObject;
			}

		}

		public function get volume():Number 
		{
			return (soundTransformObject.volume / 0.01);
		}
				
		public function get duration():Number
		{
			return id3 ? id3['TLEN'] : _sound.length;
		}

		public function pause():void {
			
			clearInterval(this._updateInterval);
			_playing = false;

			if (soundChannelObject) {
				this._time = soundChannelObject.position;
				soundChannelObject.stop();
			}
		}
		
		public function get playing():Boolean {
			
			return _playing;
			
		}
		
		public function get time():Number {
			if (soundChannelObject)
				return soundChannelObject.position;
			return 0;
		}

		public function seek(time:Number):void {
			
			this._time = time;

			if (this._playing) 
			{
				soundChannelObject.stop();
				soundChannelObject = this._sound.play(this._time, 0);
				soundChannelObject.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
		}
		
		protected function onUpdate():void 
		{
			var event:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.UPDATE)
			event.time = time;
			this.dispatchEvent(event);
		}
		
		private function onLoadProgress():void {
			
			var loaded:Number = this._sound.bytesLoaded;
			var total:Number = this._sound.bytesTotal;
			
			if (loaded > 0 && loaded == total) clearInterval(this._loadProgressInterval);
			
			var e:MediaPlayerEvent = new MediaPlayerEvent(MediaPlayerEvent.LOAD_PROGRESS);
			e.bytesLoaded = loaded;
			this.dispatchEvent(e);
			
		}
		
		public function get loadLevel():Number {
			
			return this._sound.bytesLoaded / this._sound.bytesTotal;
			
		}
		
		protected function onSoundComplete(e:Event):void {
			if (soundChannelObject)
				soundChannelObject.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			clearInterval(this._updateInterval);
			_playing = false;
			
			this.dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.STOP));
			this.dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.COMPLETE));
			
		}
		
		private function onLoadSound(success:Boolean):void{
			if (!success) trace( "ERROR : Cannot load sound " + _url);
			this.dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.LOAD_COMPLETE));
		}
		
		public function clear():void
		{
			
		}
		
		
		public function get bufferTime():Number
		{
			return 0;
		}
		
		public function set bufferTime(value:Number):void
		{
			
		}
		
		public function getLoop():Boolean { return _loop; }
		
		public function setLoop(value:Boolean):void 
		{
			_loop = value;
		}
		
		public function get cacheSounds():Boolean { return _cacheSounds; }
		
		public function set cacheSounds(value:Boolean):void 
		{
			_cacheSounds = value;
			if (value) {
				soundsLookup = new Dictionary(true);
			}else {
				soundsLookup = null;
			}
		}
		
		public function get id3():ID3Info 
		{
			return _id3;
		}
		
		public function set id3(value:ID3Info):void 
		{
			_id3 = value;
		}
		
		
	}
	
}
