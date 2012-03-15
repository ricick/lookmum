package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TiltingComponent extends Component
	{
		
		protected var destRotationX:Number;
		protected var destRotationY:Number;
		private var _turnToMouse:Boolean;
		public var xRotationScale:Number = 0.07;
		public var yRotationScale:Number = 0.02;
		public var invert:Boolean;
		public var turnEasing:Number = 20;
		public function TiltingComponent(target:MovieClip) 
		{
			super(target);
			
		}
		private function onMouseMove(e:MouseEvent = null):void 
		{
			var maxX:Number = 40;
			var maxY:Number = 20;
			var minX:Number = -40;
			var minY:Number = -20;
			var xRotation:Number = mouseY * xRotationScale;
			var yRotation:Number = -mouseX * yRotationScale;
			if (invert) {
				xRotation = -mouseY * xRotationScale;
				yRotation = mouseX * yRotationScale;
			}
			//apply limits
			
			if (xRotation > maxX) xRotation = maxX;
			if (yRotation > maxY) yRotation = maxY;
			if (xRotation < minX) xRotation = minX;
			if (yRotation < minY) yRotation = minY;
			
			destRotationX = xRotation;
			destRotationY = yRotation;
		}
		public function get turnToMouse():Boolean { return _turnToMouse; }
		
		public function set turnToMouse(value:Boolean):void 
		{
			_turnToMouse = value;
			if (value) {
				onMouseMove();
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}else {
				
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			}
		}
		
		protected function onEnterFrame(e:Event):void 
		{
			rotationX += (destRotationX-rotationX)/turnEasing;
			rotationY += (destRotationY-rotationY)/turnEasing;
		}
		
	}

}