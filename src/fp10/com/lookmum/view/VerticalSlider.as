package com.lookmum.view 
{
	import com.lookmum.events.DragEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class VerticalSlider extends Slider
	{
		
		public function VerticalSlider(target:MovieClip) 
		{
			super(target);
			
		}
	
		override protected function getDragBounds():Rectangle 
		{
			return new Rectangle(this.track.x, this.tab.y, 0, this.track.height - this.tab.height);
		}
		
		override protected function onReleaseTrack(event:MouseEvent):void 
		{
			this.tab.y = (mouseY + ( this.tab.height / 2 ));
			
			if(this.tab.y < this.tab.dragBounds.top) this.tab.y = (this.tab.dragBounds.top);
			if (this.tab.y > this.tab.dragBounds.bottom) this.tab.y = (this.tab.dragBounds.bottom);
			
			if (bar)
			{
				bar.height = tab.y - bar.y + tab.height;
			}
			
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new DragEvent(DragEvent.STOP));
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		override protected function onDrag(event:DragEvent):void 
		{
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new Event(Event.CHANGE));
			
			if (bar)
			{
				bar.height = tab.y - bar.y + tab.height;
			}
		}
		
		override protected function onMouseWheel(event:MouseEvent):void 
		{
			var delta:int = event.delta;
			var destY:Number = this.tab.y - delta;
			if(destY < track.y)destY = track.y;
			if(destY > track.y + track.height - tab.height)destY = track.y + track.height - tab.height;
			this.tab.y = (destY);
			
			if (bar)
			{
				bar.height = tab.y - bar.y + tab.height;
			}
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		override public function set level(value:Number):void 
		{
			if (value > 1 ) value = 1;
			if (value < 0) value = 0;
			
			this.tab.y = (this.track.y - (this.track.height + this.tab.height) * value);
			if (bar)
			{
				bar.height = tab.y - bar.y + tab.height;
			}
		}
		
		override public function get level():Number
		{ 
			return (this.tab.y - this.track.y) / (this.track.y + (this.track.height - this.tab.height));
		}
	
		override public function set height(value:Number):void 
		{
			this.track.height = (value);
			this.tab.dragBounds = (new Rectangle(this.track.x, this.tab.y, this.track.width - this.tab.width, 0));
			
			if (tab.y > this.track.height - this.tab.height) 
			{
				tab.y = this.track.height - this.tab.height;
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		
		override public function get height():Number 
		{ 
			return track.height;
		}
		
	}

}