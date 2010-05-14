package com.lookmum.events {

	import flash.events.Event;
		
	public class PopupEvent extends Event {

		public static var CLOSE:String = "close";
		public function PopupEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			return new PopupEvent(type,caption , bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PopupEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}