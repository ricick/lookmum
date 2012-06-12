package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class Overlay extends Component 
	{
		private var cachePoint:Point;
		
		public function Overlay(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			if (stage) onAdded();
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if(stage){
				var point:Point = parent.globalToLocal(new Point(0, 0));
				if (cachePoint && (cachePoint.x != point.x || cachePoint.y != point.y)) arrangeComponents();
				if (!cachePoint) arrangeComponents();
				cachePoint = point;
			}
		}
		private function onAdded(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			stage.addEventListener(Event.RESIZE, onResize);
			arrangeComponents();
			
		}
		
		private function onResize(e:Event):void 
		{
			arrangeComponents();
		}
		override protected function arrangeComponents():void 
		{
			super.arrangeComponents();
			try {
			if (stage) {
				width = stage.stageWidth;
				height = stage.stageHeight;
				var zero:Point = parent.globalToLocal(new Point(0, 0));
				var widthOffset:Number = width - loaderInfo.width;
				var heightOffset:Number = height - loaderInfo.height;
				var dX:Number = zero.x;
				var dY:Number = zero.y;
				switch(stage.align) {
					case StageAlign.BOTTOM:
						dX = zero.x - (widthOffset / 2);
						dY = zero.y - heightOffset;
						break;
					case StageAlign.BOTTOM_LEFT:
						dY = zero.y - heightOffset;
						break;
					case StageAlign.BOTTOM_RIGHT:
						dX = zero.x - widthOffset;
						dY = zero.y - heightOffset;
						break;
					case StageAlign.LEFT:
						dY = zero.y - (heightOffset / 2);
						break;
					case StageAlign.RIGHT:
						dX = zero.x - widthOffset;
						dY = zero.y - (heightOffset / 2);
						break;
					case StageAlign.TOP:
						dX = zero.x - (widthOffset / 2);
						break;
					case StageAlign.TOP_LEFT:
						break;
					case StageAlign.TOP_RIGHT:
						dX = zero.x - widthOffset;
						break;
					default:
						dX = zero.x - (widthOffset / 2);
						dY = zero.y - (heightOffset / 2);
				}
				x = dX;
				y = dY;
			}
			} catch (e:Error) {
				trace(e);
			}
		}
		public function update():void{
			arrangeComponents();
		}
		
	}

}