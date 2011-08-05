package  
{
	import com.lookmum.view.Component;
	import com.lookmum.view.DragButton;
	import com.lookmum.view.ToolTip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleToolTip extends Sprite
	{
		
		public function ExampleToolTip() 
		{
			var libraryComponent:DragButton = new DragButton(new block());
			libraryComponent.x = (stage.stageWidth - libraryComponent.width) * 0.5;
			libraryComponent.y = (stage.stageHeight - libraryComponent.height) * 0.5;
			addChild(libraryComponent);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var container:Sprite = new Sprite();
			container.x = 300;
			container.y = 300;
			addChild(container);
			
			var tooltip:ToolTip = new ToolTip(new toolTipComponentClip);
			tooltip.xPlacement = ToolTip.LEFT;
			tooltip.yPlacement = ToolTip.BOTTOM;
			tooltip.xEdgeOffset = 50;
			tooltip.yEdgeOffset = 50;
			tooltip.tailEdgeOffset = 10;
			tooltip.attach(libraryComponent);
			tooltip.bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			container.addChild(tooltip);
		}
		
	}

}