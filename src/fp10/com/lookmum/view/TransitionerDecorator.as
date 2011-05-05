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
		private static const MIN_IN_TIME:Number = 1;
		private static const MAX_IN_TIME:Number = 2;
		private static const MIN_OUT_TIME:Number = 1;
		private static const MAX_OUT_TIME:Number = 1.5;
		public var minInTime:Number = MIN_IN_TIME;
		public var maxInTime:Number = MAX_IN_TIME;
		public var minOutTime:Number = MIN_OUT_TIME;
		public var maxOutTime:Number = MAX_OUT_TIME;
		private var _time:Number;
		public function TransitionerDecorator(target:MovieClip) 
		{
			super(target);
			onIn = new Signal();
			onOut = new Signal();
			transitioning = false;
		}
		
		public function transitionIn():void 
		{
			reset();
			transitioning = true;
			target.alpha = 0;
			target.visible = true;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				alpha: 1,
				time: time,
				onComplete: function():void {
					transitioning = false;
					onIn.dispatch();
				}
			} );
		}
		public function transitionOut():void 
		{
			reset();
			transitioning = true;
			if (!target.visible) return onOut.dispatch();
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			Tweener.addTween(target, { 
				alpha:0,
				time: time,
				onComplete:function():void {
					target.visible = false;
					transitioning = false;
					onOut.dispatch();
				}
			} );
		}
		protected function reset():void 
		{
			if (transitioning) {
				transitioning = false;
				Tweener.removeTweens(target);
			}
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
		override public function destroy():void 
		{
			onIn.removeAll();
			onOut.removeAll();
			super.destroy();
		}
		
	}

}