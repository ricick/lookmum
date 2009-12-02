package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.util.RadioGroupManager;
	import com.lookmum.view.ToggleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleRadioButtons extends Sprite
	{
		
		public function ExampleRadioButtons() 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var tb1:ToggleButton = new ToggleButton(new toggleButtonClip());
			var tb2:ToggleButton = new ToggleButton(new toggleButtonClip());
			var tb3:ToggleButton = new ToggleButton(new toggleButtonClip());
			addChild(tb1);
			addChild(tb2);
			addChild(tb3);
			LayoutManager.spaceVertical([tb1, tb2, tb3], 5);
			var radioGroup:RadioGroupManager = new RadioGroupManager();
			radioGroup.addButton(tb1);
			radioGroup.addButton(tb2);
			radioGroup.addButton(tb3);
			radioGroup.addEventListener(Event.SELECT, onSelect);
		}
		
		private function onSelect(e:Event):void 
		{
			trace( "ExampleRadioButtons.onSelect > e : " + RadioGroupManager(e.target).selectedIndex );
			
		}
		
	}

}