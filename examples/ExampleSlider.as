package  
{
	import com.lookmum.view.Slider;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleSlider extends Sprite
	{
		
		public function ExampleSlider() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var s:Slider = new Slider(new sliderClip());
			addChild(s);
			s.x = 200;
			s.y = 200;
			s.addEventListener(Event.CHANGE, onChange);
		}
		
		private function onChange(e:Event):void 
		{
			trace( "ExampleSlider.onChange > " + Slider(e.target).level );
		}
		
	}

}