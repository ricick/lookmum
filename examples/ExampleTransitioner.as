package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.Button;
	import com.lookmum.view.Popup;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.TransitionerDecorator;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleTransitioner extends Sprite
	{
		private var popup:Popup;
		private var button:ToggleButton;
		private var decorator:TransitionerDecorator;
		public function ExampleTransitioner() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			button = new ToggleButton(new buttonClip());
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, onClick);
			
			popup = new Popup(new popupClip());
			popup.x = (stage.stageWidth - popup.width) * 0.5;
			popup.y = (stage.stageHeight - popup.height) * 0.5;
			popup.setModal(false);
			popup.visible = true;
			addChild(popup);
			
			LayoutManager.spaceVertical([button, popup], 5);
			
			decorator = new TransitionerDecorator(popup);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			popup.visible = true;
			if (button.toggle)
				decorator.transitionIn();
			else
				decorator.transitionOut();
		}
		
	}

}