package com.lookmum.view {
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
		protected var tab:Button;
		protected var track:Button;
		protected var bar:Component;
		
		private var _level:Number = 0;
		
		private var _vertical:Boolean;
		private var _dragging:Boolean;
		
		public function Slider (target:MovieClip)
		{
			super (target);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			tab = createTab();
			tab.mouseEnabled = false;
			tab.mouseChildren = false;
			tab.tabEnabled = false;
			
			track = createTrack();
			track.addEventListener(MouseEvent.MOUSE_DOWN, onTrackDown);
			track.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			track.tabEnabled = false;
			
			bar = createBar();
			if (bar) {
				bar.mouseEnabled = false;
				bar.mouseChildren = false;
			}
			
			if (stage)
				onAddedToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onTrackMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onTrackUp);
		}

		protected function createTab():DragButton {
			if (!target.getChildByName('tab')) {
				return new DragButton(new MovieClip());
			}
			return new DragButton(target.getChildByName('tab') as MovieClip);
		}
		
		protected function createTrack():Button {
			return new Button(target.getChildByName('track') as MovieClip);
		}
		
		protected function createBar():Component {
			return target.bar ? new Component(target.bar) : null;
		}
		
		public function getTrack():Button { return track; }
		
		public function getTab():Button { return tab; }
		
		public function getIsDragging():Boolean { return _dragging; }
		
		override public function get width():Number { return track.width; }
		override public function set width(value:Number):void
		{
			if (vertical) {
				super.width = value;
			}else{
				track.width = (value);
				this.level = level;
			}
		}
		
		override public function get height():Number { return track.height; }
		override public function set height(value:Number):void 
		{
			if (vertical) {
				track.height = value;
				this.level = level;
			}else{
				super.height = value;
			}
		}
		
		override public function get enabled():Boolean { return super.enabled; }
		override public function set enabled(value:Boolean):void 
		{
			tab.enabled = value;
			track.enabled = value;
			track.tabEnabled = false;
		}
		
		override public function get useHandCursor():Boolean { return super.useHandCursor; }
		override public function set useHandCursor(value:Boolean):void 
		{
			tab.useHandCursor = (value);
			track.useHandCursor = (value);
		}
		
		override public function get doubleClickEnabled():Boolean {	return tab.doubleClickEnabled;	}
		override public function set doubleClickEnabled(value:Boolean):void {
			tab.doubleClickEnabled =(value);
		}
		
		public function get vertical():Boolean { return _vertical; }
		public function set vertical(value:Boolean):void 
		{
			_vertical = value;
			this.level = level;
		}
		
		override public function getIsFocus():Boolean {	return tab.getIsFocus(); }
		override public function setFocus():void {
			tab.setFocus();
		}
		
		public function get level():Number { return _level;	}
		public function set level(value:Number):void 
		{
			if (value > 1) value = 1;
			if (value < 0) value = 0;
			_level = value;
			if (vertical) {
				tab.y = (track.y + (track.height - tab.height) * (1 - value));
				if (bar) {
					bar.height = value * track.height;
					bar.y = track.height - bar.height;
				}
			}else {
				tab.x = (track.x + (track.width - tab.width) * value);
				if (bar) {
					bar.width = value * track.width;
				}
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function setTrackUseHandCursor(value:Boolean):void 
		{
			track.useHandCursor = (value);
		}
		
		protected function onMouseWheel(event:MouseEvent):void
		{
			var delta:int = event.delta;
			if (vertical)
				level += delta / track.height;
			else
				level += delta / track.width;
		}
		
		protected function onTrackDown(event:MouseEvent):void
		{
			_dragging = true;
			dispatchEvent(new DragEvent(DragEvent.START));
		}
		
		protected function onTrackMove(event:MouseEvent = null):void
		{
			if (_dragging) {
				if (vertical) {
					this.level = 1 - (track.mouseY / track.height);
				} else {
					this.level = track.mouseX / track.width;
				}
				dispatchEvent(new DragEvent(DragEvent.DRAG));
			}
		}
		
		protected function onTrackUp(event:MouseEvent):void
		{
			if (track.getBounds(stage).contains(stage.mouseX, stage.mouseY))
				onTrackMove();
			_dragging = false;
			dispatchEvent(new DragEvent(DragEvent.STOP));
		}
	}
}