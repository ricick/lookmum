package com.lookmum.view 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ButtonScrollBar extends Component implements IScrollBar 
	{
		private var scrollBar:ScrollBar;
		public function ButtonScrollBar(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			scrollBar = new ScrollBar(target.scrollBar);
		}
		
		public function set maxScroll(num:Number):void 
		{
			scrollBar.maxScroll = num;
		}
		
		public function get maxScroll():Number 
		{
			return scrollBar.maxScroll;
		}
		
		public function set scrollSize(num:Number):void 
		{
			scrollBar.scrollSize = num;
		}
		
		public function get scrollSize():Number 
		{
			return scrollBar.scrollSize;
		}
		
		public function get wheelSpeed():int 
		{
			return scrollBar.wheelSpeed;
		}
		
		public function set wheelSpeed(value:int):void 
		{
			scrollBar.wheelSpeed = value;
		}
		
		public function resetScroll():void 
		{
			scrollBar.resetScroll();
		}
		
		public function set level(value:Number):void 
		{
			scrollBar.level = value;
		}
		
		public function get level():Number 
		{
			return scrollBar.level;
		}
		
	}

}