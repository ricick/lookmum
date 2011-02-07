package com.lookmum.view 
{
	import com.eclecticdesignstudio.motion.easing.IEasing;

	public interface ITweenableComponent
	{
		function get duration():Number;
		function set duration(value:Number):void;
		function widthTo(width:Number):void;
		function heightTo(height:Number):void;
		function rotateTo(rotation:Number):void;
		function get easing():IEasing;
		function set easing(easingIEasing:IEasing):void;
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
		function set easingPosition(easingIEasing:IEasing):void;
		function set easingWidth(easingIEasing:IEasing):void;
		function set easingHeight(easingIEasing:IEasing):void;
		function set easingAlpha(easingIEasing:IEasing):void;
		function set easingRotation(easingIEasing:IEasing):void;
		function set easingScale(easingIEasing:IEasing):void;
	}
	
}
