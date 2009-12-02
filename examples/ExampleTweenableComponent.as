package
{
	import com.eclecticdesignstudio.motion.easing.Sine;
	import com.lookmum.view.Button;
	import com.lookmum.view.TweenableComponent;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleTweenableComponent extends Sprite 
	{
		
		public function ExampleTweenableComponent():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var tc:TweenableComponent = new TweenableComponent(new Button(new buttonClip));
			tc.addEventListener(MouseEvent.CLICK, onClick);
			tc.easing = Sine.easeInOut;
			addChild(tc);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			TweenableComponent(e.target).moveTo(Math.random() * 300, Math.random() * 300);
		}
	}
	
}