package com.lookmum.view 
{
	
	import com.lookmum.view.Component;
	import com.lookmum.view.FadingComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class BlurLayer extends Component
	{
		
		private var bitmap:Bitmap;
		private var blurAmount:Number = 10;
		private var _width:Number = 50;
		private var _height:Number = 50;
		public function BlurLayer(target:MovieClip) 
		{
			super(target);
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			bitmap = new Bitmap();
			target.addChild(bitmap);
			bitmap.filters = [new BlurFilter(blurAmount, blurAmount, 3)];
			refresh();
			addEventListener(Event.ADDED, onAdded);
		}
		private function onAdded(e:Event):void 
		{
			if (visible) refresh();
		}
		public function refresh():void {
			if (!visible) return;
			if (!target.parent || !target.stage) {
				//cant refresh as not in display list
				return;
			}
			var coords:Point = new Point(x, y);
			target.visible = false;			
			coords = target.parent.localToGlobal(coords);
			var bitmapData:BitmapData = new BitmapData(_width, _height, true, 0xff0000);
			var matrix:Matrix = new Matrix();
			matrix.translate(-coords.x, -coords.y);
			bitmapData.draw(target.stage, matrix);
			bitmap.bitmapData = bitmapData;
			target.visible = true;
			
		}
		
		//{region overriden DisplayObject properties and methods
		
		override public function get visible():Boolean { return super.visible; }
		
		override public function set visible(value:Boolean):void 
		{
			super.visible = value;
			if(value)refresh();
		}
		
		override public function get x():Number { return super.x; }
		
		override public function set x(value:Number):void 
		{
			super.x = value;
			if(visible)refresh();
		}
		override public function get y():Number { return super.y; }
		
		override public function set y(value:Number):void 
		{
			super.y = value;
			if(visible)refresh();
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void 
		{
			_width = value;
			if(visible)refresh();
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void 
		{
			_height = value;
			if(visible)refresh();
		}
		//}
	}

}