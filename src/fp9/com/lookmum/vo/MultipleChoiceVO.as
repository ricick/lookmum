package com.lookmum.vo
{
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class MultipleChoiceVO
	{
		public var correct:Boolean;
		public var selected:Boolean;
		public var score:int; // 0 is wrong, 1 is right;
		
		public function MultipleChoiceVO() 
		{
			
		}
		
		public static function fromXML(xml:XML):MultipleChoiceVO 
		{
			var value:MultipleChoiceVO = new MultipleChoiceVO();
			value.correct = xml.@correct == "true";
			
			return value;
		}
		
	}

}