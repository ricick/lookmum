package com.lookmum.view{
	/**
	* Description here..
	* @author Default
	* @version 0.1
	*/

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import com.lookmum.view.Component;
	import com.lookmum.view.LabelButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name = "select", type = "flash.events.Event")]
	
	public class ComboBox  extends Component {

		private var _selectedIndex:Number;
		protected var buttonOpen:LabelButton;
		protected var _items:Array;
		private var mouseMoveListener:Function;
		private var mouseDownListener:Function;
		private var closeInt:Number;
		private var closeDelay:Number = 1000;
		private var timer:Timer;
		private var _isOpen:Boolean = false;
		private var itemRenderer:Class;
		private var holder:MovieClip;
		protected var itemButtons:Array;
		
		public function ComboBox(target:MovieClip) {
			super(target);
			//trace("target.buttonOpen : " + target.buttonOpen);
			buttonOpen = makeButtonOpen(target.buttonOpen);
			
			this.buttonOpen.enabled = true;
			this.buttonOpen.addEventListener(MouseEvent.MOUSE_UP,switchList);
			timer = new Timer(closeDelay,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, closeTimeOut);

			itemRenderer = ComboBoxItemRenderer;
		}
		
		protected function makeButtonOpen(clip:MovieClip):LabelButton
		{
			return new LabelButton(clip);
		}
		
		private function onMouseMove(event:MouseEvent):void{
			if(!doHitTest()){
				if(!timer.running){
					timer.reset();
					timer.start();
				}
			}else{
				timer.stop();
			}
		}
		public function setItemRenderer(renderer:Class):void{
			itemRenderer = renderer;
		}
		private function closeTimeOut(event:TimerEvent):void{
			timer.stop();
			this.close();
		}
		private function onMouseDown(event:MouseEvent):void{
			if(!doHitTest())this.close();
		}
		private function doHitTest():Boolean {
			// changed target.stage to root
			var hitThis:Boolean = this.target.hitTestPoint(target.stage.mouseX, target.stage.mouseY, true);
			trace("hitThis : " + hitThis);
			var hitHolder:Boolean = this.holder.hitTestPoint(holder.stage.mouseX, holder.stage.mouseY, true);
			trace("hitHolder : " + hitHolder);
			var hit:Boolean = (hitThis||hitHolder);
			return hit;
		}
		private function switchList(event:MouseEvent):void{
			if(_isOpen){
				close();
			}else{
				open();
			}
		}
		public function setItems(items:Array):void{
			this._items = items.slice();
			this.setSelectedIndex(0);
		}
		public function setSelectedIndex(index:Number):void{
			this._selectedIndex = index;
			this.updateView();
		}
		public function getSelectedIndex():Number{
			return this._selectedIndex;
		}
		public function getSelectedItem():String{
			return this._items[this._selectedIndex];
		}
		public function open():void{
			if (!this._items) return;
			this._isOpen = true;
			this.holder = new MovieClip()
			this.target.addChild(this.holder);
			this.holder.y = this.buttonOpen.y+this.buttonOpen.height+this.buttonOpen.y;
			this.holder.x = this.buttonOpen.x;
			
			// changed target.stage to root
			target.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			target.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			this.itemButtons = new Array();
			var space:Number = 0;
			for (var i:Number = 0; i < this._items.length; i++) {
				if (i == this._selectedIndex) continue;
				var button:LabelButton = getLabelButton(this.holder.addChild(new itemRenderer()) as MovieClip); 
				
				//var button:LabelButton = new LabelButton(this.holder.addChild(new itemRenderer()) as MovieClip);
				button.enabled = true;
				button.text = this._items[i];
				button.addEventListener(MouseEvent.MOUSE_UP,onItemSelect);
				button.y = space;
				this.itemButtons.push(button);
				space+=button.height;
				
			}
		}
		
		
		
		protected function getLabelButton(clip:MovieClip):LabelButton
		{
			return new LabelButton(clip);
		}
		public function close():void{
			this._isOpen = false;
			
			// changed target.stage to root
			target.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			target.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			timer.stop();
			for (var i:Number = 0; i < this.itemButtons.length; i++) {
				var button:LabelButton = this.itemButtons[i];
				button.destroy();
			}
			this.itemButtons = new Array();
			this.target.removeChild(holder);
		}
		private function onItemSelect(event:MouseEvent):void {
			var index:Number = 0;
			for (var i:int = 0; i < this.itemButtons.length; i++) {
				var button:LabelButton = this.itemButtons[i];
				if(button==event.target){
					index = i;
					if(index>=_selectedIndex)index++
					break;
				}
			}
			this._selectedIndex = index;
			this.dispatchEvent(new Event(Event.SELECT));
			this.close();
			this.updateView();
		}
		protected function updateView():void{
			this.buttonOpen.text = (this._items[this._selectedIndex]);
		}
		/*override protected function getInteractiveComponent():IInteractiveComponent
		{
			return buttonOpen;
		}*/
		/*
		public function enable() : void {
			this.buttonOpen.enable();
		}
		public function disable() : void {
			this.buttonOpen.disable();
		}
		//*/
	}
}