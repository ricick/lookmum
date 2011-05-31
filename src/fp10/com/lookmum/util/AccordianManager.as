package com.lookmum.util 
{
	import com.lookmum.view.IToggle;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Theeban
	 */
	public class AccordianManager extends EventDispatcher
	{
		private var accordians:Array;
		private var radioGroupManager:RadioGroupManager;
		private var _enabled:Boolean;
		public function AccordianManager() 
		{
			accordians = new Array();
			radioGroupManager = new RadioGroupManager();
			radioGroupManager.addEventListener(Event.SELECT, onSelectAccordian);
		}
		public function clear():void
		{
			accordians = new Array();
			radioGroupManager.clear();
		}
		public function addAccordian(accordian:IToggle):void
		{
			if (accordians.indexOf(accordian) >= 0) return ;
			accordians.push(accordian);
			radioGroupManager.addButton(accordian);
			arrangeComponents();
		}
		public function removeAccordian(accordian:IToggle):void
		{
			if (accordians.indexOf(accordian) < 0) return ;
			accordians.splice(accordians.indexOf(accordian), 1);
			radioGroupManager.removeButton(accordian);
			arrangeComponents();
		}
		public function get selectedIndex():int
		{
			return radioGroupManager.selectedIndex;
		}
		public function set selectedIndex(value:int):void
		{
			radioGroupManager.selectedIndex = value;
		}
		public function get selectedAccordian():IToggle
		{
			return radioGroupManager.selectedButton as IToggle;
		}
		public function set selectedAccordian(value:IToggle):void
		{
			radioGroupManager.selectedButton = value;
		}
		public function get enabled():Boolean { return radioGroupManager.enabled; }
		public function set enabled(value:Boolean):void 
		{
			radioGroupManager.enabled = value;
		}
		// override this function if you want more to animate open/close of accordian
		protected function onSelectAccordian(e:Event = null):void 
		{
			arrangeComponents();
			dispatchEvent(e.clone());
		}
		protected function arrangeComponents():void
		{
			var py:Number = 0;
			for each (var accordian:IToggle in accordians)
			{
				accordian.y = py;
				py += accordian.height;
			}
		}
	}

}