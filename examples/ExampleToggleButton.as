package  
{
	import com.lookmum.view.ToggleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleToggleButton extends Sprite
	{
		private var tb:ToggleButton;
		public function ExampleToggleButton() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			tb = new ToggleButton(new toggleButtonClip());
			tb.addEventListener(MouseEvent.CLICK, onClick);
			addChild(tb);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace( "ExampleToggleButton.onClick > " + tb.toggle );
		}
		
	}

}