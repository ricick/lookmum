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
		protected static const MIN_IN_TIME:Number = 1;
		protected static const MAX_IN_TIME:Number = 2;
		protected static const MIN_OUT_TIME:Number = 1;
		protected static const MAX_OUT_TIME:Number = 1.5;
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
			var time:Number = MIN_IN_TIME + (Math.random() * (MAX_IN_TIME-MIN_IN_TIME));
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
			var time:Number = MIN_OUT_TIME + (Math.random() * (MAX_OUT_TIME-MIN_OUT_TIME));
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
		override public function destroy():void 
		{
			out.removeAll();
			super.destroy();
		}
		
	}

}