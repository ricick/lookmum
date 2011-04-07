package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class DropLocation extends Component implements IDropLocation
	{
		private var dropSpot:MovieClip;
		public function DropLocation(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			if (target.dropSpot) dropSpot = target.dropSpot;
			super.createChildren();
		}
		public function getDropSpot():Point 
		{
			if (dropSpot) return new Point(dropSpot.x, dropSpot.y);
			return new Point(x, y);
		}
		
	}

}