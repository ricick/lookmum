package  
{
	import com.lookmum.view.MultipleChoiceStatement;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class ExampleMultipleChoiceStatement extends MultipleChoiceStatement
	{
		private var correctMark:MovieClip;
		
		public function ExampleMultipleChoiceStatement(target:MovieClip) 
		{
			super(target);
			
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			correctMark = target.correctMark;
			correctMark.alpha = 0;
		}
		
		override public function get isCorrect():Boolean { return super.isCorrect; }
		
		override public function set isCorrect(value:Boolean):void 
		{
			super.isCorrect = value;
			
			if (value)
			{
				correctMark.alpha = 1;
			}
			else
			{
				this.alpha = 0.5;
			}
		}
	}

}