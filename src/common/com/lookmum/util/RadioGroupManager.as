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
		private var _selectedIndex:int = -1;
		private var _selectedButton:IToggle;
		public function RadioGroupManager() {
			buttons = new Array();
		}
		public function clear():void {
			for each (var button:IToggle in buttons)
				button.removeEventListener(MouseEvent.CLICK, onReleaseButton);
			buttons = new Array();
			_selectedIndex = -1;
			selectedButton = null;
		}
		public function addButton(button:IToggle):void {
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
					if (i == selectedIndex ) {
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
			var index:Number = -1;
			var i:int;
			for (var j:int = 0; j < buttons.length; j++) {
				var button:IToggle = buttons[j];
				if(button==event.target){
					index = j;
					break;
				}
			}
			selectedIndex = index;
			if (selectedButton) {
				selectedButton.toggle = (false);
				selectedButton.enabled = true;
				selectedButton.tabEnabled = true;
			}
			selectedButton = event.target as IToggle;
			selectedButton.enabled = false;
			selectedButton.tabEnabled = false;
			selectedButton.toggle = (true);
			dispatchEvent(new Event(Event.SELECT));
		}
		public function set selectedIndex(index:Number):void {
			//set to -1 if you want nothing selected
			if(index>buttons.length-1)index = buttons.length-1;
			_selectedIndex = index;
			if (_selectedButton) {
				_selectedButton.toggle = (false);
				_selectedButton.enabled = true;
				_selectedButton.tabEnabled = true;
			}
			if (index != -1)
			{
				_selectedButton = buttons[index];
				_selectedButton.toggle = (true);
				_selectedButton.enabled = false;
				_selectedButton.tabEnabled = false;
			}
			else {
				_selectedButton = null;
			}
			return;
		}
		public function get selectedIndex():Number{
			return _selectedIndex;
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
					child.tabEnabled = true;
				}
			}else {
				for each(child in buttons) 
				{
					child.enabled = false;
					child.tabEnabled = false;
				}
			}
		}
		
		public function get selectedButton():IToggle { return _selectedButton; }
		
		public function set selectedButton(value:IToggle):void 
		{
			for (var i:int = 0; i < buttons.length; i++)
			{
				if (buttons[i] == value)
				{
					selectedIndex = i;
					return ;
				}
			}
			selectedIndex = -1;
		}
	}
}