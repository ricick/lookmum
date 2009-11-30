package com.lookmum
{
	import com.lookmum.events.ComponentEvent;
	import com.lookmum.util.ModalManager;
	import com.lookmum.util.RadioGroupManager;
	import com.lookmum.util.ScrollBarManager;
	import com.lookmum.util.SoundPlayer;
	import com.lookmum.view.Button;
	import com.lookmum.view.Component;
	import com.lookmum.view.DragButton;
	import com.lookmum.view.FadingComponent;
	import com.lookmum.view.Popup;
	import com.lookmum.view.ScrollBar;
	import com.lookmum.view.Slider;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.TweenableComponent;
	import com.lookmum.view.VideoPlayer;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var videoPlayer:VideoPlayer = addChild(new VideoPlayer(new videoPlayerClip())) as VideoPlayer;
			videoPlayer.load('video/Collaboration.mp4');
			videoPlayer.x = 200;
			videoPlayer.y = 200;
		}
	}
	
}