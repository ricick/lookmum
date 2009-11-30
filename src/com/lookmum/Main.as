package com.lookmum
{
	import com.lookmum.view.BlurLayer;
	import com.lookmum.view.LabelButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	
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
			var lb:LabelButton = new LabelButton(new labelButtonClip());
			addChild(lb);
			lb.x = 200;
			lb.y = 200;
			var bl:BlurLayer = new BlurLayer(new MovieClip());
			bl.width = 500;
			bl.height = 400;
			bl.alpha = 0.9
			addChild(bl);
			bl.filters = [new BlurFilter(3, 3, 3)];
		}
	}
	
}