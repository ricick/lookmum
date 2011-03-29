package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.Button;
	import com.lookmum.view.Popup;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.TransitionerDecorator;
	import com.lookmum.view.TransitionerDecorator3d;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleTransitioner3d extends Sprite
	{
		private var popup:Popup;
		private var button:ToggleButton;
		private var decorator:TransitionerDecorator3d;
		public function ExampleTransitioner3d() 
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
			
			decorator = new TransitionerDecorator3d(popup);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (button.toggle)
				decorator.transitionIn();
			else
				decorator.transitionOut();
		}
		
	}

}