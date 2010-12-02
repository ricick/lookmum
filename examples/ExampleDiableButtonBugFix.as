package  
{
	import com.lookmum.events.InteractiveComponentEvent;
	import com.lookmum.view.Button;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class ExampleDiableButtonBugFix extends Sprite
	{
		private var timer:Timer;
		private var timerDelay:Number = 3000;
		private var b:Button = new Button(new buttonClip);
		
		public function ExampleDiableButtonBugFix() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			b = new Button(new buttonClip);
			b.addEventListener(MouseEvent.CLICK, onClick);
			b.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			b.addEventListener(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, mouseUpOutside);
			b.x = 100;
			b.y = 100;
			addChild(b);
			
			timer = new Timer(timerDelay, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			trace( "Timer" );
			if (b.enabled)
			{
				b.enabled = false;
			}
			else
			{
				b.enabled = true;
			}
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