package com.lookmum.view{
	/**
	* Description here..
	* @author Default
	* @version 0.1
	*/
	import com.lookmum.events.DragEvent;
	import flash.events.MouseEvent;
	import com.lookmum.view.Component;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.VolumeSlider;
	import flash.display.MovieClip;
	public class VolumeSliderMute  extends Component implements ILevelComponent{

		private var className:String = 'volumeSliderMute';
		private var volumeSlider:VolumeSlider;
		private var buttonMute:ToggleButton;
		private var _level:Number;
		public function VolumeSliderMute(target:MovieClip) {
			super(target);
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			this.buttonMute = new ToggleButton(this.target.getChildByName('buttonMute') as MovieClip);
			this.buttonMute.addEventListener(MouseEvent.CLICK,onReleaseButtonMute);
			this.volumeSlider = new VolumeSlider(this.target.getChildByName('volumeSlider') as MovieClip);
			this.volumeSlider.addEventListener(DragEvent.DRAG,onDragSlider);
		}
		public function onReleaseButtonMute(event:MouseEvent):void{
			this.setMute(this.buttonMute.toggle);
		}
		public function setMute(mute:Boolean):void{
			this.buttonMute.toggle = (mute);
			if(mute){
				_level = this.volumeSlider.level;
				this.volumeSlider.level = (0);
			}else{
				this.volumeSlider.level = (_level);
				this.buttonMute.toggle = (this._level == 0);
			}
		}
		public function onDragSlider(event:DragEvent):void{
			this._level = this.volumeSlider.level;
			this.buttonMute.toggle = (this._level == 0);
		}
		public function set level(value:Number):void {
			if(value>1)value = 1;
			if(value<0)value = 0;
			this.volumeSlider.level = (value);
		}
		public function get level():Number {
			return  this.volumeSlider.level;
		}
		override public function get enabled():Boolean { return buttonMute.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			this.volumeSlider.enabled = value;
			this.buttonMute.enabled = value;
		}
		override public function get useHandCursor():Boolean { return volumeSlider.useHandCursor; }
		
		override public function set useHandCursor(value:Boolean):void 
		{
			volumeSlider.useHandCursor = value;
			buttonMute.useHandCursor = value;
		}
		override public function get tabEnabled():Boolean { return volumeSlider.tabEnabled; }
		
		override public function set tabEnabled(value:Boolean):void 
		{
			volumeSlider.tabEnabled = value;
			buttonMute.tabEnabled = value;
		}
		override public function get tabIndex():int { return buttonMute.tabIndex; }
		
		override public function set tabIndex(value:int):void 
		{
			buttonMute.tabIndex = value;
		}
		override public function setFocus():void {
			this.volumeSlider.setFocus();
		}
		override public function getIsFocus():Boolean {
			return this.volumeSlider.getIsFocus();
		}
	}
}