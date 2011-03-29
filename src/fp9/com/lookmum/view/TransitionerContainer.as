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
		
		private var transitionComponents:Array;
		private var _onIn:Signal;
		private var _onOut:Signal;
		private var _isTransitioning:Boolean;
		public function TransitionerContainer(target:MovieClip) 
		{
			super(target);
			_onIn = new Signal();
			_onOut = new Signal();
			_isTransitioning = false;
		}
		override protected function createChildren():void 
		{
			transitionComponents = new Array();
			super.createChildren();
		}
		protected function addTransitionItem(item:MovieClip):void {
			var transitioner:ITransitioner;
			if (item is ITransitioner) {
				transitioner = item as ITransitioner;
			}else {
				transitioner = getDefaultDecorator(item);
			}
			if (transitionComponents.indexOf(transitioner) > -1) return;
			transitioner.onIn.add(onItemTransitionIn);
			transitioner.onOut.add(onItemTransitionOut);
			transitionComponents.push(transitioner);
		}
		protected function getDefaultDecorator(item:MovieClip):ITransitioner {
			return new TransitionerDecorator(item);
		}
		protected function removeTransitionItem(item:MovieClip):void {
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
				transitioner.onIn.remove(onItemTransitionIn);
				transitioner.onOut.remove(onItemTransitionOut);
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
		private function onItemTransitionIn():void 
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				if (item.isTransitioning) return;
			}
			onTransitionIn();
		}
		private function onItemTransitionOut():void 
		{
			for each (var item:ITransitioner in transitionComponents) 
			{
				if (item.isTransitioning) return;
			}
			onTransitionOut();
		}
		public function transitionIn():void
		{
			_isTransitioning = true;
			if (!visible) visible = true;
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.transitionIn();
			}
			enabled = true;
		}
		
		public function transitionOut():void
		{
			_isTransitioning = true;
			enabled = false;
			if (transitionComponents.length == 0) onTransitionOut();
			for each (var item:ITransitioner in transitionComponents) 
			{
				item.transitionOut();
			}
		}
		
		protected function onTransitionIn():void
		{
			_isTransitioning = false;
			onIn.dispatch();
		}
		
		protected function onTransitionOut():void
		{
			_isTransitioning = false;
			if (visible) visible = false;
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
		
	}

}