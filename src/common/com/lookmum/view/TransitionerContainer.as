package com.lookmum.view 
{
	import com.lookmum.view.Component;
	import flash.display.MovieClip;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TransitionerContainer extends Component implements ITransitioner
	{
		
		protected var transitionComponents:Array;
		private var _onIn:Signal = new Signal();
		private var _onOut:Signal = new Signal();
		protected var _isTransitioning:Boolean = false;
		protected var _isTranstionIn:Boolean = false;
		protected var _isTranstionOut:Boolean = false;
		public function TransitionerContainer(target:MovieClip) 
		{
			super(target);
		}
		override protected function createChildren():void 
		{
			transitionComponents = new Array();
			super.createChildren();
		}
		public function addTransitionItem(item:MovieClip):void {
			var transitioner:ITransitioner;
			if (item is ITransitioner) {
				transitioner = item as ITransitioner;
			}else {
				transitioner = getDefaultDecorator(item);
			}
			if (transitionComponents.indexOf(transitioner) > -1) return;
			transitionComponents.push(transitioner);
		}
		protected function getDefaultDecorator(item:MovieClip):ITransitioner {
			return new TransitionerDecorator(item);
		}
		public function removeTransitionItem(item:MovieClip):void {
			var transitioner:ITransitioner;
			for each (var itemCheck:ITransitioner in transitionComponents) 
			{
				if (itemCheck is TransitionerDecorator) {
					var itemCheckCast:TransitionerDecorator = itemCheck as TransitionerDecorator;
					if (item == itemCheckCast.target) {
						transitioner = itemCheckCast;
						break;
					}
				}else {
					if (item == itemCheck) {
						transitioner = itemCheck;
						break;
					}
				}
			}
			if (transitioner) {
				if (transitionComponents.indexOf(transitioner) > -1) return;
				
				
				transitionComponents.splice(transitionComponents.indexOf(transitioner),1);
			}
		}
		public function getTransitioner(item:MovieClip):ITransitioner{
			for each (var itemCheck:ITransitioner in transitionComponents) 
			{
				if (itemCheck is TransitionerDecorator) {
					var itemCheckCast:TransitionerDecorator = itemCheck as TransitionerDecorator;
					if (item == itemCheckCast.target) {
						return itemCheckCast;
					}
				}else {
					if (item == itemCheck) {
						return itemCheck;
					}
				}
			}
			return null;
		}
		protected function onItemTransitionIn():void 
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				if (!item.isTranstionIn) return;
			}
			onTransitionIn();
		}
		protected function onItemTransitionOut():void 
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				if (!item.isTranstionOut) return;
			}
			onTransitionOut();
		}
		public function transitionIn():void
		{
			reset();
			if (!visible) visible = true;
			_isTransitioning = true;
			enabled = true;
			mouseEnabled = true;
			mouseChildren = true;
			if (transitionComponents.length == 0) onTransitionIn();
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.onIn.add(onItemTransitionIn);
				item.transitionIn();
			}
		}
		
		public function transitionOut():void
		{
			reset();
			if (!visible) return onOut.dispatch();
			_isTransitioning = true;
			enabled = false;
			mouseEnabled = false;
			mouseChildren = false;
			if (transitionComponents.length == 0) onTransitionOut();
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.onOut.add(onItemTransitionOut);
				item.transitionOut();
			}
		}
		
		public function reset():void
		{
			if (isTransitioning)
			{		
				for each (var item:ITransitioner in transitionComponents) 
				{
					item.reset();
					if (enabled)
						item.onIn.remove(onItemTransitionIn);
					else
						item.onOut.remove(onItemTransitionOut);
				}
				_isTransitioning = false;
			}
		}
		
		protected function onTransitionIn():void
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.onIn.remove(onItemTransitionIn);
			}
			_isTransitioning = false;
			_isTranstionIn = true;
			_isTranstionOut = false;
			onIn.dispatch();
		}
		
		protected function onTransitionOut():void
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.onOut.remove(onItemTransitionOut);
			}
			_isTransitioning = false;
			if (visible) visible = false;
			_isTranstionIn = false;
			_isTranstionOut = true;
			onOut.dispatch();
		}
		
		public function getOut():Boolean 
		{
			return !visible;
		}
		
		public function get onIn():Signal 
		{
			return _onIn;
		}
		
		public function get onOut():Signal 
		{
			return _onOut;
		}
		
		public function get isTransitioning():Boolean
		{
			return _isTransitioning;
		}
		
		public function get isTranstionIn():Boolean 
		{
			return _isTranstionIn;
		}
		
		public function get isTranstionOut():Boolean
		{
			return _isTranstionOut;
		}
		
	}

}