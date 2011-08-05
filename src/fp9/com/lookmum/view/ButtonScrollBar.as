package com.lookmum.view 
{
	import com.lookmum.view.Button;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ButtonScrollBar extends Component implements IScrollBar 
	{
		private var scrollBar:ScrollBar;
		private var buttonScrollUp:Button;
		private var buttonScrollDown:Button;
		public function ButtonScrollBar(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			scrollBar = new ScrollBar(target.scrollBar);
			scrollBar.addEventListener(Event.SCROLL, onScroll);
			buttonScrollUp = new Button(target.scrollUp);
			buttonScrollUp.addEventListener(MouseEvent.CLICK, onClickUp);
			buttonScrollDown = new Button(target.scrollDown);
			buttonScrollDown.addEventListener(MouseEvent.CLICK, onClickDown);
		}
		
		private function onScroll(e:Event):void 
		{
			dispatchEvent(e.clone());
		}
		
		private function onClickDown(e:MouseEvent):void 
		{
			scrollBar.level += scrollBar.scrollSize;
		}
		
		private function onClickUp(e:MouseEvent):void 
		{
			scrollBar.level -= scrollBar.scrollSize;
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