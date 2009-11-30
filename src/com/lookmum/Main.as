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
	import com.lookmum.view.LabelButton;
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
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
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
			var lb:LabelButton = new LabelButton(new labelButtonClip());
			addChild(lb);
			lb.x = 200;
			lb.y = 200;
			//lb.autoSize = TextFieldAutoSize.CENTER;
			var tf:TextFormat = new TextFormat();
			lb.width = 200;
			lb.border = true;
			//lb.htmlText = 'Button Button Button Button Button Button Button Button Button Button Button Button Button ';
			tf.align = TextFormatAlign.CENTER;
			lb.setTextFormat(tf);
			lb.htmlText = 'Button';
			var tf2:TextFormat = new TextFormat();
			tf2.align = TextFormatAlign.RIGHT;
			lb.textFormatRollOver = tf2;
			
		}
		
		private function onClick(e:MouseEvent):void 
		{
			//trace( "Main.onClick > e : " + e );
			
		}
	}
	
}