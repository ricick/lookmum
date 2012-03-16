package com.lookmum.view 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public interface IDraggable extends IComponent 
	{
		
		function get lockCenter():Boolean;
		function set lockCenter(value:Boolean):void;
		function get dragBounds():Rectangle;
		function set dragBounds(value:Rectangle):void;
	}
	
}