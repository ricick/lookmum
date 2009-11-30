package com.lookmum.view {
	
	import com.greensock.TweenMax;
	import com.lookmum.events.TweenableComponentEvent;
	import com.lookmum.util.FunctionTweener;
	import com.lookmum.view.IComponent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.lookmum.view.Component;
	
	[Event(name = "complete", type = "flash.events.Event")]
	[Event(name = "update", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "widthTo", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "heightTo", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "rotateTo", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "fadeTo", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "moveTo", type = "com.lookmum.events.TweenableComponentEvent")]
	[Event(name = "scaleTo", type = "com.lookmum.events.TweenableComponentEvent")]
	
	public class TweenableComponent extends Component implements ITweenableComponent {
		
		private static const DEFAULT_DURATION:Number = 1000;
		
		//durations
		private var _duration:Number;
		private var _positionDuration:Number;
		private var _widthDuration:Number;
		private var _heightDuration:Number;
		private var _alphaDuration:Number;
		private var _rotationDuration:Number;
		private var _scaleDuration:Number;
		private var _scaleXDuration:Number;
		private var _scaleYDuration:Number;
		//easing functions
		private var _easing:Function;
		private var _positionEasing:Function;
		private var _widthEasing:Function;
		private var _heightEasing:Function;
		private var _alphaEasing:Function;
		private var _rotationEasing:Function;
		private var _scaleEasing:Function;			
		private var _scaleXEasing:Function;			
		private var _scaleYEasing:Function;
		//tweens
		private var _positionTween:TweenMax;
		private var _widthTween:TweenMax;
		private var _heightTween:TweenMax;
		private var _alphaTween:TweenMax;
		private var _rotationTween:TweenMax;
		private var _scaleTween:TweenMax;
		private var _scaleXTween:TweenMax;
		private var _scaleYTween:TweenMax;
		//delays
		private var _delay:Number = 0;
		
		public function TweenableComponent(target:MovieClip) {
			super(target);
			duration = DEFAULT_DURATION;
		}
		//*/
		/*
		 * Getters and Setters
		 */
		
		public function get duration():Number {
			return convertSecondsToMilliseconds(_duration);
		}
		
		public function set duration(milliseconds:Number):void {
			
			_duration = convertMillisecondsToSeconds(milliseconds);
			_positionDuration = _duration;
			_widthDuration = _duration;
			_heightDuration = _duration;
			_alphaDuration = _duration;
			_rotationDuration = _duration;
			_scaleDuration = _duration;
		}
		public function set durationWidth(value:Number):void {
			_widthDuration = value;
		}
		
		public function set durationHeight(value:Number):void {
			_heightDuration = value;
		}
		
		public function set durationAlpha(value:Number):void {
			_alphaDuration = value;
		}
		
		public function set durationRotation(value:Number):void {
			_rotationDuration = value;
		}
		
		public function set durationPosition(value:Number):void {
			_positionDuration = value;
		}
		
		public function set durationScale(value:Number):void {
			_scaleDuration = value;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		public function get easing():Function {
			return _easing;
		}
		
		public function set easing(easingFunction:Function):void {
			_easing = easingFunction;
			_positionEasing = _easing;
			_widthEasing = _easing;
			_heightEasing = _easing;
			_alphaEasing = _easing;
			_rotationEasing = _easing;
			_scaleEasing = _easing;			
			_scaleXEasing = _easing;			
			_scaleYEasing = _easing;
		}
		public function set easingPosition(easingFunction:Function):void {
			_positionEasing = easingFunction;
		}
		
		public function set easingWidth(easingFunction:Function):void {
			_widthEasing = easingFunction;
		}
		
		public function set easingHeight(easingFunction:Function):void {
			_heightEasing = easingFunction;
		}
		
		public function set easingAlpha(easingFunction:Function):void {
			_alphaEasing = easingFunction;
		}
		
		public function set easingRotation(easingFunction:Function):void {
			_rotationEasing = easingFunction;
		}
		
		public function set easingScale(easingFunction:Function):void {
			_scaleEasing = easingFunction;		
		}
		
		public function set easingXScale(easingFunction:Function):void {
			_scaleXEasing = easingFunction;		
		}
		
		public function set easingYScale(easingFunction:Function):void {
			_scaleYEasing = easingFunction;		
		}
		/*
		 * Public Methods
		 */
		
		public function widthTo(newWidth:Number):void {
			if (_widthTween)_widthTween.kill();
			_widthTween = TweenMax.to(this, _widthDuration, { width:newWidth, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteWidthTween, ease:_widthEasing, delay:delay } );
		}
		
		
		public function heightTo(newHeight:Number):void {
			if (_heightTween)_heightTween.kill();
			_heightTween = TweenMax.to(this, _heightDuration, { height:newHeight, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteHeightTween, ease:_heightEasing, delay:delay } );
		}
		
		public function rotateTo(newRotation:Number):void {
			if (_rotationTween)_rotationTween.kill();
			_rotationTween = TweenMax.to(this, _rotationDuration, { rotation:newRotation, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteRotationTween, ease:_rotationEasing, delay:delay } );
		}
		
		public function alphaTo(newAlpha:Number):void {
			if (_alphaTween)_alphaTween.kill();
			_alphaTween = TweenMax.to(this, _alphaDuration, { alpha:newAlpha, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteAlphaTween, ease:_alphaEasing, delay:delay } );
		}
		
		public function moveTo(newX:Number, newY:Number):void {
			if (_positionTween)_positionTween.kill();
			_positionTween = TweenMax.to(this, _positionDuration, { x:newX, y:newY, onUpdate:onUpdate, onStart:onStart, onComplete:onCompletePositionTween, ease:_positionEasing, delay:delay } );
		}
		
		public function scaleTo(newScale:Number):void {
			if (_scaleTween)_scaleTween.kill();
			_scaleTween = TweenMax.to(this, _scaleDuration, { scaleX:newScale, scaleY:newScale, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteScaleTween, ease:_scaleEasing, delay:delay } );
		}
		
		public function scaleXTo(newScale:Number):void {
			if (_scaleTween)_scaleTween.kill();
			_scaleTween = TweenMax.to(this, _scaleXDuration, { scaleX:newScale, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteScaleTween, ease:_scaleXEasing, delay:delay } );
		}
		
		public function scaleYTo(newScale:Number):void {
			if (_scaleTween)_scaleTween.kill();
			_scaleTween = TweenMax.to(this, _scaleYDuration, { scaleY:newScale, onUpdate:onUpdate, onStart:onStart, onComplete:onCompleteScaleTween, ease:_scaleYEasing, delay:delay } );
		}
		
		public function stopTween():void {
			for each(var tween:TweenMax in TweenMax.getTweensOf(this)) {
				tween.pause();
			}
		}
		
		public function pauseTween():void {
			for each(var tween:TweenMax in TweenMax.getTweensOf(this)) {
				tween.pause();
			}
		}
		
		public function resumeTween():void {
			for each(var tween:TweenMax in TweenMax.getTweensOf(this)) {
				tween.resume();
			}
		}
	
		
		
		private function onStart():void
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.START));
		}
		
		private function onUpdate():void
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.UPDATE));
		}
		/*
		 * onCompleteListeners
		 */
		private function onCompleteScaleTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.SCALE_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onCompleteRotationTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.ROTATE_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onCompleteAlphaTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.FADE_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onCompleteHeightTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.HEIGHT_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onCompleteWidthTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.WIDTH_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onCompletePositionTween():void 
		{
			dispatchEvent(new TweenableComponentEvent(TweenableComponentEvent.MOVE_TO));
			dispatchEvent(new Event(Event.COMPLETE));
		}
		 
		/*
		 * Private Methods
		 */
		
		private function convertMillisecondsToSeconds(timeInMilliseconds:Number):Number {
			return timeInMilliseconds / 1000;
		}
		
		private function convertSecondsToMilliseconds(timeInSeconds:Number):Number {
			return timeInSeconds * 1000;
		}
	}
}