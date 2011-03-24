
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
		protected var volumeSlider:VolumeSlider;
		protected var buttonPlayPause:ToggleButton;
		protected var buttonRewind:Button;
		protected var buttonFastForward:Button;
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
			volumeSlider = getVolumeSlider();
			if (volumeSlider)
			{
			}
			buttonRewind = getButtonRewind()
			if (buttonRewind)
			{
				buttonRewind.addEventListener(MouseEvent.CLICK, onRewind);
			}
			buttonFastForward = getButtonFastForward();
			if (buttonFastForward)
			{
				buttonFastForward.addEventListener(MouseEvent.CLICK, onFastForward);
			}
			videoSlider = getSlider();
			if (videoSlider)
			{
			videoSlider.addEventListener(DragEvent.START, onStartDragSlider);
			videoSlider.addEventListener(DragEvent.DRAG, onDragSlider);
				videoSlider.addEventListener(DragEvent.STOP, onStopDragSlider, true);
			}
			buttonPlayPause = getButtonPlayPause();
			if (buttonPlayPause)
			{
			buttonPlayPause.addEventListener(MouseEvent.CLICK, onReleaseButtonPlayPause);
			}
		}
			
		private function onFastForward(e:MouseEvent):void 
		{
			pause();
			if (_autoRewind)
			{
				seek(0);
			}else {
				seek(duration);
			}
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.END));
		}
		
		protected function onRewind(e:MouseEvent):void 
		{
			seek(0);
			play();
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
		
		protected function getSlider():Slider
		{
			if (!target.getChildByName('videoSlider')) return null;
			return new Slider(target.getChildByName('videoSlider') as MovieClip);
		}
		
		protected function getButtonPlayPause():ToggleButton
		{
			if (!target.getChildByName('buttonPlayPause')) return null;
			return new ToggleButton(target.getChildByName('buttonPlayPause') as MovieClip);
		}
		
		protected function getButtonRewind():Button
		{
			if (!target.getChildByName('buttonRewind')) return null;
			return new Button(target.getChildByName('buttonRewind') as MovieClip);
		}
		
		protected function getButtonFastForward():Button
		{
			if (!target.getChildByName('buttonFastForward')) return null;
			return new Button(target.getChildByName('buttonFastForward') as MovieClip);
		}
		protected function getVolumeSlider():VolumeSlider
		{
			if (!target.getChildByName('volumeSlider')) return null;
			return new VolumeSlider(target.getChildByName('volumeSlider') as MovieClip);
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
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.STOP));
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
		
		protected function onStartDragSlider(e:DragEvent):void 
		{
			mediaPlayer.pause();
		}
		protected function onDragSlider(e:DragEvent):void 
		{
			mediaPlayer.seek(mediaPlayer.duration * videoSlider.level);
		}
		protected function onStopDragSlider(e:DragEvent):void 
		{
			e.preventDefault();
			if (!_playing) return;
			mediaPlayer.play();
		}
		
		protected function onReleaseButtonPlayPause(e:MouseEvent):void 
		{
			if (_playing)
			{
				pause();
			}
			else 
			{
				play();
			}
			
			if (isComplete)
			{
				isComplete = false;
				seek(0);
				play();
			}
		}
		
		protected function onUpdate(e:MediaPlayerEvent):void 
		{
			if (videoSlider && videoSlider.getIsDragging()) return;
			var level:Number = mediaPlayer.time / mediaPlayer.duration;
			if (level > 1 || isNaN(level)) return;
			videoSlider.level = (level);
			dispatchEvent(e.clone());
		}
		
		public function load(url:String, autoPlay:Boolean = true):void
		{
			isComplete = false;
			if(videoSlider)videoSlider.level = (0);
			_playing = autoPlay;
			mediaPlayer.load(url, autoPlay);
			buttonPlayPause.toggle = (!autoPlay);
			if(autoPlay)dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.PLAY));
		}
		
		override public function play():void
		{
			_playing = true;
			mediaPlayer.play();
			buttonPlayPause.toggle = (false);
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.PLAY));
		}
		
		public function pause():void
		{
			_playing = false;
			trace( "_playing : " + _playing );
			mediaPlayer.pause();
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.STOP));
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
			if(videoSlider)videoSlider.level = (time/mediaPlayer.duration);
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
			if(videoSlider)videoSlider.level = (0);
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
		
		public function get autoRewind():Boolean {
			return _autoRewind;
		}
		
		public function set autoRewind(value:Boolean):void 
		{
			_autoRewind = value;
		}
		override public function get enabled():Boolean { return videoSlider.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			if (videoSlider) videoSlider.enabled = value;
			if (buttonPlayPause) buttonPlayPause.enabled = value;
			if (buttonRewind) buttonRewind.enabled = value;
			if (buttonFastForward) buttonFastForward.enabled = value;
			if (volumeSlider) volumeSlider.enabled = value;
		}
		
		public function get isComplete():Boolean { return _isComplete; }
		
		public function set isComplete(value:Boolean):void 
		{
			_isComplete = value;
		}
	}
	
}
