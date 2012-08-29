package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import com.lookmum.view.Button;
	import com.lookmum.view.Slider;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.VideoPlayer;
	import com.lookmum.view.VolumeSlider;
	import flash.display.MovieClip;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Ben Huang
	 */
	public class AnimatedVideoPlayer extends VideoPlayer
	{
		protected var controlPanel: MovieClip;
		
		public function AnimatedVideoPlayer(target:MovieClip) 
		{
			super(target);
		}
		
		override protected function createChildren():void 
		{
			controlPanel = getControlPanel();
			super.createChildren();	
		}
		
		protected function getControlPanel():MovieClip
		{
			if (!target.getChildByName('controlPanel')) return null;
			return target.getChildByName('controlPanel') as MovieClip;
		}
		
		override protected function getSlider():VideoSlider
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('videoSlider') ) return null;
			return new VideoSlider(controlPanel.getChildByName('videoSlider') as MovieClip);
		}
		
		override protected function getButtonPlayPause():ToggleButton
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('buttonPlayPause') ) return null;
			return new ToggleButton(controlPanel.getChildByName('buttonPlayPause') as MovieClip);
		}
		
		override protected function getButtonMute():ToggleButton 
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('buttonMute') ) return null;
			return new ToggleButton(controlPanel.getChildByName('buttonMute') as MovieClip);	
		}
		override protected function getButtonRewind():Button
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('buttonRewind') ) return null;
			return new Button(controlPanel.getChildByName('buttonRewind') as MovieClip);
		}
		
		override protected function getButtonFastForward():Button
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('buttonFastForward') ) return null;
			return new Button(controlPanel.getChildByName('buttonFastForward') as MovieClip);
		}
		
		override protected function getVolumeSlider():VolumeSlider
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('volumeSlider') ) return null;
			return new VolumeSlider(controlPanel.getChildByName('volumeSlider') as MovieClip);
		}
		
		override protected function getTextFieldTime():TextField 
		{
			if (!target.getChildByName('controlPanel') || !controlPanel.getChildByName('textFieldTime') ) return null;
			return controlPanel.getChildByName('textFieldTime') as TextField;
		}
		
		public function fadeIn(timer: int = 1):void
		{
			Tweener.addTween(controlPanel, { time:timer, alpha: 1 } );			
		}
		
		public function fadeOut(timer: int = 1):void
		{
			Tweener.addTween(controlPanel, {time:timer, alpha: 0});
			
		}
	}

}