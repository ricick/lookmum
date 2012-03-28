package com.lookmum.util 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class SoundManager extends EventDispatcher
	{
		private var _level:Number = 1;
		static private var instance:SoundManager;
		private var cacheLevel:Number = 1;
		
		public function SoundManager() 
		{
			
		}
		/**
		 * Singleton function returns instance of SoundManager
		 * @return
		 */
		public static function getInstance () : SoundManager
		{
			if (instance == null)
			{
				instance = new SoundManager ();
			}
			return instance;
		}
		public function set level(value:Number):void {
			_level = (value);
			SoundMixer.soundTransform = new SoundTransform(value);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get level():Number 
		{
			return _level
		}
		
		public function get mute():Boolean 
		{
			return level == 0;
		}
		
		public function set mute(value:Boolean):void 
		{
			if (value) {
				cacheLevel = level;
				level = 0;
			}else if (cacheLevel == 0) {
				level = 1;
			}else {
				level = cacheLevel;
			}
		}
		
	}

}