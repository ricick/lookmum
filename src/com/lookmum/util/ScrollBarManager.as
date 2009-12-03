
package com.lookmum.util {
	import com.lookmum.view.IComponent;
	import com.lookmum.view.IScrollBar;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class ScrollBarManager{
		private var _scrollBar:IScrollBar;
		private var _component:IComponent;
		private var _textField:TextField;
		private var _displayObject:DisplayObject;
		private var _wheelSpeed:Number = 5;
		public function ScrollBarManager(scrollBar:IScrollBar) {
			_scrollBar = scrollBar;
		}
		public function associateTextFieldScroll(textField:TextField):void{
			_textField = textField;
			_textField.addEventListener(Event.CHANGE, onTextChange);
			_textField.addEventListener(Event.SCROLL, onScrollInsideTextField);
			_scrollBar.addEventListener(Event.SCROLL, onScrollTextField);
			calculateScroll();
		}
		private function onTextChange(e:Event):void 
		{
			calculateScroll();
		}
		public function calculateScroll():void 
		{
			_scrollBar.maxScroll = _textField.maxScrollV;
			_scrollBar.scrollSize = _textField.bottomScrollV;
		}
		private function onScrollTextField(event:Event):void {
			_textField.removeEventListener(Event.SCROLL, onScrollInsideTextField);
			_textField.scrollV = _scrollBar.level;
			_textField.addEventListener(Event.SCROLL, onScrollInsideTextField);
		}
		private function onScrollInsideTextField(e:Event):void 
		{
			_scrollBar.level = _textField.scrollV;
			//trace( "_textField.scrollV : " + _textField.scrollV );
		}
		public function associateDisplayObjectY(displayObject:DisplayObject):void{
			_displayObject = displayObject;
			_scrollBar.addEventListener(Event.SCROLL, onScrollDisplayObject);
			_displayObject.addEventListener(MouseEvent.MOUSE_WHEEL, onScrollInsideDisplayObject);
		}
		
		private function onScrollInsideDisplayObject(e:MouseEvent):void 
		{
			_displayObject.y += e.delta * wheelSpeed;
			_scrollBar.level = -_displayObject.y;
		}
		private function onScrollDisplayObject(event:Event):void{
			_displayObject.y = -_scrollBar.level;
		}
		/**
		 * Pixels to move display object based on one mouse wheel click.
		 */
		public function get wheelSpeed():Number { return _wheelSpeed; }
		
		public function set wheelSpeed(value:Number):void 
		{
			_wheelSpeed = value;
		}
	}
	
}
