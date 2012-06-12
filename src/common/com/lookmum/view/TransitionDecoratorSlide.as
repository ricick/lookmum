package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TransitionDecoratorSlide extends TransitionerDecorator 
	{
		public var slideInX:Number = 10;
		public var slideOutX:Number = 10;
		public var slideInY:Number = 10;
		public var slideOutY:Number = 10;
		protected var cacheX:Number;
		protected var cacheY:Number;
		public function TransitionDecoratorSlide(target:MovieClip) 
		{
			super(target);
			cacheX = target.x;
			cacheY = target.y;
		}
		
		override public function transitionIn():void 
		{
			reset();
			if (!target.visible) target.visible = true;
			transitioning = true;
			//enabled = true;
			//mouseEnabled = true;
			//mouseChildren = true;
			target.alpha = minAlpha;
			cacheX = target.x;
			cacheY = target.y;
			target.x -= slideInX;
			target.y -= slideInY;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: maxAlpha,
				time: time,
				x: target.x + slideInX,
				y: target.y + slideInY,
				onComplete: onTransitionIn
			} );
		}
		
		override public function transitionOut():void 
		{
			reset();
			if (!target.visible) return onTransitionOut();
			transitioning = true;
			//enabled = false;
			//mouseEnabled = false;
			//mouseChildren = false;
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: minAlpha,
				time: time,
				x: target.x + slideOutX,
				y: target.y + slideOutY,
				onComplete:onTransitionOut
			} );
		}
		
		override public function reset():void 
		{
			if (transitioning) {
				Tweener.removeTweens(target);
				transitioning = false;
				target.x = cacheX;
				target.y = cacheY;
			}
		}
		
		override protected function onTransitionIn():void 
		{
			reset();
			_isTransitionedIn = true;
			onIn.dispatch();
		}
		
		override protected function onTransitionOut():void 
		{
			reset();
			target.visible = false;
			_isTransitionedIn = false;
			onOut.dispatch();
		}
		
		public function set slideX(value:Number):void
		{
			slideInX = value;
			slideOutX = value;
		}
		
		public function set slideY(value:Number):void
		{
			slideInY = value;
			slideOutY = value;
		}
		
	}

}