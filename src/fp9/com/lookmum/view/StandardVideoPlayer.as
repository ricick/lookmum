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

	public class StandardVideoPlayer extends VideoPlayer
	{
		protected var videoControls:FadingComponent;
		protected var _isVerticalVolume:Boolean = true;
		private var volumeSlider:VerticalVolumeSlider;
		private var videoControlsFlag:Boolean = false;
		private var videoSliderDisabled:Boolean;
		private var volumeSliderBg:MovieClip;
		private var volumeIcon:Button;
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
		
		public function StandardVideoPlayer(target:MovieClip) 
		{
			super(target);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			videoControls = getVideoControls();
			
			volumeSlider = getVCVolumeSlider();
			
			volumeSlider.alpha = 0;
			volumeSlider.visible = false;
			
			volumeIcon = new Button(target.videoControls.volumeIcon);
			volumeIcon.addEventListener(MouseEvent.CLICK, onIconClick);
			volumeYPos = volumeSlider.y;
			volumeSliderBg = target.videoControls.volumeSliderBg;
			volumeSliderBg.alpha = 0;
			volumeSliderBg.visible = false;
			volumeBgYPos = volumeSliderBg.y;
			timeDisplay = target.videoControls.timeDisplay;
			timeDisplay.autoSize = TextFieldAutoSize.LEFT;
			spinner = target.spinner;
			
			player = target.getChildByName('flvPlayer') as MovieClip;
			
			mediaPlayer.addEventListener(MediaPlayerEvent.META_DATA, onMetaDataHandler);
			
			setUpVideoControls();
		}
		
		protected function setUpVideoControls():void
		{
			videoControls.visible = false;
			
			buttonRewind.visible = false;
			setAutoRewind(false);
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
		
		protected function getVCVolumeSlider():VerticalVolumeSlider 
		{
			return new VerticalVolumeSlider(target.videoControls.volumeSlider);
		}
		
		private function getVideoControls():FadingComponent
		{
			return new FadingComponent(target.getChildByName('videoControls') as MovieClip);
		}
		
		override public function get visible():Boolean { return super.visible; }
		
		override public function set visible(value:Boolean):void 
		{
			if (!value) pause();
			super.visible = value;
		}
		
		override protected function getSlider():Slider
		{
			return new Slider(target.videoControls.videoSlider);
		}
		
		override protected function getButtonPlayPause():ToggleButton
		{
			return new ToggleButton(target.videoControls.buttonPlayPause);
		}
		
		override protected function getButtonRewind():Button
		{
			return new Button(target.getChildByName('buttonRewind') as MovieClip);
		}
		
		override protected function onEnd(e:MediaPlayerEvent):void 
		{
			isComplete = true;
			buttonPlayPause.toggle = true;
			_playing = false;
			
			if (_autoRewind)
			{
				seek(0);
			}
			
			onEndCallback();
			dispatchEvent(new MediaPlayerEvent(MediaPlayerEvent.END));
		}
		
		protected function onEndCallback():void
		{
			videoControls.visible = true;
			buttonRewind.visible = true;
		}

		override protected function onUpdate(e:MediaPlayerEvent):void 
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
	}
	
}
