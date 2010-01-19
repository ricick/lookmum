package com.lookmum.util {

	import com.lookmum.events.FunctionTweenerEvent;
	import com.lookmum.view.Component;
	import flash.events.EventDispatcher;
	import com.robertpenner.easing.Sine;

	[Event(name = "complete", type = "com.lookmum.events.FunctionTweenerEvent")]
	[Event(name = "start", type = "com.lookmum.events.FunctionTweenerEvent")]
	[Event(name = "update", type = "com.lookmum.events.FunctionTweenerEvent")]
	
	public class FunctionTweener extends EventDispatcher {
		
		private var func:Function;
		private var startValue:Number;
		private var endValue:Number;
		private var obj:Object;
		private var tweenMax:TweenMax;
		private var duration:Number;
		private var delay:Number = 0;
		private var easing:Function = Sine.easeOut;
		public function FunctionTweener() {
			obj = new Object();
		}
		
		public function tweenFunction(func:Function, startValue:Number, endValue:Number):void {
			this.startValue = startValue;
			this.endValue = endValue;			
			this.func = func;
			obj = { value:startValue };	
			tweenMax = TweenMax.to(obj, duration, { value:endValue, onUpdate:updateValue, onStart:onStart, onComplete:onComplete, ease:easing, delay:delay } );
		}	
		
		private function onComplete():void
		{
			dispatchEvent(new FunctionTweenerEvent(FunctionTweenerEvent.COMPLETE));
		}
		
		private function onStart():void
		{
			dispatchEvent(new FunctionTweenerEvent(FunctionTweenerEvent.START));
		}

		private function updateValue():void {
			func.call(null, obj.value);
			dispatchEvent(new FunctionTweenerEvent(FunctionTweenerEvent.UPDATE));
		}
		
		public function stopTween():void
		{
			TweenMax.killTweensOf(obj);
		}
		
		public function pauseTween():void
		{
			
			
			if(tweenMax)tweenMax.pause();
		}
		
		public function resumeTween():void
		{
			//TweenMax.resumeAll();
			if(tweenMax)tweenMax.resume();
			
		}
		
		public function setDuration(seconds:Number):void
		{
			duration = seconds;
		}
		
		public function getDuration():int
		{
			return duration;
		}
		
		public function setDelay(value:int):void
		{
			delay = value;
		}
		
		public function getDelay():int
		{
			return delay;
		}	
		
		public function getEasing():Function { 
			return easing; 
		}
		
		public function setEasing(value:Function):void 
		{
			easing = value;
		}		
	}	
}
