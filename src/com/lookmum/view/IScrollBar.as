package com.lookmum.view 
{
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public interface IScrollBar extends ILevelComponent, IComponent
	{
		/**
		 * sets the position back to min
		 */
		function resetScroll():void
		/**
		 * for use with textfield
		 * max scroll is max scroll property of a
		 * textfield
		 * 
		 * for use with a movieclip
		 * the height of a movieclip - the visible / mask height
		 */
		function set maxScroll(num:Number):void
		function get maxScroll():Number
		/**
		 * for a movieclip the height of the masked clip
		 * for a textfield the bottom scroll property
		 * 
		 */
		function set scrollSize(num:Number):void
		function get scrollSize():Number
		/**
		 * Scroll amount per mouse wheel click.
		 */
		function get wheelSpeed():int;
		function set wheelSpeed(value:int):void;
	}
	
}