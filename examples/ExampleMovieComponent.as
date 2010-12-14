package
{
	import caurina.transitions.properties.DisplayShortcuts;
	import com.lookmum.view.Button;
	import com.lookmum.view.MovieComponent;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleMovieComponent extends Sprite 
	{
		
		private var mc:MovieComponent;
		
		public function ExampleMovieComponent():void 
		{
			DisplayShortcuts.init();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			mc = new MovieComponent(new movie());
			mc.gotoAndStop(0);
			mc.x = (stage.stageWidth - mc.width) * 0.5;
			mc.y = (stage.stageHeight - mc.height) * 0.5;
			addChild(mc);
				
			var button:Button = new Button(new buttonClip);
			button.addEventListener(MouseEvent.CLICK, onClick);
			addChild(button);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			mc.frameTo(mc.totalFrames, function():void { mc.frameToFrom(mc.totalFrames, 0); } );
		}
	}
	
}