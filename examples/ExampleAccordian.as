package
{
	import com.lookmum.util.AccordianManager;
	import com.lookmum.view.Accordian;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author Theeban
	 */
	public class ExampleAccordian extends Sprite 
	{
		private var accordianManager:AccordianManager;
		private var accordians:Array;
		public function ExampleAccordian():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			accordianManager = new AccordianManager();
			accordians = [];
			for (var i:int = 0; i < 10; i++)
			{
				var accordian:Accordian = new Accordian(new accordianClip);
				addChild(accordian);
				accordian.toggle = false;
				accordians.push(accordian);
				accordianManager.addAccordian(accordian);
			}
		}
		
	}
	
}