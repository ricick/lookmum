package com.lookmum.util
{
	import com.lookmum.view.MultipleChoiceStatement
	import com.lookmum.vo.MultipleChoiceVO;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 * 
	 * Hello. This class is to help you out when you're doing multiple choice assessment tasks.
	 * You data of choice is an array of MultipleChoiceVOs
	 * com.lookmum.vo.MultipleChoiceVO
	 * 
	 */
	public class MultiChoiceUtil
	{
		public static function getCorrect(multipleChoiceVOs:Array):Boolean
		{
			var isCorrect:Boolean = true;
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				if (choice.correct != choice.selected) 
				{
					isCorrect = false;
				}
			}
			
			return isCorrect;
		}
		
		public static function getCorrectAnswers(multipleChoiceVOs:Array):Array
		{
			var correctAnswers:Array = [];
			
			for each(var choice:MultipleChoiceVO in multipleChoiceVOs)
			{
				if (choice.correct == choice.selected) 
				{
					correctAnswers.push(choice);
				}
			}
			
			return correctAnswers;
		}
		
		public static function getIncorrectAnswers(multipleChoiceVOs:Array):Array
		{
			var incorrectAnswers:Array = [];
			
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