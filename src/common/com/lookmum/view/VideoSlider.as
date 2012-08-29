package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author theeban
	 */
	public class VideoSlider extends Slider
	{
		
		protected var bufferBar:Component;
		private var _loadLevel:Number = 0;
		
		public function VideoSlider(target:MovieClip) 
		{
			super(target);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			track.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			bufferBar = createBufferBar();
			if (bufferBar)
			{
				bufferBar.mouseEnabled = false;
			}
		}
		
		protected function createBufferBar():Component {
			return target.bufferBar ? new Component(target.bufferBar) : null;
		}
		
		override public function get level():Number 
		{
			return super.level;
		}
		
		override public function set level(value:Number):void 
		{
			super.level = Math.min(value, loadLevel);
		}
		
		public function get loadLevel():Number {
			return _loadLevel;
		}
		
		public function set loadLevel(value:Number):void {
			_loadLevel = value;
			if (vertical) {
				if (bufferBar) {
					bufferBar.height = value * track.height;
					bufferBar.y = track.height - bufferBar.height;
				}
			}else {
				if (bufferBar) {
					bufferBar.width = value * track.width;
				}
			}
		}
		
	}

}