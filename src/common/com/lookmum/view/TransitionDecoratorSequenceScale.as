package com.lookmum.view
{
	import caurina.transitions.Tweener;
	import com.lookmum.view.TransitionDecoratorScale;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Jacob
	 */
	public class TransitionDecoratorSequenceScale extends TransitionDecoratorScale
	{
		public var heightFirst:Boolean;
		public function TransitionDecoratorSequenceScale(target:MovieClip)
		{
			super(target);
		
		}
		override public function transitionIn():void 
		{
			reset();
			if (!target.visible) target.visible = true;
			transitioning = true;
			target.alpha = minAlpha;
			cacheWidth = target.width;
			cacheHeight = target.height;
			target.width = minWidth;
			target.height = minHeight;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			Tweener.addTween(target, { 
				delay: delay,
				alpha: maxAlpha,
				time: time/2,
				width: heightFirst?target.width:cacheWidth,
				height: !heightFirst?target.height:cacheHeight,
				onComplete: function():void {
					Tweener.addTween(target, { 
						time: time/2,
						width: !heightFirst?target.width:cacheWidth,
						height: heightFirst?target.height:cacheHeight,
						onComplete: onTransitionIn
					} );
				}
			} );
		}
		
		override public function transitionOut():void 
		{
			reset();
			if (!target.visible) return onTransitionOut();
			transitioning = true;
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			Tweener.addTween(target, { 
				delay: delay,
				time: time/2,
				width: heightFirst?target.width:minWidth,
				height: !heightFirst?target.height:minHeight,
				onComplete: function():void {
					Tweener.addTween(target, { 
						alpha: minAlpha,
						time: time/2,
						width: !heightFirst?target.width:minWidth,
						height: heightFirst?target.height:minHeight,
						onComplete: onTransitionOut
					} );
				}
			} );
		}
	
	}

}