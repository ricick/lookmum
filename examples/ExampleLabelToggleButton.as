package  
{
	import com.lookmum.view.LabelToggleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleLabelToggleButton extends Sprite
	{
		
		public function ExampleLabelToggleButton() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var b:LabelToggleButton = new LabelToggleButton(new labelToggleButtonClip());
			b.text = 'Click me';
			addChild(b);
		}
		
	}

}