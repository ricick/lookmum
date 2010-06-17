package com.lookmum.view{
	import com.lookmum.events.DragEvent;
	import com.lookmum.view.Button;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[Event(name = "change", type = "flash.events.Event")]
	
	[Event(name = "start", type = "com.lookmum.events.DragEvent")]
	[Event(name = "stop", type = "com.lookmum.events.DragEvent")]
	[Event(name = "drag", type = "com.lookmum.events.DragEvent")]
	
	public class Slider extends Component implements ILevelComponent
	{
		protected var tab:DragButton;
		protected var track:Button;
		private var _dragging:Boolean = false;
		protected var bar:MovieClip;
		public function Slider (target:MovieClip)
		{
			super (target);
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			this.track = new Button(target.getChildByName('track') as MovieClip);
			this.tab = new DragButton(target.getChildByName('tab') as MovieClip);
			this.tab.dragBounds = (new Rectangle(this.track.x, this.tab.y, this.track.width - this.tab.width, 0));
			
			this.tab.addEventListener(DragEvent.START,onStartDrag);
			this.tab.addEventListener(DragEvent.DRAG,onDrag);
			this.tab.addEventListener(DragEvent.STOP, onStopDrag);
			
			this.tab.tabEnabled = (false);
			this.track.addEventListener(MouseEvent.MOUSE_UP,onReleaseTrack);
			this.track.tabEnabled = (false);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			if (target.bar)
			{
				bar = target.bar;
				bar.mouseEnabled = false;
			}
		}
		
		public function getTrack():Button {
			return track;
		}
		
		public function getTab():DragButton {
			return tab;
		}
		
		public function getIsDragging():Boolean
		{
			return this._dragging;
		}
		protected function onMouseWheel(event:MouseEvent):void
		{
			var delta:int = event.delta;
			var destX:Number = this.tab.x+delta
			if(destX<track.x)destX = track.x;
			if(destX > track.x + track.width - tab.width)destX = track.x + track.width - tab.width;
			this.tab.x = (destX);
			if (bar)
			{
				bar.width = destX - bar.x + tab.width;
			}
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		private function onStartDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.START));
			this._dragging = true;
		}
		
		protected function onDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new Event(Event.CHANGE));
			if (bar)
			{
				bar.width = tab.x - bar.x + tab.width;
			}
		}
		protected function onStopDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.STOP));
			this._dragging = false;
		}
		override public function set width(value:Number):void
		{
			this.track.width = (value);
			this.tab.dragBounds = (new Rectangle(this.track.x, this.tab.y, this.track.width - this.tab.width, 0));
			
			if (tab.x > this.track.width - this.tab.width) 
			{
				tab.x = this.track.width - this.tab.width;
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		override public function get width():Number
		{
			return track.width;
		}
		
		override public function get enabled():Boolean { return super.enabled; }
		override public function set enabled(value:Boolean):void 
		{
			if (value) 
			{
				this.tab.enabled = true;
				this.track.enabled = true;
				this.track.tabEnabled = (false);
			}
			else 
			{
				this.tab.enabled = false;
				this.track.enabled = false;
			}
		}
		override public function get useHandCursor():Boolean { return super.useHandCursor; }
		
		override public function set useHandCursor(value:Boolean):void 
		{
			this.tab.useHandCursor = (value);
			this.track.useHandCursor = (value);
		}
		
		public function setTrackUseHandCursor(value:Boolean):void 
		{
			this.track.useHandCursor = (value);
		}
		
		public function set level(value:Number):void 
		{
			if(value>1)value = 1;
			if(value<0)value = 0;
			this.tab.x = (this.track.x +(this.track.width-this.tab.width) * value);
			if (bar)
			{
				bar.width = tab.x - bar.x + tab.width;
			}
		}
		public function get level():Number 
		{
			return (this.tab.x-this.track.x)/(this.track.x+(this.track.width-this.tab.width));
		}
		
		protected function onReleaseTrack(event:MouseEvent):void
		{
			this.tab.x = (mouseX-(this.tab.width/2));
			if(this.tab.x<this.tab.dragBounds.left)this.tab.x = (this.tab.dragBounds.left);
			if(this.tab.x>this.tab.dragBounds.right)this.tab.x = (this.tab.dragBounds.right);
			if (bar)
			{
				bar.width = tab.x - bar.x + tab.width;
			}
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new DragEvent(DragEvent.STOP));
			this.dispatchEvent(new Event(Event.CHANGE));
			
		}
		override public function setFocus():void{
			this.tab.setFocus();
		}
		override public function set doubleClickEnabled(value:Boolean):void {
			this.tab.doubleClickEnabled =(value);
		}
		override public function get doubleClickEnabled():Boolean {
			return this.tab.doubleClickEnabled;
		}
		override public function getIsFocus():Boolean {
			return this.tab.getIsFocus();
		}
	}
}