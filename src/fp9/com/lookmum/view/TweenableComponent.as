package com.lookmum.view {
	
	import com.eclecticdesignstudio.motion.Actuate;
	import com.eclecticdesignstudio.motion.easing.IEasing;
	import com.eclecticdesignstudio.motion.easing.Linear;
	import com.lookmum.events.TweenableComponentEvent;
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
		private static const DEFAULT_EASING:IEasing = Linear.easeNone;
		
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
		private var _easing:IEasing;
		private var _positionEasing:IEasing;
		private var _widthEasing:IEasing;
		private var _heightEasing:IEasing;
		private var _alphaEasing:IEasing;
		private var _rotationEasing:IEasing;
		private var _scaleEasing:IEasing;			
		private var _scaleXEasing:IEasing;			
		private var _scaleYEasing:IEasing;
		//delays
		private var _delay:Number = 0;
		
		public function TweenableComponent(target:MovieClip) {
			super(target);
			duration = DEFAULT_DURATION;
			easing = DEFAULT_EASING
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
		public function get easing():IEasing {
			return _easing;
		}
		
		public function set easing(easingIEasing:IEasing):void {
			_easing = easingIEasing;
			_positionEasing = _easing;
			_widthEasing = _easing;
			_heightEasing = _easing;
			_alphaEasing = _easing;
			_rotationEasing = _easing;
			_scaleEasing = _easing;			
			_scaleXEasing = _easing;			
			_scaleYEasing = _easing;
		}
		public function set easingPosition(easingIEasing:IEasing):void {
			_positionEasing = easingIEasing;
		}
		
		public function set easingWidth(easingIEasing:IEasing):void {
			_widthEasing = easingIEasing;
		}
		
		public function set easingHeight(easingIEasing:IEasing):void {
			_heightEasing = easingIEasing;
		}
		
		public function set easingAlpha(easingIEasing:IEasing):void {
			_alphaEasing = easingIEasing;
		}
		
		public function set easingRotation(easingIEasing:IEasing):void {
			_rotationEasing = easingIEasing;
		}
		
		public function set easingScale(easingIEasing:IEasing):void {
			_scaleEasing = easingIEasing;		
		}
		
		public function set easingXScale(easingIEasing:IEasing):void {
			_scaleXEasing = easingIEasing;		
		}
		
		public function set easingYScale(easingIEasing:IEasing):void {
			_scaleYEasing = easingIEasing;		
		}
		/*
		 * Public Methods
		 */
		
		public function widthTo(newWidth:Number):void {
			Actuate.tween (this, _widthDuration, { width:newWidth } ).onUpdate(onUpdate).onComplete(onCompleteWidthTween).ease(_widthEasing).delay(_delay);
			onStart();
		}
		
		
		public function heightTo(newHeight:Number):void {
			Actuate.tween (this, _heightDuration, { height:newHeight } ).onUpdate(onUpdate).onComplete(onCompleteHeightTween).ease(_heightEasing).delay(_delay);
			onStart();
		}
		
		public function rotateTo(newRotation:Number):void {
			Actuate.tween (this, _rotationDuration, { rotation:newRotation } ).onUpdate(onUpdate).onComplete(onCompleteRotationTween).ease(_rotationEasing).delay(_delay);
			onStart();
		}
		
		public function alphaTo(newAlpha:Number):void {
			Actuate.tween (this, _alphaDuration, { alpha:newAlpha } ).onUpdate(onUpdate).onComplete(onCompleteAlphaTween).ease(_alphaEasing).delay(_delay);
			onStart();
		}
		
		public function moveTo(newX:Number, newY:Number):void {
			Actuate.tween (this, _positionDuration, { x:newX, y:newY } ).onUpdate(onUpdate).onComplete(onCompletePositionTween).ease(_positionEasing).delay(_delay);
			onStart();
		}
		
		public function scaleTo(newScale:Number):void {
			Actuate.tween (this, _scaleDuration, { scaleX:newScale, scaleY:newScale } ).onUpdate(onUpdate).onComplete(onCompleteScaleTween).ease(_scaleEasing).delay(_delay);
			onStart();
		}
		
		public function scaleXTo(newScale:Number):void {
			Actuate.tween (this, _scaleXDuration, { scaleX:newScale } ).onUpdate(onUpdate).onComplete(onCompleteScaleTween).ease(_scaleEasing).delay(_delay);
			onStart();
		}
		
		public function scaleYTo(newScale:Number):void {
			Actuate.tween (this, _scaleYDuration, { scaleY:newScale } ).onUpdate(onUpdate).onComplete(onCompleteScaleTween).ease(_scaleEasing).delay(_delay);
			onStart();
		}
		
		public function stopTween():void {
			Actuate.stop(this);
		}
		
		public function pauseTween():void {
			Actuate.pause(this);
		}
		
		public function resumeTween():void {
			Actuate.resume(this);
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