package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Theeban
	 */
	public class TransitionerSequencer extends TransitionerContainer 
	{
		public var sequenceIn:Boolean = true;
		public var sequenceOut:Boolean = true;
		public var sequenceDelay:Number = -1;
		public function TransitionerSequencer(target:MovieClip) 
		{
			super(target);
		}
		
		override public function transitionIn():void
		{
			if (!sequenceIn) {
				super.transitionIn();
				return;
			}
			reset();
			if (!visible) visible = true;
			_isTransitioning = true;
			enabled = true;
			mouseEnabled = true;
			mouseChildren = true;
			if (transitionComponents.length == 0) {
				onTransitionIn();
				return;
			}
			for (var i:int = 0; i < transitionComponents.length; i++)
			{
				var item:ITransitioner = transitionComponents[i];
				item.visible = false;
				if(sequenceDelay < 0){
					if (i < transitionComponents.length - 1)
					{
						var nextItem:ITransitioner = transitionComponents[i + 1];
						item.onIn.add(nextItem.transitionIn);
					}
					else
					{
						item.onIn.add(onItemTransitionIn);
					}
				}else {
					var delay:Number = sequenceDelay * i;
					if(delay == 0){
						item.transitionIn();
					}else {
						Tweener.addTween(item, {onComplete:function():void {
							this.transitionIn()
						}, delay:delay } );
					}
					item.onIn.add(onItemTransitionIn);
				}
			}
			if(sequenceDelay < 0){
				item = transitionComponents[0];
				item.transitionIn();
			}
		}
		
		override public function transitionOut():void
		{
			if (!sequenceOut) {
				super.transitionOut();
				return;
			}
			reset();
			if (!visible) return onOut.dispatch();
				
			_isTransitioning = true;
			enabled = false;
			mouseEnabled = false;
			mouseChildren = false;
			if (transitionComponents.length == 0) {
				onTransitionOut();
				return;
			}
			
			for (var i:int = transitionComponents.length - 1; i >= 0; i--)
			{
				var item:ITransitioner = transitionComponents[i];
				if(sequenceDelay < 0){
					if (i > 0)
					{
						var prevItem:ITransitioner = transitionComponents[i - 1];
						item.onOut.add(prevItem.transitionOut);
					}
					else
					{
						item.onOut.add(onItemTransitionOut);
					}
				}else {
					var delay:Number = sequenceDelay * i;
					if(delay == 0){
						item.transitionOut();
					}else {
						Tweener.addTween(item, {onComplete:function():void {
							this.transitionOut()
						}, delay:delay } );
					}
					item.onOut.add(onItemTransitionOut);
				}
			}
			item = transitionComponents[transitionComponents.length - 1];
			item.transitionOut();
		}
		
		override protected function reset():void
		{
			if (isTransitioning)
			{		
				var item:ITransitioner;
				
				if (enabled)
				{
					for (var i:int = 0; i < transitionComponents.length; i++)
					{
						item = transitionComponents[i];
						if (i < transitionComponents.length - 1)
						{
							var nextItem:ITransitioner = transitionComponents[i + 1];
							item.onIn.remove(nextItem.transitionIn);
						}
						else
						{
							item.onIn.remove(onItemTransitionIn);
						}
					}
				}
				else
				{
					for (i = transitionComponents.length - 1; i >= 0; i--)
					{
						item = transitionComponents[i];
						if (i > 0)
						{
							var prevItem:ITransitioner = transitionComponents[i - 1];
							item.onOut.remove(prevItem.transitionOut);
						}
						else
						{
							item.onOut.remove(onItemTransitionOut);
						}
					}
				}
				_isTransitioning = false;
			}
		}
		
		override protected function onTransitionIn():void
		{
			for (var i:int = 0; i < transitionComponents.length; i++)
			{
				var item:ITransitioner = transitionComponents[i];
				if (i < transitionComponents.length - 1)
				{
					var nextItem:ITransitioner = transitionComponents[i + 1];
					item.onIn.remove(nextItem.transitionIn);
				}
				else
				{
					item.onIn.remove(onItemTransitionIn);
				}
			}
			_isTransitioning = false;
			onIn.dispatch();
		}
		
		override protected function onTransitionOut():void
		{
			for (var i:int = transitionComponents.length - 1; i >= 0; i--)
			{
				var item:ITransitioner = transitionComponents[i];
				if (i > 0)
				{
					var prevItem:ITransitioner = transitionComponents[i - 1];
					item.onOut.remove(prevItem.transitionOut);
				}
				else
				{
					item.onOut.remove(onItemTransitionOut);
				}
			}
			_isTransitioning = false;
			if (visible) visible = false;
			onOut.dispatch();
		}
	}

}