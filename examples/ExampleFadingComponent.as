package  
{
	import com.lookmum.view.FadingComponent;
	import com.lookmum.view.ToggleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleFadingComponent extends Sprite
	{
		private var fc:FadingComponent;
		private var tb:ToggleButton;
		public function ExampleFadingComponent() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			fc = new FadingComponent(new block());
			tb = new ToggleButton(new toggleButtonClip());
			tb.addEventListener(MouseEvent.CLICK, onClick);
			tb.toggle = true;
			tb.x = 100;
			tb.y = 200;
			fc.x = 200;
			fc.y = 200;
			addChild(tb);
			addChild(fc);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			fc.visible = tb.toggle;
		}
		
	}

}