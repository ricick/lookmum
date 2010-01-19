package com.lookmum.events {

	import flash.events.Event;
	
	public class DragEvent extends Event{
		
		public function DragEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		public static const START:String = "start";
		public static const STOP:String = "stop";
		public static const DRAG:String = "drag";
		public static const ROLLOVER_DRAG:String = "rolloverDrag";
		public static const ROLLOUT_DRAG:String = "rolloutDrag";
		
	}
	
}
