package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Theeban
	 */
	public class Accordian extends Component implements IToggle
	{
		protected var head:IToggle;
		protected var body:Component;
		private var bodyMask:MovieClip;
		public function Accordian(target:MovieClip) 
		{
			super(target);
		}
		
		public function getHitspot():MovieClip
		{
			return head.target;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			head = getHead();
			head.addEventListener(MouseEvent.CLICK, onClickHead);
			body = getBody();
			bodyMask = target.bodyMask;
			toggle = toggle;
		}
		
		private function onClickHead(e:MouseEvent):void 
		{
			toggle = head.toggle;
		}
		
		protected function getHead():IToggle
		{
			return new ToggleButton(target.head);
		}
		
		protected function getBody():Component
		{
			return new Component(target.body);
		}
		
		public function get toggle():Boolean
		{
			return head.toggle;
		}
		
		public function set toggle(value:Boolean):void
		{
			head.toggle = value;
			head.mouseEnabled = !value;
			head.mouseChildren = !value;
			
			if (value)
				bodyMask.height = body.height;
			else
				bodyMask.height = 0;
		}
		
		override public function get height():Number
		{
			if (!toggle)
				return head.height;
			return super.height;
		}
		
	}

}