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
		public static var isCorrect:Boolean;
		public static var correctAnswers:Array;
		public static var incorrectAnswers:Array;
		
		public static function markChoices(multipleChoiceVOs:Array):Boolean
		{
			isCorrect = true;
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				if (choice.correct != choice.selected) 
				{
					//choice.score = 0
					isCorrect = false;
				}
				
			}
			
			return isCorrect;
		}
		
		public static function getCorrectAnswers(multipleChoiceVOs:Array):Array
		{
			correctAnswers = [];
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				if (choice.correct ==choice.selected) 
				{
					correctAnswers.push(choice);
				}
			}
			
			return correctAnswers;
		}
		
		public static function getIncorrectAnswers(multipleChoiceVOs:Array):Array
		{
			incorrectAnswers = [];
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				if (!choice.correct) 
				{
					incorrectAnswers.push(choice);
				}
			}
			
			return incorrectAnswers;
		}
	}

}