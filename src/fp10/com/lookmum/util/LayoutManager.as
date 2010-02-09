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
		public static function constrainedResize(displayObject:DisplayObject, maxWidth:Number, maxHeight:Number):void {
			displayObject.width = maxWidth;
			displayObject.scaleY = displayObject.scaleX;
			if (displayObject.height > maxHeight) {
				displayObject.height = maxHeight;
				displayObject.scaleX = displayObject.scaleY;
			}
			
		}
		public static function alignCenterHorizontal(items:Array):void{
			if (!items || items.length == 0) return;
			var topBounds:Number;
			var bottomBounds:Number;
			var centerPoint:Number;
			var topOffest:Number;
			for each(var item:DisplayObject in items) {
				topOffest = item.getBounds(item).y - item.y;
				if (!topBounds || item.y + topOffest < topBounds) topBounds = item.y + topOffest;
				if (!bottomBounds || item.y + item.height + topOffest > bottomBounds) bottomBounds = item.y + item.height + topOffest;
			}
			centerPoint = topBounds + ((bottomBounds - topBounds) / 2);
			for each(item in items) {
				topOffest = item.getBounds(item).y - item.y;
				item.y = centerPoint - (item.height / 2) - topOffest;
			}
		}
		public static function alignCenterVertical (items:Array):void {
			if (!items || items.length == 0) return;
			var leftBounds:Number;
			var rightBounds:Number;
			var centerPoint:Number;
			var leftOffset:Number;
			for each(var item:DisplayObject in items) {
				leftOffset = item.getBounds(item).y - item.y;
				if (!leftBounds || item.x + leftOffset  < leftBounds) leftBounds = item.x + leftOffset;
				if (!rightBounds || item.x + item.width + leftOffset  > rightBounds) rightBounds = item.x + item.width + leftOffset;
			}
			centerPoint = leftBounds + ((rightBounds - leftBounds) / 2);
			for each(item in items) {
				leftOffset = item.getBounds(item).y - item.y;
				item.x = centerPoint - (item.width / 2) - leftOffset;
			}
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
				var leftOffset:Number = item.getBounds(item).x - item.x;
				item.x = space - leftOffset;
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
				var topOffset:Number = item.getBounds(item).y - item.y;
				item.y = space - topOffset;
				space += item.height + gap;
			}
		}
	}
}