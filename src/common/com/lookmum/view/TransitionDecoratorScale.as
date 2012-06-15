package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TransitionDecoratorScale extends TransitionerDecorator 
	{
		public var minWidth:Number = 10;
		public var minHeight:Number = 10;
		protected var cacheWidth:Number;
		protected var cacheHeight:Number;
		public function TransitionDecoratorScale(target:MovieClip) 
		{
			super(target);
			cacheWidth = target.width;
			cacheHeight = target.height;
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
			cacheWidth = target.width;
			cacheHeight = target.height;
			target.width = minWidth;
			target.height = minHeight;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: maxAlpha,
				time: time,
				width: cacheWidth,
				height: cacheHeight,
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
				width: minWidth,
				height: minHeight,
				onComplete:onTransitionOut
			} );
		}
		
		override public function reset():void 
		{
			if (transitioning) {
				Tweener.removeTweens(target);
				transitioning = false;
				target.width = cacheWidth;
				target.height = cacheHeight;
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
		
	}

}