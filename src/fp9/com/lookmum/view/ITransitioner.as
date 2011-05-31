package com.lookmum.view 
{
	import com.lookmum.view.IComponent;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public interface ITransitioner extends IComponent
	{
		function transitionIn():void;
		function transitionOut():void;
		function get onIn():Signal;
		function get onOut():Signal;
		function get isTransitioning():Boolean;
		function reset():void;
	}
	
}