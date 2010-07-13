
package com.lookmum.view 
{

	import com.lookmum.events.DragEvent;
	import com.lookmum.events.MediaPlayerEvent;
	import com.lookmum.util.IMediaPlayer;
	import com.lookmum.view.FLVPlayer;
	import com.lookmum.view.Slider;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.VolumeSlider;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	[Event(name = 'end', type = 'com.lookmum.events.MediaPlayerEvent')]

	public class VideoPlayer extends Component implements IMediaPlayer
	{
		
		protected var mediaPlayer:IMediaPlayer;
		protected var videoSlider:Slider;
		private var volumeSlider:VolumeSlider;
		protected var buttonPlayPause:ToggleButton;
		protected var buttonRewind:Button;
		protected var _playing:Boolean;
		protected var _autoRewind:Boolean = true;
		private var videoSliderDisabled:Boolean;
		protected var _isComplete:Boolean;
		public function VideoPlayer(target:MovieClip) 
		{
			super(target);
		}
		override protected function createChildren():void 
		{
			mediaPlayer = getMediaPlayer();
			mediaPlayer.addEventListener(MediaPlayerEvent.UPDATE, onUpdate);
			mediaPlayer.addEventListener(MediaPlayerEvent.END, onEnd);
			
			if (target.getChildByName('volumeSlider')) volumeSlider = new VolumeSlider(target.getChildByName('volumeSlider') as MovieClip);
			if (target.getChildByName('buttonRewind')) 
			{
				buttonRewind = getButtonRewind();
				buttonRewind.addEventListener(MouseEvent.CLICK, onRewind);
			}
			videoSlider = getSlider();
			videoSlider.addEventListener(DragEvent.START, onStartDragSlider);
			videoSlider.addEventListener(DragEvent.DRAG, onDragSlider);
			videoSlider.addEventListener(DragEvent.STOP, onStopDragSlider);
			buttonPlayPause = getButtonPlayPause();
			buttonPlayPause.addEventListener(MouseEvent.CLICK, onReleaseButtonPlayPause);
			
		}
		protected function onRewind(e:MouseEvent):void 
		{
			seek(0);
		}
		override public function get visible():Boolean { return super.visible; }
		
		override public function set visible(value:Boolean):void 
		{
			if (!value) pause();
			super.visible = value;
		}
		
		protected function getMediaPlayer():IMediaPlayer
		{
			return new FLVPlayer(target.getChildByName('flvPlayer') as MovieClip);
		}
		protected function getButtonRewind():Button
		{
			return new Button(target.getChildByName('buttonRewind') as MovieClip);
		}
		protected function getSlider():Slider
		{
			return new Slider(target.getChildByName('videoSlider') as MovieClip);
		}
		
		protected function getButtonPlayPause():ToggleButton
		{
			return new ToggleButton(target.getChildByName('buttonPlayPause') as MovieClip);
		}
		protected function onEnd(e:MediaPlayerEvent):void 
		{
			isComplete = true;
			buttonPlayPause.toggle = true;
			_playing = false;
			if (_autoRewind)
			{
				seek(0);
			}
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.END));
		}
		/**
		 * Disable the slider and flag it as not included in enabling/disabling children
		 */
		public function disableSlider():void
		{
			if (videoSlider)
			{
				videoSlider.enabled = false;
				videoSliderDisabled = true;
			}
		}
		/**
		 * If the player is playing, then dragging will not stop the video. If it's already
		 * paused, then it will not re-engage playback
		 * Andrew Catchaturyan
		 */
		protected function onStartDragSlider(e:DragEvent):void 
		{
			/*
			if (_playing)
			{
				mediaPlayer.play();
			}
			else
			{
				mediaPlayer.pause();
			}
			*/
			mediaPlayer.pause();
		}
		protected function onDragSlider(e:DragEvent):void 
		{
			mediaPlayer.seek(mediaPlayer.duration * videoSlider.level);
		}
		protected function onStopDragSlider(e:DragEvent):void 
		{
			if (!_playing) return;
			mediaPlayer.play();
		}
		
		protected function onReleaseButtonPlayPause(e:MouseEvent):void 
		{
			if (_playing)
			{
				_playing = false;
				mediaPlayer.pause();
			}
			else 
			{
				_playing = true;
				mediaPlayer.play();
			}
			
			if (isComplete)
			{
				isComplete = false;
				seek(0);
				mediaPlayer.play();
				_playing = true;
			}
		}
		
		protected function onUpdate(e:MediaPlayerEvent):void 
		{
			if (videoSlider.getIsDragging()) return;
			var level:Number = mediaPlayer.time / mediaPlayer.duration;
			if (level > 1 || isNaN(level)) return;
			videoSlider.level = (level);
			dispatchEvent(e.clone());
		}
		public function load(url:String, autoPlay:Boolean = true):void
		{
			videoSlider.level = (0);
			_playing = autoPlay;
			mediaPlayer.load(url, autoPlay);
			buttonPlayPause.toggle = (!autoPlay);
		}
		
		override public function play():void
		{
			_playing = true;
			mediaPlayer.play();
			buttonPlayPause.toggle = (false);
		}
		
		public function pause():void
		{
			_playing = false;
			mediaPlayer.pause();
		}
		
		public function get playing():Boolean
		{
			return mediaPlayer.playing;
		}
		
		public function get time():Number
		{
			return mediaPlayer.time;
		}
		
		public function seek(time:Number):void
		{
			mediaPlayer.seek(time);
			videoSlider.level = (time/mediaPlayer.duration);
		}
		
		public function get loadLevel():Number{
			return mediaPlayer.loadLevel;
		}
		public function get duration():Number
		{
			return mediaPlayer.duration;
		}
		public function clear():void
		{
			videoSlider.level = (0);
			mediaPlayer.clear();
			buttonPlayPause.toggle = (true);
		}
		public function get bufferTime():Number {
			return mediaPlayer.bufferTime;
		}
		
		public function set bufferTime(value:Number):void 
		{
			mediaPlayer.bufferTime = (value);
		}
		
		public function getAutoRewind():Boolean {
			return _autoRewind;
		}
		
		public function setAutoRewind(value:Boolean):void 
		{
			_autoRewind = value;
		}
		override public function get enabled():Boolean { return videoSlider.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			videoSlider.enabled = value;
			buttonPlayPause.enabled = value;
			if (buttonRewind) buttonRewind.enabled = value;
		}
		
		public function get isComplete():Boolean { return _isComplete; }
		
		public function set isComplete(value:Boolean):void 
		{
			_isComplete = value;
		}
	}
	
}
