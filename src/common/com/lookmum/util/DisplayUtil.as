package com.lookmum.util 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class DisplayUtil 
	{
		public static function isVisible(object:DisplayObject):Boolean {
			if(object.stage == null)
				return false;
			var p:DisplayObjectContainer = object.parent;
			while(!(p is Stage)){
				if(!p.visible)
					return false;
				p = p.parent;
			}
			return true;
		}
	}

}