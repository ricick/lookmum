package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.Button;
	import com.lookmum.view.Popup;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExamplePopup extends Sprite
	{
		private var popup:Popup;
		private var button:Button;
		public function ExamplePopup() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			popup = new Popup(new popupClip());
			button = new Button(new buttonClip());
			addChild(button);
			addChild(popup);
			button.addEventListener(MouseEvent.CLICK, onClick);
			LayoutManager.spaceVertical([button, popup], 5);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			popup.visible = true;
		}
		
	}

}