
package com.lookmum.events {

	import flash.events.Event;
	

	public class TweenableEvent extends Event{
		
		public static const WIDTH_TO:String = "widthTo";
		public static const HEIGHT_TO:String = "heightTo";
		public static const ROTATE_TO:String = "rotateTo";
		public static const FADE_TO:String = "fadeTo";
		public static const MOVE_TO:String = "moveTo";
		public static const SCALE_TO:String = "scaleTo";
		public static const UPDATE:String = "update";
		public static const START:String = "start";
		public function TweenableEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			return new TweenableEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TweenableEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
		
	}
	
}
