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
		private var cacheX:Number;
		private var cacheY:Number;
		private static const MAX_X_VAR:Number = 200;
		private static const MAX_Y_VAR:Number = 200;
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
			cacheX = target.x;
			cacheY = target.y;
			var vert:Boolean = Math.random() > 0.5;
			if(vert){
				target.y += (Math.random() * MAX_Y_VAR) - (MAX_Y_VAR / 2);
			}else{
				target.x += (Math.random() * MAX_X_VAR) - (MAX_X_VAR / 2);
			}
			Tweener.addTween(target, { 
				x:cacheX,
				y:cacheY,
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
			cacheX = target.x;
			cacheY = target.y;
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			var x:Number = target.x;
			var y:Number = target.y;
			var vert:Boolean = Math.random() > 0.5;
			if(vert){
				y += (Math.random() * MAX_Y_VAR) - (MAX_Y_VAR / 2);
			}else{
				x += (Math.random() * MAX_X_VAR) - (MAX_X_VAR / 2);
			}
			Tweener.addTween(target, { 
				alpha:0,
				x:x,
				y:y,
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
				target.x = cacheX;
				target.y = cacheY;
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