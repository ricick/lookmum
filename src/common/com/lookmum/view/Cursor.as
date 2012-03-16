
package com.lookmum.view 
{

	import com.lookmum.events.DragEvent;
	import com.lookmum.view.Component;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	

	public class Cursor extends Component
	{
		private static const DEFAULT:String = 'default';
		private static const HAND_OPEN:String = 'handOpen';
		private static const HAND_CLOSED:String = 'handClosed';
		private var _enabled:Boolean = true;
		private var dragging:Boolean;
		private var customCursorByEvent:Dictionary;
		private var currentCursor:String;
		public function Cursor(target:MovieClip) 
		{
			super(target);
			
			// changed thisMc.stage to stage
			
			target.stop();
			target.mouseEnabled = false;
			target.enabled = false;
			target.mouseChildren = false;
			setCursor(DEFAULT);
			customCursorByEvent = new Dictionary();
			if (stage) onAddedToStage();
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage)
		}
		
		private function onAddedToStage(event:Event = null):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(DragEvent.ROLLOVER_DRAG, onRollOverDrag);
			stage.addEventListener(DragEvent.ROLLOUT_DRAG, onRollOutDrag);
			stage.addEventListener(DragEvent.START, onStartDrag);
			stage.addEventListener(DragEvent.STOP, onStopDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (currentCursor != HAND_OPEN) setCursor(DEFAULT);
		}
		public function setEventCursor(rollOverEvent:String, rollOutEvent:String, cursorId:String):void {
			//trace( "Cursor.setEventCursor > rollOverEvent : " + rollOverEvent + ", rollOutEvent : " + rollOutEvent + ", cursorId : " + cursorId );
			stage.addEventListener(rollOverEvent, onRollOverCustom);
			stage.addEventListener(rollOutEvent, onRollOutCustom);
			customCursorByEvent[rollOverEvent] = cursorId;
		}
		
		protected function onRollOverCustom(e:Event):void 
		{
			if (!enabled) return;
			//trace( "Cursor.onRollOverCustom > e : " + e );
			if (dragging) return;
			setCursor(customCursorByEvent[e.type]);
		}
		protected function onRollOutCustom(e:Event):void 
		{
			if (!enabled) return;
			//trace( "Cursor.onRollOutCustom > e : " + e );
			if (dragging) return;
			setCursor(DEFAULT);
		}
		protected function onStopDrag(e:DragEvent):void 
		{
			if (!enabled) return;
			dragging = false;
			//setCursor(HAND_OPEN);
			setCursor(DEFAULT);
		}
		
		protected function onStartDrag(e:DragEvent):void 
		{
			if (!enabled) return;
			dragging = true;
			setCursor(HAND_CLOSED);
		}
		protected function onRollOverDrag(e:DragEvent):void {
			if (!enabled) return;
			if (dragging) return;
			setCursor(HAND_OPEN);
		}
		protected function onRollOutDrag(e:DragEvent):void {
			if (!enabled) return;
			if (dragging) return;
			setCursor(DEFAULT);
		}
		protected function onMouseMove(e:MouseEvent):void 
		{
			// changed thisMc.stage to stage
			this.x = (stage.mouseX);
			this.y = (stage.mouseY);
		}
		protected function setCursor(id:String):void
		{
			var hasLabel:Boolean = false;
			for (var i:int = 0; i < currentLabels.length; i++) 
			{
				var frameLabel:FrameLabel = currentLabels[i]
				if (id == frameLabel.name)
				{
					hasLabel = true;
					break;
				}
			}
			if (id == DEFAULT || !hasLabel)
			{
				currentCursor = DEFAULT;
				Mouse.show();
				visible = false;
			}else
			{
				currentCursor = id;
				Mouse.hide();
				visible = true;
				gotoAndStop(id);
			}
		}
		override public function get enabled():Boolean { return _enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			if (!value) setCursor(DEFAULT);
			_enabled = value;
		}
	}
	
}
