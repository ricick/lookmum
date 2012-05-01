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
		protected var progressBar:Component;
		protected var bufferBar:Component;
		private var _dragging:Boolean = false;
		private var _vertical:Boolean;
		private var tabStartX:Number;
		private var tabStartY:Number;
		public function Slider (target:MovieClip)
		{
			super (target);
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			this.track = createTrack();
			this.tab = createTab();
			if (this.tab)
			{
				tabStartX = tab.x;
				tabStartY = tab.y;
				this.tab.dragBounds = getDragBounds();
				
				this.tab.addEventListener(DragEvent.START, onStartDrag);
				this.tab.addEventListener(DragEvent.DRAG, onDrag);
				this.tab.addEventListener(DragEvent.STOP, onStopDrag);
				
				this.tab.tabEnabled = (false);
				this.track.addEventListener(MouseEvent.MOUSE_UP, onReleaseTrack);
				this.track.tabEnabled = (false);
				addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			}
			
			progressBar = createProgessBar();
			if (progressBar)
			{
				progressBar.mouseEnabled = false;
			}
			
			bufferBar = createBufferBar();
			if (bufferBar)
			{
				bufferBar.mouseEnabled = false;
			}
		}
		protected function createTrack():Button {
			return new Button(target.getChildByName('track') as MovieClip);
		}
		protected function createTab():DragButton {
			if (!target.getChildByName('tab')) return null;
			return new DragButton(target.getChildByName('tab') as MovieClip);
		}
		protected function createProgessBar():Component {
			return target.bar ? new Component(target.bar) : null;
		}
		protected function createBufferBar():Component {
			return target.bufferBar ? new Component(target.bufferBar) : null;
		}
		
		protected function getDragBounds():Rectangle
		{
			if (this.tab) 
			{
				if (vertical) {
					return new Rectangle(this.tab.x, this.track.y, 0, this.track.height - this.tab.height);
				}else{
					return new Rectangle(this.track.x, this.tab.y, this.track.width - this.tab.width, 0);
				}
			}
			
			return null;
		}
		
		public function getTrack():Button {
			return track;
		}
		
		public function getTab():DragButton {
			if (tab) return tab;
			else return null;
		}
		
		public function getIsDragging():Boolean
		{
			return this._dragging;
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			var delta:int = event.delta;
			if (this.tab)
			{
				if (vertical) {
					var destY:Number = this.tab.y - delta;
					if(destY < track.y) destY = track.y;
					if(destY > track.y + track.height - tab.height)destY = track.y + track.height - tab.height;
					this.tab.y = (destY);
					
					if (progressBar)
					{
						updateProgressBar();
					}
				}else{
					var destX:Number = this.tab.x+delta
					if(destX<track.x)destX = track.x;
					if(destX > track.x + track.width - tab.width)destX = track.x + track.width - tab.width;
					this.tab.x = (destX);
					
					if (progressBar)
					{
						updateProgressBar();
					}
				}
			}
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		private function updateProgressBar():void {
			if (tab)
			{
				if (vertical) {
					progressBar.y = tab.y;
					progressBar.height = track.height - tab.y;
				}else {
					progressBar.width = tab.x - progressBar.x + tab.width * 0.5;
				}
			}
			
		}
		private function updateBufferBar(value:Number):void{
			if (vertical) {
				bufferBar.height = value * track.height;
				bufferBar.y = track.height - bufferBar.height;
			}else {
				bufferBar.width = value * track.width;
			}
		}
		protected function onStartDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.START));
			this._dragging = true;
		}
		
		protected function onDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new Event(Event.CHANGE));
			if (vertical) {
				if (progressBar)
				{
					updateProgressBar();
				}
			}else{
				if (progressBar)
				{
					updateProgressBar();
				}
			}
		}
		
		protected function onStopDrag(event:DragEvent):void
		{
			this.dispatchEvent(new DragEvent(DragEvent.STOP));
			this._dragging = false;
		}
		
		override public function set width(value:Number):void
		{
			if (vertical) {
				super.width = value;
			}else{
				this.track.width = (value);
				if (this.tab)
				{	
					this.tab.dragBounds = getDragBounds();
					
					if (tab.x > this.track.width - this.tab.width) 
					{
						tab.x = this.track.width - this.tab.width;
						this.dispatchEvent(new Event(Event.CHANGE));
					}
				}
				
			}
		}
		override public function get width():Number
		{
			return track.width;
		}
		override public function set height(value:Number):void 
		{
			if (vertical) {
				this.track.height = (value);
				
				if (this.tab)
				{
					this.tab.dragBounds = (new Rectangle(this.track.x, this.tab.y, this.track.width - this.tab.width, 0));
					if (tab.y > this.track.height - this.tab.height) 
					{
						tab.y = this.track.height - this.tab.height;
						this.dispatchEvent(new Event(Event.CHANGE));
					}
				}
				
			}else{
				super.height = value;
			}
		}
		
		override public function get height():Number 
		{ 
			return track.height;
		}
		
		override public function get enabled():Boolean { return super.enabled; }
		override public function set enabled(value:Boolean):void 
		{
			if (value) 
			{
				if (this.tab) this.tab.enabled = true;
				this.track.enabled = true;
				this.track.tabEnabled = (false);
			}
			else 
			{
				if (this.tab) this.tab.enabled = false;
				this.track.enabled = false;
			}
		}
		override public function get useHandCursor():Boolean { return super.useHandCursor; }
		
		override public function set useHandCursor(value:Boolean):void 
		{
			if (this.tab) this.tab.useHandCursor = (value);
			this.track.useHandCursor = (value);
		}
		
		public function setTrackUseHandCursor(value:Boolean):void 
		{
			this.track.useHandCursor = (value);
		}
		
		public function set level(value:Number):void 
		{
			if (vertical) {
					
				if (value > 1 ) value = 1;
				if (value < 0) value = 0;
				
				if (this.tab)
				{ 
					this.tab.y = (this.track.y +(this.track.height-this.tab.height) * (1 - value));
				}
				if (progressBar)
				{
					updateProgressBar();
				}
			}else {
				if(value>1)value = 1;
				if (value < 0) value = 0;
				
				if (this.tab)
				{
					this.tab.x = (this.track.x +(this.track.width - this.tab.width) * value);
				}
								
				if (progressBar)
				{
					updateProgressBar();
				}	
			}
		}
		
		public function get level():Number 
		{
				if (vertical) {
					//trace( "this.tab.height : " + this.tab.height );
					//trace( "this.track.height : " + this.track.height );
					//trace( "this.track.y : " + this.track.y );
					//trace( "this.tab.y : " + this.tab.y );
					return 1 - ((this.tab.y - this.track.y) / (this.track.y + (this.track.height - this.tab.height)));
				}else{
					return (this.tab.x - this.track.x) / (this.track.x + (this.track.width - this.tab.width));
				}				
		}
		
		protected function onReleaseTrack(event:MouseEvent):void
		{
			if (vertical) {
				if (this.tab)
				{
					this.tab.y = (mouseY + ( this.tab.height / 2 ));
					
					if (this.tab.y > this.tab.dragBounds.bottom) this.tab.y = (this.tab.dragBounds.bottom);
					if (this.tab.y < this.tab.dragBounds.top) this.tab.y = (this.tab.dragBounds.top);
				}
								
				if (progressBar)
				{
					updateProgressBar();
				}
			}else {
				if (this.tab)
				{
					this.tab.x = (mouseX - (this.tab.width / 2));
					if (this.tab.x < this.tab.dragBounds.left) this.tab.x = (this.tab.dragBounds.left);
					if (this.tab.x > this.tab.dragBounds.right) this.tab.x = (this.tab.dragBounds.right);
				}
				
				if (progressBar)
				{
					updateProgressBar();
				}
			}
			this.dispatchEvent(new DragEvent(DragEvent.DRAG));
			this.dispatchEvent(new DragEvent(DragEvent.STOP));
			this.dispatchEvent(new Event(Event.CHANGE));
			
		}
		override public function setFocus():void {
			if (this.tab)
			{
				this.tab.setFocus();
			}
			
		}
		override public function set doubleClickEnabled(value:Boolean):void {
			if (this.tab)
			{
				this.tab.doubleClickEnabled =(value);
			}
			
		}
		override public function get doubleClickEnabled():Boolean {
			return this.tab.doubleClickEnabled;
		}
		
		public function get vertical():Boolean 
		{
			return _vertical;
		}
		
		public function set vertical(value:Boolean):void 
		{
			_vertical = value;
			if (this.tab)
			{
				tab.x = tabStartX;
				tab.y = tabStartY;
				this.tab.dragBounds = getDragBounds();
			}			
			level = this.level;
		}
		
		override public function getIsFocus():Boolean {
			if (this.tab)
			{
				return this.tab.getIsFocus();
			} else {
				return false;	
			}	
		}
		
		public function set loadLevel(value:Number):void {
			if (bufferBar)
			{
				updateBufferBar(value);
			}
		}
	}
}