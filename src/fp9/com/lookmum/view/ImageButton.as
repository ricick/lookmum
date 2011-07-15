package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ImageButton extends Button 
	{
		private var image:ImageLoadComponent;
		private var captionText:TextField;
		
		public function ImageButton(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			image = new ImageLoadComponent(target.image);
			captionText = target.captionText;
		}
		
		public function setCaptionText(value:String):void {
			captionText.htmlText = value;
		}
		
		public function load(imageURI:String):void {
			image.load(imageURI);
		}
		
	}

}