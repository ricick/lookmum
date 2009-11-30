package com.lookmum.util 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class LayoutManager
	{
		
		public function LayoutManager() 
		{
			
		}
		public static function spaceHorizontal(items:Array, gap:Number = 0, useExistingSpace:Boolean = false, fixedWidth:Number = 0):void {
			if (!items || items.length == 0) return;
			if (fixedWidth > 0) {
				var totalWidth:Number = 0;
				for each(var itemWidth:DisplayObject in items) {
					totalWidth += itemWidth.width;
				}
				if (useExistingSpace) fixedWidth = items[items.length - 1].x + items[items.length - 1].width;
				gap = (fixedWidth - totalWidth) / (items.length - 1);
			}
			var space:Number = items[0].x;
			for each(var item:DisplayObject in items) {
				item.x = space;
				space += item.width + gap;
			}
		}
		public static function spaceVertical(items:Array, gap:Number = 0, useExistingSpace:Boolean = false, fixedHeight:Number = 0):void {
			if (!items || items.length == 0) return;
			if (fixedHeight > 0 || useExistingSpace) {
				var totalHeight:Number = 0;
				for each(var itemHeight:DisplayObject in items) {
					totalHeight += itemHeight.height;
				}
				if (useExistingSpace) fixedHeight = items[items.length - 1].y + items[items.length - 1].height;
				gap = (fixedHeight - totalHeight) / (items.length - 1);
			}
			var space:Number = items[0].y;
			for each(var item:DisplayObject in items) {
				item.y = space;
				space += item.height + gap;
			}
		}
	}
}