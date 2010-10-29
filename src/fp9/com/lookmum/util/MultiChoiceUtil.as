package com.lookmum.util
{
	import com.lookmum.view.MultipleChoiceStatement
	import com.lookmum.vo.MultipleChoiceVO;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class MultiChoiceUtil
	{
		private var _isCorrect:Boolean;
		
		public function MultiChoiceUtil() 
		{
			LabelToggleButton
		}
		
		public static function markChoices(multipleChoiceVOs:Array, statementByChoice:Dictionary):Boolean
		{
			isCorrect = true;
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				var statement:MultipleChoiceStatement = statementByChoice[choice];
				if (choice.correct) 
				{
					statement.isCorrect = true;
				}
				else
				{
					statement.isCorrect = false;
				}
				if (choice.correct != statement.toggle) 
				{
					isCorrect = false;
				}
			}
			
			return isCorrect;
		}
		
		public function get isCorrect():Boolean { return _isCorrect; }
		
		public function set isCorrect(value:Boolean):void 
		{
			_isCorrect = value;
		}
		
	}

}