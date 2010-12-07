package  
{
	import com.lookmum.view.VerticalSlider;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class ExampleVerticalSlider extends Sprite
	{
		
		public function ExampleVerticalSlider() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var s:VerticalSlider = new VerticalSlider(new verticalSliderClip());
			addChild(s);
			s.x = 200;
			s.y = 200;
			s.addEventListener(Event.CHANGE, onChange);
		}
		
		private function onChange(e:Event):void 
		{
			trace( "ExampleSlider.onChange > " + VerticalSlider(e.target).level );
		}
	}

}