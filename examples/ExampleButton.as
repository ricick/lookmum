package
{
	import com.lookmum.events.InteractiveComponentEvent;
	import com.lookmum.view.Button;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleButton extends Sprite 
	{
		
		public function ExampleButton():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var b:Button = new Button(new buttonClip);
			b.addEventListener(MouseEvent.CLICK, onClick);
			b.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			b.addEventListener(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, mouseUpOutside);
			b.x = 100;
			b.y = 100;
			addChild(b);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			
		}
		
		private function mouseUpOutside(e:InteractiveComponentEvent):void 
		{
			trace( "ExampleButton.mouseUpOutside > e : " + e );
		}
		
		private function onClick(e:MouseEvent):void 
		{
			
		}
	}
	
}