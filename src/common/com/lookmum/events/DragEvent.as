package com.lookmum.events {

	import flash.events.Event;
	
	public class DragEvent extends Event{
		
		public function DragEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		public static const START:String = "DragEvent.START";
		public static const STOP:String = "DragEvent.STOP";
		public static const DRAG:String = "DragEvent.drag";
		public static const ROLLOVER_DRAG:String = "DragEvent.ROLLOVER_DRAG";
		public static const ROLLOUT_DRAG:String = "DragEvent.ROLLOUT_DRAG";

		public override function clone():Event 
		{ 
			return new DragEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DragEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
