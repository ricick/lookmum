package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class MovieComponent extends Component {
		
		private static const DEFAULT_DURATION:Number = 1;
		private static const DEFAULT_EASING:String = "linear";
		
		protected var _duration:Number = DEFAULT_DURATION;
		protected var _easing:String = DEFAULT_EASING;
		protected var _delay:Number = 0;
		
		protected var _callback:Function;
		protected var _args:Array;
		
		public function MovieComponent(target:MovieClip):void
		{
			super(target);
		}
		
		/*
		 * Getters and Setters
		 */
		
		public function get duration():Number 
		{
			return _duration;
		}
		
		public function set duration(value:Number):void
		{
			_duration = value;
		}
		
		public function set delay(value:Number):void
		{
			_delay = value;
		}
		
		public function get delay():Number
		{
			return _delay;
		}
		
		public function get easing():String
		{
			return _easing;
		}
		
		public function set easing(value:String):void
		{
			_easing = value;
		}
		
		public function get callback():Function { return _callback; }
		
		public function set callback(value:Function):void 
		{
			_callback = value;
		}
		
		/*
		 * Public Methods
		 */
		
		public function frameTo(endFrame:int, callback:Function = null):void {
			Tweener.addTween (target, { _frame:endFrame, delay:delay, time:duration, transition:easing, onUpdate:onUpdate, onComplete:onComplete, overwrite:true } );
			this.callback = callback;
		}
		
		public function frameToFrom(startFrame:int, endFrame:int, callback:Function = null):void {
			target.gotoAndStop(startFrame);
			Tweener.addTween (target, { _frame:endFrame, delay:delay, time:duration, transition:easing, onUpdate:onUpdate, onComplete:onComplete, overwrite:true } );
			this.callback = callback;
		}
		
		protected function onUpdate():void
		{
			trace(target.currentFrame);
		}
		
		protected function onComplete():void
		{
			if (callback != null)
			{
				callback.call(this);
				callback = null;
			}
		}
		
		public function stopTween():void {
			Tweener.removeAllTweens();
		}
		
		public function pauseTween():void {
			Tweener.pauseAllTweens();
		}
		
		public function resumeTween():void {
			Tweener.resumeAllTweens();
		}
	}
}