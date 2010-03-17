
package com.lookmum.events {

	import flash.events.Event;
	

	public class InteractiveComponentEvent extends Event{
		public static var ENABLE:String = "enable";
		public static var DISABLE:String = "disable";
		public static var MOUSE_UP_OUTSIDE:String = "mouseUpOutside";
		public function InteractiveComponentEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			return new InteractiveComponentEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("InteractiveComponentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}
