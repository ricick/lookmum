package com.lookmum.view 
{

	import com.greensock.TweenMax;
	import com.lookmum.events.DragEvent;
	import com.lookmum.events.MediaPlayerEvent;
	import com.lookmum.util.IMediaPlayer;
	import com.lookmum.util.TimeCodeUtil;
	import com.lookmum.view.FLVPlayer;
	import com.lookmum.view.Slider;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.VolumeSlider;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	[Event(name = 'end', type = 'com.lookmum.events.MediaPlayerEvent')]

	public class VideoPlayer extends Component implements IMediaPlayer
	{
		protected var videoControls:FadingComponent;
		protected var mediaPlayer:IMediaPlayer;
		protected var videoSlider:Slider;
		protected var buttonPlayPause:ToggleButton;
		protected var buttonRewind:Button;
		protected var _playing:Boolean;
		protected var _autoRewind:Boolean = true;
		protected var _isComplete:Boolean;
		protected var _isVerticalVolume:Boolean = true;
		private var volumeSlider:VerticalVolumeSlider;
		private var videoControlsFlag:Boolean = false;
		private var videoSliderDisabled:Boolean;
		private var volumeSliderBg:MovieClip;
		private var volumeIcon:Button;
		//protected var bounds:MovieClip;
		private var _videoWidth:Number;
		private var _videoHeight:Number;
		private var isVolumeShowing:Boolean = false;
		private var isPositionSet:Boolean = false;
		private var volumeYPos:Number;
		private var volumeBgYPos:Number;
		private var timeDisplay:TextField;
		//private var totalTime:TextField;
		private var spinner:MovieClip;
		private var player:MovieClip;
		
		public function VideoPlayer(target:MovieClip) 
		{
			super(target);
		}
		override protected function createChildren():void 
		{
			mediaPlayer = getMediaPlayer();
			mediaPlayer.addEventListener(MediaPlayerEvent.UPDATE, onUpdate);
			mediaPlayer.addEventListener(MediaPlayerEvent.META_DATA, onMetaDataHandler);
			mediaPlayer.addEventListener(MediaPlayerEvent.END, onEnd);
			
			if (target.getChildByName('videoControls'))
			{
				videoControlsFlag = true;
				videoControls = getVideoControls();
			}
			
			//if (target.getChildByName('volumeSlider')) 
			//{
			volumeSlider = getVolumeSlider();
			volumeSlider.alpha = 0;
			volumeSlider.visible = false;
			//}
			
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
			volumeIcon = new Button(target.videoControls.volumeIcon);
			volumeIcon.addEventListener(MouseEvent.CLICK, onIconClick);
			volumeYPos = volumeSlider.y;
			//bounds = target.bounds;
			volumeSliderBg = target.videoControls.volumeSliderBg;
			volumeSliderBg.alpha = 0;
			volumeSliderBg.visible = false;
			volumeBgYPos = volumeSliderBg.y;
			timeDisplay = target.videoControls.timeDisplay;
			timeDisplay.autoSize = TextFieldAutoSize.LEFT;
			spinner = target.spinner;
			player = target.getChildByName('flvPlayer') as MovieClip;
		}
		
		private function onIconClick(e:MouseEvent):void 
		{
			if (isVolumeShowing)
			{
				isVolumeShowing = false;
				TweenMax.to(volumeSliderBg, 0.2, { autoAlpha:0, y:volumeBgYPos + volumeSliderBg.height } );
				TweenMax.to(volumeSlider, 0.2, { autoAlpha:0, y:volumeYPos + volumeSlider.height } );
			}
			else
			{
				isVolumeShowing = true;
				TweenMax.to(volumeSliderBg, 0.2, { autoAlpha:1, y:volumeBgYPos } );
				TweenMax.to(volumeSlider, 0.2, { autoAlpha:1, y:volumeYPos } );
			}
		}
		
		protected function getVolumeSlider():VerticalVolumeSlider 
		{
			if (videoControlsFlag)
			{
				return new VerticalVolumeSlider(target.videoControls.volumeSlider);
			}
			else
			{
				return new VerticalVolumeSlider(target.getChildByName('volumeSlider') as MovieClip);
			}
		}
		
		private function getVideoControls():FadingComponent
		{
			return new FadingComponent(target.getChildByName('videoControls') as MovieClip);
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
		
		protected function getSlider():Slider
		{
			if (videoControlsFlag)
			{
				return new Slider(target.videoControls.videoSlider);
			}
			else
			{
				return new Slider(target.getChildByName('videoSlider') as MovieClip);
			}
		}
		
		protected function getButtonPlayPause():ToggleButton
		{
			if (videoControlsFlag)
			{
				return new ToggleButton(target.videoControls.buttonPlayPause);
			}
			else
			{
				return new ToggleButton(target.getChildByName('buttonPlayPause') as MovieClip);
			}
		}
		
		protected function getButtonRewind():Button
		{
			return new Button(target.getChildByName('buttonRewind') as MovieClip);
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
			
			var milliSeconds:Number = e.time * 1000;
			timeDisplay.text = TimeCodeUtil.toTimeCode(milliSeconds);
			
			dispatchEvent(e.clone());
		}
		
		private function onMetaDataHandler(e:MediaPlayerEvent):void 
		{
			if (!isPositionSet)
			{
				isPositionSet = true;
				onResize(e.metaData.videoWidth, e.metaData.videoHeight);
				addEventListener(MouseEvent.ROLL_OVER, onRollOverPlayer);
				addEventListener(MouseEvent.ROLL_OUT, onRollOutPlayer);
				TweenMax.to(spinner, 0.2, { autoAlpha:0 } );
			}
						
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
		
		private function onRollOutPlayer(e:MouseEvent):void 
		{
			videoControls.visible = false;
			
			if (isVolumeShowing)
			{
				isVolumeShowing = false;
				TweenMax.to(volumeSliderBg, 0.2, { autoAlpha:0, y:volumeBgYPos + volumeSliderBg.height } );
				TweenMax.to(volumeSlider, 0.2, { autoAlpha:0, y:volumeYPos + volumeSlider.height } );
			}
		}
		
		private function onRollOverPlayer(e:MouseEvent):void 
		{
			videoControls.visible = true;
		}
		
		public function onResize(playerWidth:Number, playerHeight:Number):void
		{
			if (stage)
			{
				_videoWidth = playerWidth;
				_videoHeight = playerHeight;
				player.width = playerWidth;
				player.height = playerHeight;
				
				videoControls.y = player.height - videoControls.height;
				videoControls.x = 3;
				var controlsBg:MovieClip = target.videoControls.controlsBg;
				var slider:MovieClip = target.videoControls.videoSlider;
				var playPause:MovieClip = target.videoControls.buttonPlayPause;
				var volumeSlider:MovieClip = target.videoControls.volumeSlider;
				var offset:Number = 60;
				var nudgeOffset:Number = 5;
				
				slider.width = (player.width - playPause.width) - offset;
				controlsBg.width = playerWidth;
				videoControls.x = 0;
				videoControls.y = (player.height - videoControls.height) + volumeSliderBg.height;
				volumeIcon.x = playerWidth - (volumeIcon.width + nudgeOffset);
				volumeSliderBg.x = playerWidth - volumeSliderBg.width;
				volumeSlider.x = volumeSliderBg.x + nudgeOffset;
				volumeSlider.y = volumeYPos + volumeSlider.height;
				
				timeDisplay.x = volumeSliderBg.x - (timeDisplay.width + 2);
				
				buttonRewind.x = playerWidth * 0.5;
				buttonRewind.y = playerHeight * 0.5;
			}
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
		
		public function get isVerticalVolume():Boolean { return _isVerticalVolume; }
		
		public function set isVerticalVolume(value:Boolean):void 
		{
			_isVerticalVolume = value;
		}
	}
	
}
