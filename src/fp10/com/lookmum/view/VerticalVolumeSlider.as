package com.lookmum.view 
{
	import com.lookmum.events.DragEvent;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class VerticalVolumeSlider extends VerticalSlider
	{
		
		public function VerticalVolumeSlider(target:MovieClip) 
		{
			super(target);
			this.addEventListener(DragEvent.DRAG,onSlide);
			this.level = (0.5);
		}
		
		override public function set level(value:Number):void
		{
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