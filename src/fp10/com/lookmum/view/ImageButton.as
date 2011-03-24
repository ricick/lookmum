package com.lookmum.view 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ImageButton extends Button 
	{
		private var image:ImageLoadComponent;
		public function ImageButton(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			image = new ImageLoadComponent(target.image);
		}
		public function load(imageURI:String):void {
			image.load(imageURI);
		}
		
	}

}