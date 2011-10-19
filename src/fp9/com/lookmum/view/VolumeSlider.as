package com.lookmum.view{
	/**
	* Description here..
	* @author Default
	* @version 0.1
	*/

	import com.lookmum.events.DragEvent;
	import com.lookmum.view.Slider;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;

	public class VolumeSlider extends Slider {

		public function VolumeSlider(target:MovieClip) {
			super(target);
			this.addEventListener(DragEvent.DRAG,onSlide);
			this.level = (1);
		}
		override public function set level(value:Number):void{
			super.level = (value);
			SoundMixer.soundTransform = new SoundTransform(this.level);
		}
		
		override public function get level():Number 
		{
			return super.level
		}
		public function onSlide(event:DragEvent):void
		{
			SoundMixer.soundTransform = new SoundTransform(this.level);
			
		}
	}
}