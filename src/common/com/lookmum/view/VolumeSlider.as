package com.lookmum.view{
	/**
	* Description here..
	* @author Default
	* @version 0.1
	*/

	import com.lookmum.events.DragEvent;
	import com.lookmum.util.SoundManager;
	import com.lookmum.view.Slider;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	public class VolumeSlider extends Slider{
		protected var soundManager:SoundManager;
		public function VolumeSlider(target:MovieClip) {
			super(target);
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			soundManager = SoundManager.getInstance();
			soundManager.addEventListener(Event.CHANGE, onChangeLevel);
			this.addEventListener(DragEvent.DRAG,onSlide);
			this.level = (1);
		}
		
		private function onChangeLevel(e:Event):void 
		{
			super.level = soundManager.level;
		}
		override public function set level(value:Number):void{
			super.level = (value);
			soundManager.level = value;
		}
		
		override public function get level():Number 
		{
			return super.level
		}
		public function onSlide(event:DragEvent):void
		{
			soundManager.level = this.level;
		}
	}
}