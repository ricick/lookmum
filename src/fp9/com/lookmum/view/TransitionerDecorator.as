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
		private var _out:Signal;
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
			out = new Signal();
		}
		
		public function transitionIn():void 
		{
			reset();
			transitioning = true;
			target.alpha = 0;
			var time:Number = MIN_IN_TIME + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				alpha: 1,
				time: time,
				onComplete: function():void {
					transitioning = false;
				}
			} );
		}
		public function transitionOut():void 
		{
			reset();
			transitioning = true;
			if (!target.visible) return out.dispatch();
			var time:Number = MIN_OUT_TIME + (Math.random() * (maxOutTime-minOutTime));
			Tweener.addTween(target, { 
				alpha:0, 
				time: time,
				onComplete:function():void {
					target.visible = false;
					out.dispatch();
					transitioning = false;
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
		
		public function get out():Signal 
		{
			return _out;
		}
		
		public function set out(value:Signal):void 
		{
			_out = value;
		}
		
		public function get time():Number 
		{
			return _time;
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
			out.removeAll();
			super.destroy();
		}
		
	}

}