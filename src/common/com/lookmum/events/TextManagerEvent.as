package com.lookmum.events 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TextManagerEvent extends Event 
	{
		public static const LOAD:String = "load";
		public function TextManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TextManagerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TextManagerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}