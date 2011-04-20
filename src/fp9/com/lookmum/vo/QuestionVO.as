package com.lookmum.vo 
{
	import com.lookmum.util.TextManager;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class QuestionVO 
	{
		public var text:String;
		public var type:String;
		public var feedbackCorrect:String;
		public var feedbackIncorrect:String;
		public var options:Array;
		public static function fromXML(xml:XML):QuestionVO 
		{
			var value:QuestionVO = new QuestionVO();
			value.type = xml.@type;
			value.text = TextManager.getText(xml.@text);
			value.feedbackCorrect = TextManager.getText(xml.@feedbackCorrect);
			value.feedbackIncorrect = TextManager.getText(xml.@feedbackIncorrect);
			value.options = new Array();
			for each (var optionXML:XML in xml.options.option) 
			{
				value.options.push(QuestionOptionVO.fromXML(optionXML));
			}
			return value;
		}
		
		public function get correct():Boolean 
		{
			for each (var item:QuestionOptionVO in options) 
			{
				if (item.correct != item.selected) return false;
			}
			return true;
		}
		
	}

}