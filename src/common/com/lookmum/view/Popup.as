package com.lookmum.view {

	import com.lookmum.events.PopupEvent;
	import com.lookmum.util.ModalManager;
	import com.lookmum.view.Component;
	import com.lookmum.view.Button;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	[Event(name = "close", type = "com.lookmum.events.PopupEvent")]
	
	public class Popup extends Component {
		
		protected var buttonClose:Button;
		protected var _modal:Boolean = true;
		public function Popup(target:MovieClip){
			super(target);
			visible = false;
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			this.buttonClose = getButtonClose();
			this.buttonClose.addEventListener(MouseEvent.CLICK, this.onReleaseButtonClose);
		}
		protected function getButtonClose():Button{
			return new Button(this.target.buttonClose);
		}
		protected function onReleaseButtonClose(event:MouseEvent):void {
			this.visible = false;
			this.dispatchEvent(new PopupEvent(PopupEvent.CLOSE));
		}
		override public function get visible():Boolean { return super.visible; }
		
		override public function set visible(value:Boolean):void 
		{
			if (value) {
				if (_modal) ModalManager.getInstance().deactivate();
				this.buttonClose.enabled = true;
			}else {
				this.buttonClose.enabled = false;
				if (_modal) ModalManager.getInstance().activate();
			}
			super.visible = value;
		}
		
		public function getModal():Boolean { return _modal; }
		
		public function setModal(value:Boolean):void 
		{
			_modal = value;
		}
		
	}

}