﻿
package com.lookmum.events {

	import flash.events.Event;

	public class ComponentEvent extends Event{
		public static const MOVE:String = "move";
		public static const SHOW:String = "show";
		public static const HIDE:String = "hide";
		public function ComponentEvent(type:String, bubbles:Boolean =  false, cancelable:Boolean =  false) {
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event 
		{ 
			return new ComponentEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("Event", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
	
}
