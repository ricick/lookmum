package com.lookmum.vo
{
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class MultipleChoiceVO
	{
		public var text:String;
		public var correct:Boolean;
		public var selected:Boolean; // this is set inside the view
		
		public function MultipleChoiceVO() 
		{
			
		}
		
		public static function fromXML(xml:XML):MultipleChoiceVO 
		{
			var value:MultipleChoiceVO = new MultipleChoiceVO();
			value.text = xml.@text;
			value.correct = xml.@correct == "true";
			
			return value;
		}
		
	}

}