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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
		
		private var _isMouseOutside:Boolean = false;
		
		public function Button(target:MovieClip) 
		{
			super(target);
			hitArea = getHitspot();
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp );
			doEnable();
		}
		protected function getHitspot():MovieClip
		{
			if (target.hitspot) return target.hitspot;
			return target;
		}
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
		
		//protected function get isMouseOutside():Boolean 
		//{
			//if (!stage) return true;
			//
			//var bounds:Rectangle = getHitspot().getBounds(stage);
			//var mx:Number = stage.mouseX;
			//var my:Number = stage.mouseY;
			//trace(bounds, mx, my, bounds.x <= mx <= (bounds.x + bounds.width), bounds.y <= my <= (bounds.y + bounds.height));
			//return !(bounds.x <= mx <= (bounds.x + bounds.width) &&
				   //bounds.y <= my <= (bounds.y + bounds.height)); 
		//}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if (!value)
				isMouseOutside = true;
		}
		
		protected function get isMouseOutside():Boolean
		{
			return _isMouseOutside;
		}
		
		protected function set isMouseOutside(value:Boolean):void 
		{
			_isMouseOutside = value;
		}
		
		protected function doEnable():void {
			ModalManager.getInstance().registerComponent(this, this.doDisable);
			animationRollOut();
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
			animationDisable();
			this.dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.DISABLE));
		}
		
		//{region animations
		
		protected function onRollOver(e:MouseEvent):void 
		{
			isMouseOutside = false;
			if (!enabled) return;
			animationRollOver();
		}
		
		protected function onRollOut(e:MouseEvent):void 
		{
			isMouseOutside = true;
			if (!enabled) return;
			animationRollOut();
		}
		
		protected function onMouseDown(e:MouseEvent):void 
		{
			if (!enabled) return;
			animationMouseDown();
			if (getHitspot().stage) getHitspot().stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		protected function onMouseUp(e:MouseEvent):void 
		{
			if (!enabled) return;
			animationRollOver();
			if (isMouseOutside) 
			{
				//isMouseOutside = false;
				animationRollOut();
				if (getHitspot().stage) getHitspot().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				dispatchEvent(new InteractiveComponentEvent(InteractiveComponentEvent.MOUSE_UP_OUTSIDE, true));
			}
		}
		//animations
		protected function animationRollOver():void 
		{
			target.gotoAndStop(FRAME_ROLL_OVER);
		}
		protected function animationRollOut():void 
		{
			target.gotoAndStop(FRAME_ROLL_OUT);
		}
		protected function animationMouseDown():void 
		{
			target.gotoAndStop(FRAME_PRESS);
		}
		protected function animationDisable():void 
		{
			target.gotoAndStop(FRAME_DISABLE);
		}
		
		override public function destroy():void 
		{
			if(getHitspot().stage) getHitspot().stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp) ;
			
			super.destroy();
			
		}
	}

}