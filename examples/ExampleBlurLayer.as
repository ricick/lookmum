package  
{
	import com.lookmum.events.PopupEvent;
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.BlurLayer;
	import com.lookmum.view.Button;
	import com.lookmum.view.Popup;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleBlurLayer extends Sprite
	{
		private var popup:Popup;
		private var button:Button;
		private var blurLayer:BlurLayer
		private var bitmap:Bitmap;
		public function ExampleBlurLayer() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			/*
			bitmap = new Bitmap(new testImage(1, 1));
			bitmap.width = 600;
			bitmap.scaleY = bitmap.scaleX;
			bitmap.x = -50;
			bitmap.y = -50;
			*/
			popup = new Popup(new popupClip());
			popup.addEventListener(PopupEvent.CLOSE, onClose);
			blurLayer = new BlurLayer(new MovieClip());
			blurLayer.visible = false;
			button = new Button(new buttonClip());
			//addChild(bitmap);
			addChild(new testImageClip);
			addChild(button);
			addChild(blurLayer);
			addChild(popup);
			button.addEventListener(MouseEvent.CLICK, onClick);
			LayoutManager.spaceVertical([button, popup], 5);
		}
		
		private function onClose(e:PopupEvent):void 
		{
			popup.visible = false;
			blurLayer.visible = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			blurLayer.refresh();
			popup.visible = true;
			blurLayer.visible = true;
		}
		
	}

}