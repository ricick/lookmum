
package com.lookmum.util {
	
	import com.lookmum.view.IComponent;
	import com.lookmum.view.IScrollBar;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class ScrollBarManager {
		
		private static const DEFAULT_DISPLAY_OBJECT_WHEEL_SPEED:int = 10;
		private var _scrollBar:IScrollBar;
		private var _component:IComponent;
		private var _textField:TextField;
		protected var _displayObject:DisplayObject;
		private var _mask:DisplayObject;
		private var _wheelSpeed:Number = DEFAULT_DISPLAY_OBJECT_WHEEL_SPEED;
		private var contentDefaultY:int = 0;
		
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
			if(_textField){
				_scrollBar.maxScroll = _textField.maxScrollV;
				_scrollBar.scrollSize = _textField.bottomScrollV;
			}else if (_displayObject) {
				if (_mask)_scrollBar.maxScroll = _displayObject.height - _mask.height;
				_scrollBar.scrollSize = _mask.height;
			}
		}
		private function onScrollTextField(event:Event):void {
			_textField.removeEventListener(Event.SCROLL, onScrollInsideTextField);
			_textField.scrollV = _scrollBar.level;
			_textField.addEventListener(Event.SCROLL, onScrollInsideTextField);
		}
		private function onScrollInsideTextField(e:Event):void 
		{
			if (_textField.scrollV == 1)
				_scrollBar.level = 0;
			else
				_scrollBar.level = _textField.scrollV;
		}
		public function associateDisplayObjectY(displayObject:DisplayObject, mask:DisplayObject = null):void {
			contentDefaultY = displayObject.y;
			_displayObject = displayObject;
			_mask = mask;
			_scrollBar.addEventListener(Event.SCROLL, onScrollDisplayObject);
			_displayObject.addEventListener(MouseEvent.MOUSE_WHEEL, onScrollInsideDisplayObject);
			_displayObject.addEventListener(Event.RESIZE,onResize);
			if (_mask)_mask.addEventListener(Event.RESIZE, onResize);
			_scrollBar.wheelSpeed = _wheelSpeed;
			calculateScroll();
		}
		
		private function onResize(e:Event):void 
		{
			calculateScroll();
		}
		
		private function onScrollInsideDisplayObject(e:MouseEvent):void 
		{
			_displayObject.y += e.delta * wheelSpeed;
			_scrollBar.level = -(_displayObject.y - contentDefaultY);	
		}
		protected function onScrollDisplayObject(event:Event):void{
			_displayObject.y = -_scrollBar.level;
			//_displayObject.y += contentDefaultY;
		}
		/**
		 * Pixels to move display object based on one mouse wheel click.
		 */
		public function get wheelSpeed():Number { return _wheelSpeed; }
		
		public function set wheelSpeed(value:Number):void 
		{
			_wheelSpeed = value;
			_scrollBar.wheelSpeed = value;
		}
	}
	
}
