package com.lookmum.view 
{
	import com.lookmum.events.ComponentEvent;
	import com.lookmum.events.DragEvent;
	import com.lookmum.events.InteractiveComponentEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class LabelDragButton extends LabelButton implements IDraggable
	{
		private var _lockCenter:Boolean;
		private var _dragBounds:Rectangle;
		
		public function LabelDragButton(target:MovieClip) 
		{
			super(target);
			addEventListener(MouseEvent.MOUSE_DOWN,doStartDrag);
			addEventListener(MouseEvent.MOUSE_UP, doStopDrag);
			addEventListener(MouseEvent.MOUSE_OVER,onRollOverDrag);
			addEventListener(MouseEvent.MOUSE_OUT, onRollOutDrag);
			addEventListener(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, doStopDrag);
			
		}
		/**
		 * Bubble event for cursors
		 * @param	e
		 */
		private function onRollOutDrag(e:MouseEvent):void 
		{
			target.dispatchEvent(new DragEvent(DragEvent.ROLLOUT_DRAG, true));
		}
		/**
		 * Bubble event for cursors
		 * @param	e
		 */
		private function onRollOverDrag(e:MouseEvent):void 
		{
			target.dispatchEvent(new DragEvent(DragEvent.ROLLOVER_DRAG, true));
		}
		private function doStartDrag(event:MouseEvent):void {
			startDrag(_lockCenter, _dragBounds);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDrag);
			dispatchEvent(new DragEvent(DragEvent.START));
			//Bubble event for cursors
			target.dispatchEvent(new DragEvent(DragEvent.START, true));
		}
		
		private function doStopDrag(event:Event):void 
		{
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onDrag);
			dispatchEvent(new DragEvent(DragEvent.STOP));
			target.dispatchEvent(new DragEvent(DragEvent.STOP, true));
		}
		
		private function onDrag(event:MouseEvent):void {
			dispatchEvent(new DragEvent(DragEvent.DRAG));
			target.dispatchEvent(new DragEvent(DragEvent.DRAG));
			dispatchEvent(new ComponentEvent(ComponentEvent.MOVE));
		}
		
		public function get lockCenter():Boolean { return _lockCenter; }
		
		public function set lockCenter(value:Boolean):void 
		{
			_lockCenter = value;
		}
		
		public function get dragBounds():Rectangle { return _dragBounds; }
		
		public function set dragBounds(value:Rectangle):void 
		{
			_dragBounds = value;
		}
		
	}

}