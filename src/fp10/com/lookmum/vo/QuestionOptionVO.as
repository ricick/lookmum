package com.lookmum.vo
{
	import com.lookmum.util.TextManager;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class QuestionOptionVO
	{
		public var text:String;
		public var correct:Boolean;
		public var selected:Boolean;
		
		public function QuestionOptionVO() 
		{
			
		}
		
		public static function fromXML(xml:XML):QuestionOptionVO 
		{
			var value:QuestionOptionVO = new QuestionOptionVO();
			value.text = TextManager.getText(xml.@text);
			value.correct = xml.@correct == "true";
			
			return value;
		}
		
	}

}