package com.lookmum.view 
{
	import com.lookmum.view.Component;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ToolTip extends Component
	{
		public static const NONE:String = "none";
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		protected var components:Array;
		protected var overComponent:Component;
		
		protected var tooltip:Component;
		protected var tail:Component;
		
		public var xPlacement:String = RIGHT;
		public var yPlacement:String = BOTTOM;
		
		public var xEdgeOffset:Number = 0;
		public var yEdgeOffset:Number = 0;
		
		public var tailXEdgeOffset:Number = 0;
		public var tailYEdgeOffset:Number = 0;
		
		public var bounds:Rectangle;
		
		public function ToolTip(target:MovieClip) 
		{
			super(target);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			components = [];
			
			tooltip = new Component(target.tooltip);
			
			if (target.tail)
				tail = new Component(target.tail);
			
			visible = false;
		}
		
		override protected function arrangeComponents():void 
		{
			super.arrangeComponents();
			if (!stage || !overComponent) return ;
			arrangeToolTip();
			if (bounds)
			{
				var lastXPlacement:String = xPlacement;
				var lastYPlacement:String = yPlacement;
				var tooltipBounds:Rectangle = tooltip.getBounds(stage);
				if (bounds.intersects(tooltipBounds) && !bounds.containsRect(tooltipBounds))
				{
					// move left/right to center
					var componentBounds:Rectangle = overComponent.getBounds(stage);
					if (tooltipBounds.x < bounds.x)
						xPlacement = NONE;
					else if (tooltipBounds.x + tooltipBounds.width > bounds.x + bounds.width)
						xPlacement = NONE;
						
					arrangeToolTip();
					tooltipBounds = tooltip.getBounds(stage);
					
					// if still out then move center to left/right
					if (tooltipBounds.x < bounds.x)
						xPlacement = RIGHT;
					else if (tooltipBounds.x + tooltipBounds.width > bounds.x + bounds.width)
						xPlacement = LEFT;
						
					arrangeToolTip();
					tooltipBounds = tooltip.getBounds(stage);
					
					// move top/bottom to center
					if (tooltipBounds.y < bounds.y)
						yPlacement = NONE;
					else if (tooltipBounds.y + tooltipBounds.height > bounds.y + bounds.height)
						yPlacement = NONE;
					
					// if x/y is NONE i.e. the same then pick bottom/top
					if (xPlacement == yPlacement)
						yPlacement = BOTTOM;
					
					arrangeToolTip();
					tooltipBounds = tooltip.getBounds(stage);
					
					// if still out then move center to top/bottom
					if (tooltipBounds.y < bounds.y)
						yPlacement = BOTTOM;
					else if (tooltipBounds.y + tooltipBounds.height > bounds.y + bounds.height)
						yPlacement = TOP;
						
					arrangeToolTip();
				}
				if (lastXPlacement != xPlacement || lastYPlacement != yPlacement)
					animateChange();
			}
		}
		
		private function arrangeToolTip():void
		{
			var componentBounds:Rectangle = overComponent.getBounds(parent);
			
			// update tooltip placement
			
			switch(xPlacement)
			{
				case LEFT:
					this.x = -xEdgeOffset + componentBounds.x - tooltip.x - tooltip.width;
					break;
				case RIGHT:
					this.x = xEdgeOffset + componentBounds.x - tooltip.x + componentBounds.width;
					break;
				default:
					this.x = componentBounds.x - tooltip.x + (componentBounds.width - tooltip.width) * 0.5;
					break;
			}
			
			switch (yPlacement)
			{
				case TOP:
					this.y = -yEdgeOffset + componentBounds.y - tooltip.y - tooltip.height;
					break;
				case BOTTOM:
					this.y = yEdgeOffset + componentBounds.y - tooltip.y + componentBounds.height;
					break;
				default:
					this.y = componentBounds.y - tooltip.y + (componentBounds.height - tooltip.height) * 0.5;
					break;
			}
				
			if (tail)
			{
				// update tail placement
				
				switch(xPlacement)
				{
					case LEFT:
						switch(yPlacement)
						{
							case TOP:
								// RIGHT_BOTTOM | BOTTOM_RIGHT
								if (xEdgeOffset > yEdgeOffset)
								{
									// RIGHT_BOTTOM
									tail.rotation = -90;
									tail.x = tooltip.x + tooltip.width + tail.width * 0.5;
									tail.y = tooltip.y - tailYEdgeOffset + tooltip.height - tail.height * 0.5;
								}
								else
								{
									// BOTTOM_RIGHT
									tail.rotation = 0;
									tail.x = tooltip.x - tailXEdgeOffset + tooltip.width - tail.width * 0.5;
									tail.y = tooltip.y + tooltip.height + tail.height * 0.5;
								}
								break;
							case BOTTOM:
								// RIGHT_TOP | TOP_RIGHT
								if (xEdgeOffset > yEdgeOffset)
								{
									// RIGHT_TOP
									tail.rotation = -90;
									tail.x = tooltip.x + tooltip.width + tail.width * 0.5;
									tail.y = tooltip.y + tailYEdgeOffset + tail.height * 0.5;
								}
								else
								{
									// TOP_RIGHT
									tail.rotation = 180;
									tail.x = tooltip.x - tailXEdgeOffset + tooltip.width - tail.width * 0.5;
									tail.y = tooltip.y - tail.height * 0.5;
								}
								break;
							default:
								// RIGHT
								tail.rotation = -90;
								tail.x = tooltip.x + tooltip.width + tail.width * 0.5;
								tail.y = tooltip.y + tooltip.height * 0.5;
								break;
						}
						break;
					case RIGHT:
						switch(yPlacement)
						{
							case TOP:
								// LEFT_BOTTOM | BOTTOM_LEFT
								if (xEdgeOffset < yEdgeOffset)
								{
									// LEFT_BOTTOM
									tail.rotation = 90;
									tail.x = tooltip.x - tail.width * 0.5;
									tail.y = tooltip.y - tailYEdgeOffset + tooltip.height - tail.height * 0.5;
								}
								else
								{
									// BOTTOM_LEFT
									tail.rotation = 0;
									tail.x = tooltip.x + tailXEdgeOffset + tail.width * 0.5;
									tail.y = tooltip.y + tooltip.height + tail.height * 0.5;
								}
								break;
							case BOTTOM:
								// LEFT_TOP | TOP_LEFT
								if (xEdgeOffset < yEdgeOffset)
								{
									// LEFT_TOP
									tail.rotation = 90;
									tail.x = tooltip.x - tail.width * 0.5;
									tail.y = tooltip.y + tailYEdgeOffset + tail.height * 0.5;
								}
								else
								{
									// TOP_LEFT
									tail.rotation = 180;
									tail.x = tooltip.x + tailXEdgeOffset + tail.width * 0.5;
									tail.y = tooltip.y - tail.height * 0.5;
								}
								break;
							default:
								// LEFT
								tail.rotation = 90;
								tail.x = tooltip.x - tail.width * 0.5;
								tail.y = tooltip.y + tooltip.height * 0.5;
								break;
						}
						break;
					default:
						switch(yPlacement)
						{
							case TOP:
								// BOTTOM
								tail.rotation = 0;
								tail.x = tooltip.x + tooltip.width * 0.5;
								tail.y = tooltip.y + tooltip.height + tail.height * 0.5;
								break;
							case BOTTOM:
								// TOP
								tail.rotation = 180;
								tail.x = tooltip.x + tooltip.width * 0.5;
								tail.y = tooltip.y - tail.height * 0.5;
								break;
						}
						break;
				}
			}
		}
		
		public function set edgeOffset(value:Number):void 
		{
			xEdgeOffset = value;
			yEdgeOffset = value;
		}
		
		public function set tailEdgeOffset(value:Number):void 
		{
			tailXEdgeOffset = value;
			tailYEdgeOffset = value;
		}
		
		public function attach(component:Component):void
		{
			var index:int = components.indexOf(component);
			if (index >= 0) return;
			components.push(component);
			component.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			component.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			if (stage)
				onAddToStage();
			else
				addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
		}
		
		protected function onMouseMove(e:MouseEvent):void 
		{
			arrangeComponents();
		}
		
		protected function onRollOver(e:MouseEvent):void 
		{
			visible = true;
			overComponent = e.target as Component;
			arrangeComponents();
			animateIn();
		}
		
		protected function onRollOut(e:MouseEvent):void 
		{
			visible = false;
			animateOut();
		}
		
		public function detach(component:Component):void
		{
			var index:int = components.indexOf(component);
			if (index >= 0) return;
			components.push(component);
			component.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			component.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
		}
		
		override public function destroy():void 
		{
			super.destroy();
			while (components.length > 0)
				detach(components[0]);
		}
		
		protected function animateIn():void
		{
			
		}
		
		protected function animateOut():void
		{
			
		}
		
		protected function animateChange():void
		{
			
		}
		
	}

}