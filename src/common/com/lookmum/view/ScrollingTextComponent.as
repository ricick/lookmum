package com.lookmum.view 
{
	import com.lookmum.util.ScrollBarManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ScrollingTextComponent extends TextComponent 
	{
		
		protected var scrollBar:ScrollBar;
		private var maskClip:MovieClip;
		protected var content:MovieClip;
		private var manager:ScrollBarManager;
		private var hitspot:Sprite;
		public function ScrollingTextComponent(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			content = target.content;
			super.createChildren();
			maskClip = getMask();
			content.mask = maskClip;
			scrollBar = getScrollBar();
			manager = new ScrollBarManager(scrollBar);
			manager.associateDisplayObjectY(content, maskClip);
		}
		
		private function getMask():MovieClip
		{
			return target.maskClip;
		}
		
		protected function getScrollBar():ScrollBar {
			return new ScrollBar(target.scrollBar);
		}
		override protected function getTextField():TextField 
		{
			return content.textField;
		}
		override public function get htmlText():String 
		{
			return super.htmlText;
		}
		
		override public function set htmlText(value:String):void 
		{
			super.htmlText = value;
			manager.calculateScroll();
			scrollBar.visible = scrollBar.maxScroll > 1;
		}
		override public function get text():String 
		{
			return super.text;
		}
		
		override public function set text(value:String):void 
		{
			super.text = value;
			manager.calculateScroll();
			scrollBar.visible = scrollBar.maxScroll > 1;
		}
		
		override protected function arrangeComponents():void 
		{
			super.arrangeComponents();
			scrollBar.graphics.clear();
			var bounds:Rectangle = getBounds(scrollBar);
			scrollBar.graphics.beginFill(1, 0);
			scrollBar.graphics.drawRect(bounds.x - scrollBar.x, bounds.y - scrollBar.y, bounds.width, bounds.height);
			scrollBar.graphics.endFill();
		}
		
	}

}