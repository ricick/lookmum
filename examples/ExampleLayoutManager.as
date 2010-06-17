package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.Component;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleLayoutManager extends Sprite
	{
		
		public function ExampleLayoutManager() 
		{
			var c1:Component = new Component(new block);
			var c2:Component = new Component(new block);
			var c3:Component = new Component(new block);
			
			//space vertical example
			/*
			c2.width = 75;
			c3.graphics.beginFill(0xFF9900);
			c3.graphics.drawRect(-50, 0, 50, 50);
			addChild(c1);
			addChild(c2);
			addChild(c3);
			LayoutManager.spaceHorizontal([c1, c2, c3], 10);
			*/
			
			//space vertical example
			/*
			c2.height = 75;
			c3.graphics.beginFill(0xFF9900);
			c3.graphics.drawRect(0, -50, 50, 50);
			addChild(c1);
			addChild(c2);
			addChild(c3);
			LayoutManager.spaceVertical([c1, c2, c3], 10);
			*/
			
			//layout vertical example
			/*
			c2.height = 75;
			c1.y = 100;
			c2.y = 200;
			c3.graphics.beginFill(0xFF9900);
			c3.graphics.drawRect(0, -50, 50, 50);
			c3.y = 300;
			addChild(c1);
			addChild(c2);
			addChild(c3);
			LayoutManager.spaceHorizontal([c1, c2, c3], 10);
			LayoutManager.alignCenterVertical([c1, c2, c3]);
			*/
			
			//layout horizontal example
			/*
			c2.width = 75;
			c1.x = 100;
			c2.x = 200;
			c3.graphics.beginFill(0xFF9900);
			c3.graphics.drawRect(-50, 0, 50, 50);
			c3.x = 300;
			addChild(c1);
			addChild(c2);
			addChild(c3);
			LayoutManager.spaceVertical([c1, c2, c3], 10);
			LayoutManager.alignCenterHorizontal([c1, c2, c3]);
			*/
			
			
			//layout vertical example (within widest)
			/**/
			c1.y = 100;
			c2.y = 200;
			c2.width = 400;
			c3.graphics.beginFill(0xFF9900);
			//c3.graphics.drawRect(0, -50, 50, 50);
			c3.y = 300;
			addChild(c1);
			addChild(c2);
			addChild(c3);
			LayoutManager.alignCenterVertical([c1, c2, c3]);
			/**/
		}
		
	}

}