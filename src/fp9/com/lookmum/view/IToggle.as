package com.lookmum.view{
	/**
	* IToggle components can toggle between two states, for example checkboxes
	* @author Phil Douglas
	* @version 0.1
	*/
	
	public interface IToggle extends IComponent {
		/**
		 * The current toggle state
		 */
		function get toggle():Boolean;
		function set toggle(value:Boolean):void;
		
	}
}