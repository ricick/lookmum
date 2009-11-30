package com.lookmum
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.util.TabManager;
	import com.lookmum.view.BlurLayer;
	import com.lookmum.view.Button;
	import com.lookmum.view.LabelButton;
	import com.lookmum.view.LabelToggleButton;
	import com.lookmum.view.VolumeSliderMute;
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
			var b1:Button = new Button(new buttonClip());
			var b2:Button = new Button(new buttonClip());
			var b3:Button = new Button(new buttonClip());
			addChild(b1);
			addChild(b2);
			addChild(b3);
			b2.y = 100;
			b3.y = 500;
			TabManager.addItem(b1);
			TabManager.addItem(b3);
			TabManager.addItem(b2);
			LayoutManager.spaceVertical([b1, b2, b3], 10, true);
		}
	}
	
}