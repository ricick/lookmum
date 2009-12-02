package  
{
	import com.lookmum.view.DragButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleDragButton extends Sprite
	{
		
		public function ExampleDragButton() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(new DragButton(new buttonClip()));
		}
		
	}

}