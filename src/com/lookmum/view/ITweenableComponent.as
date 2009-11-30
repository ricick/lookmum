
package com.lookmum.view {
	public interface ITweenableComponent{
		function get duration():Number;
		function set duration(value:Number):void;
		function widthTo(width:Number):void;
		function heightTo(height:Number):void;
		function rotateTo(rotation:Number):void;
		function get easing():Function;
		function set easing(easingFunction:Function):void;
		function alphaTo(alpha:Number):void;
		function moveTo(x:Number, y:Number):void;
		function scaleTo(scale:Number):void;
		function scaleXTo(scale:Number):void;
		function scaleYTo(scale:Number):void;
		function stopTween():void;
		function set durationWidth(value:Number):void;
		function set durationHeight(value:Number):void;
		function set durationAlpha(value:Number):void;
		function set durationRotation(value:Number):void;
		function set durationPosition(value:Number):void;
		function set durationScale(value:Number):void;
		function set easingPosition(easingFunction:Function):void;
		function set easingWidth(easingFunction:Function):void;
		function set easingHeight(easingFunction:Function):void;
		function set easingAlpha(easingFunction:Function):void;
		function set easingRotation(easingFunction:Function):void;
		function set easingScale(easingFunction:Function):void
	}
	
}
