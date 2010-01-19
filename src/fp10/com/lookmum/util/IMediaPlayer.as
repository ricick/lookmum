package com.lookmum.util{
	import flash.events.IEventDispatcher;
	/**
	* ...
	* @author Default
	* @version 0.1
	*/

	public interface IMediaPlayer extends IEventDispatcher {
		function load(url:String,autoPlay:Boolean = true):void;
		/**
		 * Play the currently loading media
		 */
		function play():void;
		/**
		 * Pause the current playing media
		 */
		function get playing():Boolean;
		function get time():Number;
		function get duration():Number;
		function get loadLevel():Number;
		function get bufferTime():Number;
		function set bufferTime(value:Number):void ;
		function pause():void;
		function seek(time:Number):void;
		function clear():void;
	}
}