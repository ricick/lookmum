package com.lookmum.view 
{
	import com.cartogrammar.drawing.DashedLine;
	import com.lookmum.view.Component;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Marcus
	 */
	public class DashLineBox extends Component
	{
		
		
		private var dashedLine:DashedLine;
		
		private var _colour:uint;
		private var _thickness:Number;
		
		private var _length:Number;
		private var _gap:Number;
		
		private var _width:Number;
		private var _height:Number;
		
		public function DashLineBox(target:MovieClip) 
		{
			
			super(target);

			_colour = 0x000000;
			_thickness = 1;
			
			_length = 5;
			_gap = 5;
			
			_width = 0;
			_height = 0;
			
		}
		
		private function drawDashedLines():void {

			if (dashedLine != null) {
				removeChild(dashedLine);
			}
			
			dashedLine = new DashedLine(_thickness, _colour, new Array(_length, _gap));
			dashedLine.moveTo(0, 0);
			
			dashedLine.lineTo(_width, 0);
			
			dashedLine.lineTo(_width, _height);
			
			dashedLine.lineTo(0, _height);
			dashedLine.lineTo(0, 0);
		
			target.addChild(dashedLine);
			
		}
		
		public function set length(value:Number):void {
			_length = value;
			drawDashedLines();
		}
		
		public function get length():Number {
			return _length;
		}
		
		public function set thickness(value:Number):void {
			_thickness = value;
			drawDashedLines();
		}
		
		public function get thickness():Number {
			return _thickness;
		}
		
		public function set colour(value:uint):void {
			_colour = value;
			drawDashedLines();
		}
		
		public function get colour():uint {
			return _colour;
		}
		
		override public function set width(value:Number):void {
			_width = value;
			drawDashedLines();
		}

		override public function get width():Number {
			return _width;
		}
		
		override public function set height(value:Number):void {
			_height = value;
			drawDashedLines();
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public function set gap(value:Number):void 
		{
			_gap = value;
			drawDashedLines();
		}
		
		public function get gap():Number { return _gap; }
		
	}
	
}