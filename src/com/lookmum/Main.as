package com.lookmum
{
	import com.lookmum.view.BlurLayer;
	import com.lookmum.view.LabelButton;
	import com.lookmum.view.LabelToggleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var lb:LabelToggleButton = new LabelToggleButton(new labelToggleButtonClip());
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			lb.textFormatDisableToggle = tf;
			lb.textFormatPressToggle = tf;
			lb.textFormatRollOutToggle = tf;
			lb.textFormatRollOverToggle = tf;
			addChild(lb);
		}
	}
	
}