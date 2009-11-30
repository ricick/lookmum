package com.lookmum.util{
	import com.lookmum.view.IToggle;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	* ...
	* @author Default
	* @version 0.1
	*/
	[Event(name = "select", type = "flash.events.Event")]
	
	public class RadioGroupManager extends EventDispatcher {

		private var buttons:Array;
		private var selectedIndex:int = -1;
		private var selectedButton:IToggle;
		public function RadioGroupManager() {
			buttons = new Array();
		}
		public function addButton(button:IToggle):void{
			for (var i:int = 0; i < buttons.length; i++) {
				var compareButton:IToggle = buttons[i];
				if(compareButton==button){
					return;
				}
			}
			button.addEventListener(MouseEvent.CLICK,onReleaseButton);
			buttons.push(button);
		}
		public function removeButton(button:IToggle):void
		{
			for (var i:int = 0; i < buttons.length; i++) {
				var compareButton:IToggle = buttons[i];
				if (compareButton == button) {
					button.removeEventListener(MouseEvent.CLICK, onReleaseButton);
					buttons.splice(i, 1);
					if (i == selectedIndex ){
						selectedButton = null;
						selectedIndex = -1;
					}
					return;
				}
			}
		}
		
		private function onReleaseButton(event:MouseEvent):void {
			//PHIL: same as set selected index, but clicked button takes care of its own toggle state
			//setSelectedIndex(index);
			var index:Number;
			var i:int;
			for (var j:int = 0; j < buttons.length; j++) {
				var button:IToggle = buttons[j];
				if(button==event.target){
					index = j;
					break;
				}
			}
			selectedIndex = index;
			if(selectedButton){
				selectedButton.toggle = (false);
				selectedButton.enabled = true;
			}
			selectedButton = event.target as IToggle;
			selectedButton.enabled = false;
			selectedButton.toggle = (true);
			dispatchEvent(new Event(Event.SELECT));
		}
		public function setSelectedIndex(index:Number):void {
			//set to -1 if you want nothing selected
			if(index>buttons.length-1)index = buttons.length-1;
			selectedIndex = index;
			if(selectedButton){
				selectedButton.toggle = (false);
				selectedButton.enabled = true;
			}
			if (index != -1)
			{
				selectedButton = buttons[index];
				selectedButton.toggle = (true);
				selectedButton.enabled = false;
			}
			else {
				selectedButton = null;
			}
			return;
		}
		public function getSelectedIndex():Number{
			return selectedIndex;
		}
		private var _enabled:Boolean
		public function get enabled():Boolean { return _enabled; }
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			var child:MovieClip;
			if (value) {
				for each(child in buttons) 
				{
					child.enabled = true;
				}
			}else {
				for each(child in buttons) 
				{
					child.enabled = false;
				}
			}
		}
	}
}