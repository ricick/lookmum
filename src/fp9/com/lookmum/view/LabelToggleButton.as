package com.lookmum.view 
{
	import com.lookmum.view.LabelButton;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class LabelToggleButton extends LabelButton implements IToggle
	{
		
		protected const FRAME_ROLL_OVER_TOGGLE:String = 'rollOverToggle';
		protected const FRAME_ROLL_OUT_TOGGLE:String = 'rollOutToggle';
		protected const FRAME_PRESS_TOGGLE:String = 'pressToggle';
		protected const FRAME_DISABLE_TOGGLE:String = 'disableToggle';
		protected var _toggle:Boolean = false;
		private var _textFormatRollOverToggle:TextFormat;
		private var _textFormatRollOutToggle:TextFormat;
		private var _textFormatPressToggle:TextFormat;
		private var _textFormatDisableToggle:TextFormat;
		public function LabelToggleButton(target:MovieClip) 
		{
			super(target);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		protected function onClick(event:MouseEvent):void {
			toggle = (!_toggle);
		}
		public function get toggle():Boolean{
			return _toggle;
		}
		public function set toggle(toggle:Boolean):void {
			_toggle = toggle;
			onRollOut(new MouseEvent(MouseEvent.CLICK));
		}
		override protected function onMouseUp(e:MouseEvent):void 
		{
			if (!enabled) return;
			
			var out:Boolean = isMouseOutside;
			super.onMouseUp(e);
			
			if (toggle) {
				try {
					if (out)
					{
						target.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
					}
					else
					{
						target.gotoAndStop(FRAME_ROLL_OVER_TOGGLE);
					}
				} catch (e:Error) {
					//trace(e);
				}
				if (bg)
				{
					if (out)
					{
						try {
							bg.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
						} catch (e:Error) {
							//trace(e);
						}
					}
					else
					{
						try {
							bg.gotoAndStop(FRAME_ROLL_OVER_TOGGLE);
						} catch (e:Error) {
							//trace(e);
						}
					}
				}
				if (_textFormatRollOutToggle) currentTextFormat = (_textFormatRollOutToggle);
				arrangeComponents();
			}
		}
		override protected function onMouseDown(e:MouseEvent):void 
		{
			if (!enabled) return;
			
			super.onMouseDown(e);
			
			if (toggle) {
				try {
					target.gotoAndStop(FRAME_PRESS_TOGGLE);
				} catch (e:Error) {
					//trace(e);
				}
				if (bg) {
					try {
						bg.gotoAndStop(FRAME_PRESS_TOGGLE);
					} catch (e:Error) {
						//trace(e);
					}
				}
				if (_textFormatPressToggle) currentTextFormat = (_textFormatPressToggle);
				arrangeComponents();
			}
		}
		override protected function onRollOver(e:MouseEvent):void 
		{
			super.onRollOver(e);
			if (!enabled) return;
			if (toggle) {
				try {
					target.gotoAndStop(FRAME_ROLL_OVER_TOGGLE);
				} catch (e:Error) {
					//trace(e);
				}
				if (bg) {
					try {
						bg.gotoAndStop(FRAME_ROLL_OVER_TOGGLE);
					} catch (e:Error) {
						//trace(e);
					}
				}
				if (_textFormatRollOverToggle) currentTextFormat = (_textFormatRollOverToggle);
				arrangeComponents();
			}
		}
		override protected function onRollOut(e:MouseEvent):void 
		{
			if (!enabled) return;
			
			super.onRollOut(e);
			
			if (toggle) {
				try {
					target.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
				} catch (e:Error) {
					//trace(e);
				}
				if (bg) {
					try {
						bg.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
					} catch (e:Error) {
						//trace(e);
					}
				}
				if (_textFormatRollOutToggle) currentTextFormat = (_textFormatRollOutToggle);
				arrangeComponents();
			}
		}
		override protected function doEnable():void 
		{
			super.doEnable();
			if (toggle) {
				try {
					target.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
				} catch (e:Error) {
					//trace(e);
				}
				if (bg) {
					try {
						bg.gotoAndStop(FRAME_ROLL_OUT_TOGGLE);
					} catch (e:Error) {
						//trace(e);
					}
				}
				if (_textFormatRollOutToggle) currentTextFormat = (_textFormatRollOutToggle);
				arrangeComponents();
			}
		}
		override protected function doDisable():void 
		{
			super.doDisable();
			if (toggle) {
				try {
					target.gotoAndStop(FRAME_DISABLE_TOGGLE);
				} catch (e:Error) {
					//trace(e);
				}
				if (bg) {
					try {
						bg.gotoAndStop(FRAME_DISABLE_TOGGLE);
					} catch (e:Error) {
						//trace(e);
					}
				}
				if (_textFormatDisableToggle) currentTextFormat = (_textFormatDisableToggle);
				arrangeComponents();
			}
		}
		//text format setters
		
		public function set textFormatRollOverToggle(value:TextFormat):void 
		{
			_textFormatRollOverToggle = value;
		}
		
		public function set textFormatRollOutToggle(value:TextFormat):void 
		{
			_textFormatRollOutToggle = value;
		}
		
		public function set textFormatPressToggle(value:TextFormat):void 
		{
			_textFormatPressToggle = value;
		}
		
		public function set textFormatDisableToggle(value:TextFormat):void 
		{
			_textFormatDisableToggle = value;
		}
		
	}

}