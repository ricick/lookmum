package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import com.lookmum.view.Component;
	import com.lookmum.view.IComponent;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TransitionerDecorator extends Component implements ITransitioner
	{
		private var _onIn:Signal;
		private var _onOut:Signal;
		protected var transitioning:Boolean;
		protected var _isTranstionedIn:Boolean;
		protected var _isTranstionedOut:Boolean;
		private static const MIN_IN_TIME:Number = 1;
		private static const MAX_IN_TIME:Number = 2;
		private static const MIN_OUT_TIME:Number = 1;
		private static const MAX_OUT_TIME:Number = 1.5;
		public var minInTime:Number = MIN_IN_TIME;
		public var maxInTime:Number = MAX_IN_TIME;
		public var minOutTime:Number = MIN_OUT_TIME;
		public var maxOutTime:Number = MAX_OUT_TIME;
		private var _time:Number = 1;
		private var _delay:Number = 0;
		private var _minAlpha:Number = 0;
		private var _maxAlpha:Number = 1;
		public function TransitionerDecorator(target:MovieClip) 
		{
			super(target);
			onIn = new Signal();
			onOut = new Signal();
			transitioning = false;
			_isTranstionedIn = visible;
			_isTranstionedOut = !visible;
		}
		
		public function transitionIn():void 
		{
			reset();
			if (!target.visible) target.visible = true;
			transitioning = true;
			//enabled = true;
			//mouseEnabled = true;
			//mouseChildren = true;
			target.alpha = minAlpha;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: maxAlpha,
				time: time,
				onComplete: onTransitionIn
			} );
		}
		public function transitionOut():void 
		{
			reset();
			if (!target.visible) return onOut.dispatch();
			transitioning = true;
			//enabled = false;
			//mouseEnabled = false;
			//mouseChildren = false;
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: minAlpha,
				time: time,
				onComplete:onTransitionOut
			} );
		}
		public function reset():void 
		{
			if (transitioning) {
				Tweener.removeTweens(target);
				transitioning = false;
			}
		}
		
		protected function onTransitionIn():void
		{
			transitioning = false;
			_isTranstionedIn = true;
			_isTranstionedOut = false;
			onIn.dispatch();
		}
		
		protected function onTransitionOut():void
		{
			target.visible = false;
			transitioning = false;
			_isTranstionedOut = true;
			_isTranstionedIn = false;
			onOut.dispatch();
		}
		
		public function get onIn():Signal 
		{
			return _onIn;
		}
		
		public function set onIn(value:Signal):void 
		{
			_onIn = value;
		}
		
		public function get onOut():Signal 
		{
			return _onOut;
		}
		
		public function set onOut(value:Signal):void 
		{
			_onOut = value;
		}
		
		public function get time():Number 
		{
			return _time;
		}
		
		public function get isTransitioning():Boolean
		{
			return transitioning;
		}
		
		public function set time(value:Number):void 
		{
			_time = value;
			minInTime = time;
			maxInTime = time;
			minOutTime = time;
			maxOutTime = time;
		}
		
		public function get delay():Number { return _delay; }
		
		public function set delay(value:Number):void 
		{
			_delay = value;
		}
		
		public function get maxAlpha():Number { return _maxAlpha; }
		
		public function set maxAlpha(value:Number):void 
		{
			_maxAlpha = value;
		}
		
		public function get minAlpha():Number { return _minAlpha; }
		
		public function set minAlpha(value:Number):void 
		{
			_minAlpha = value;
		}
		
		override public function destroy():void 
		{
			onIn.removeAll();
			onOut.removeAll();
			super.destroy();
		}
		
		public function get isTranstionIn():Boolean 
		{
			return _isTranstionedIn;
		}
		
		public function get isTranstionOut():Boolean
		{
			return _isTranstionedOut;
		}
		
		
	}

}