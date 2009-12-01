package com.lookmum
{
	import com.eclecticdesignstudio.motion.easing.Back;
	import com.eclecticdesignstudio.motion.easing.Elastic;
	import com.eclecticdesignstudio.motion.easing.Expo;
	import com.eclecticdesignstudio.motion.easing.Quint;
	import com.eclecticdesignstudio.motion.easing.Sine;
	import com.lookmum.events.TweenableComponentEvent;
	import com.lookmum.util.LayoutManager;
	import com.lookmum.util.TabManager;
	import com.lookmum.view.BlurLayer;
	import com.lookmum.view.Button;
	import com.lookmum.view.Cursor;
	import com.lookmum.view.LabelButton;
	import com.lookmum.view.LabelToggleButton;
	import com.lookmum.view.TweenableComponent;
	import com.lookmum.view.VolumeSliderMute;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mx.effects.easing.Bounce;
	
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var tc:TweenableComponent = new TweenableComponent(new Button(new buttonClip));
			//var tc:Button = new Button(new buttonClip);
			tc.addEventListener(MouseEvent.CLICK, onClick);
			tc.addEventListener(TweenableComponentEvent.UPDATE, onUpdate);
			tc.addEventListener(TweenableComponentEvent.START, onStart);
			tc.addEventListener(Event.COMPLETE, onComplete);
			tc.easingPosition = Quint.easeInOut
			addChild(tc);
		}
		
		private function onStart(e:TweenableComponentEvent):void 
		{
			//trace( "Main.onStart > e : " + e );
			
		}
		
		private function onComplete(e:Event):void 
		{
			//trace( "Main.onComplete > e : " + e );
			
		}
		
		private function onUpdate(e:TweenableComponentEvent):void 
		{
			//trace( "Main.onUpdate > e : " + e );
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			//trace( "Main.onClick > e : " + e );
			TweenableComponent(e.target).moveTo(Math.random()*300, Math.random()*300);
		}
	}
	
}