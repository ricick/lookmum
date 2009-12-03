package  
{
	import com.lookmum.view.Component;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleComponent extends Sprite
	{
		
		public function ExampleComponent() 
		{
			var libraryComponent:Component = new Component(new block());
			addChild(libraryComponent);
			var stageComponent:Component = new Component(this.stageComponentClip);
		}
		
	}

}