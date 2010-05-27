package com.lookmum.view 
{
	import com.lookmum.events.InteractiveComponentEvent;
	import com.lookmum.util.ModalManager;
	import com.lookmum.view.Component;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class Button extends Component
	{
		protected const FRAME_ROLL_OVER:String = 'rollOver';
		protected const FRAME_ROLL_OUT:String = 'rollOut';
		protected const FRAME_PRESS:String = 'press';
		protected const FRAME_DISABLE:String = 'disable';
		
		protected var _isMouseOutside:Boolean = false;
		
		public function Button(target:MovieClip) 
		{
			super(target);
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp );
			doEnable();
		}
		protected function getHitspot():MovieClip
		{
			//if (target.getChildByName("hitspot")) return target.getChildByName("hitspot") as MovieClip;
			return target;
		}
		/*
		override protected function addEventListeners():void 
		{
			var eventList:Array = [
				Event.TAB_INDEX_CHANGE,
				Event.TAB_ENABLED_CHANGE,
				Event.TAB_CHILDREN_CHANGE,
				KeyboardEvent.KEY_UP,
				KeyboardEvent.KEY_DOWN,
				MouseEvent.ROLL_OVER,
				MouseEvent.ROLL_OUT,
				MouseEvent.MOUSE_WHEEL,
				MouseEvent.MOUSE_UP,
				MouseEvent.MOUSE_OVER,
				MouseEvent.MOUSE_OUT,
				MouseEvent.MOUSE_MOVE,
				MouseEvent.MOUSE_DOWN,
				MouseEvent.DOUBLE_CLICK,
				MouseEvent.CLICK,
				FocusEvent.MOUSE_FOCUS_CHANGE,
				FocusEvent.KEY_FOCUS_CHANGE,
				FocusEvent.FOCUS_OUT,
				FocusEvent.FOCUS_IN,
				Event.RENDER,
				Event.REMOVED_FROM_STAGE,
				Event.REMOVED,
				Event.ENTER_FRAME,
				Event.ADDED_TO_STAGE,
				Event.ADDED,
			]
			for each(var eventType:String in eventList) 
			{
				getHitspot().addEventListener(eventType, onEvent, false, 0, true);
			}
		}
		*/
		/**
		 * A Boolean value that indicates whether a movie clip is enabled.
		 */
		override public function get enabled():Boolean { return super.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			//also set mouseenabled to the same value
			if (value) {
				doEnable();
			}else {
				ModalManager.getInstance().unregisterComponent(this);
				this.doDisable();
			}
		}
		
		public function get isMouseOutside():Boolean { return _isMouseOutside; }
		
		public function set isMouseOutside(value:Boolean):void 
		{
			_isMouseOutside = value;
		}
		protected function doEnable():void {
			ModalManager.getInstance().registerComponent(this, this.doDisable);
			target.gotoAndStop(FRAME_ROLL_OUT);
			buttonMode = true;
			tabEnabled = true;
			mouseEnabled = true;
			super.enabled = true;
			mouseChildren = true;
			this.dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.ENABLE));
		}
		protected function doDisable():void {
			buttonMode = false;
			tabEnabled = false;
			mouseEnabled = false;
			super.enabled = false;
			mouseChildren = false;
			target.gotoAndStop(FRAME_DISABLE);
			this.dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.DISABLE));
		}
		
		//{region animations
		
		protected function onRollOver(e:MouseEvent):void 
		{
			if (!enabled) return;
			target.gotoAndStop(FRAME_ROLL_OVER);
		}
		
		protected function onRollOut(e:MouseEvent):void 
		{
			isMouseOutside = true;
			if (!enabled) return;
			target.gotoAndStop(FRAME_ROLL_OUT);
		}
		
		protected function onMouseDown(e:MouseEvent):void 
		{
			if (!enabled) return;
			target.gotoAndStop(FRAME_PRESS);
			getHitspot().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		//private function onMouseUpOutside(e:MouseEvent):void 
		//{
			//trace( "Button.onMouseUpOutside > e : " + e );
			//getHitspot().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpOutside);
			//dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, true));
		//}
		
		protected function onMouseUp(e:MouseEvent):void 
		{
			if (!enabled) return;
			target.gotoAndStop(FRAME_ROLL_OVER);
			if (isMouseOutside) 
			{
				isMouseOutside = false;
				getHitspot().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, true));
			}
	
			//if (getHitspot().stage) 
			//{
				//trace( "getHitspot().stage : ");
				//
				//getHitspot().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//}
			//if (e.target == getHitspot() || getHitspot().contains(e.target as DisplayObject))
			//{
				 //mouse is up over circle (onRelease)
				 //(if circle is not a DisplayObjectContainer,
				 //you do not need to use the contains check)
			//}
			//else 
			//{
				// mouse is up outside circle (onReleaseOutside)
				//trace( "outside circle : " );
				//dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.MOUSE_UP_OUTSIDE));
			//}
			
		}
		
		//}
		
		
		
	}

}