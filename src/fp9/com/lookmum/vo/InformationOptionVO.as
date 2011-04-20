package com.lookmum.vo 
{
	import com.lookmum.util.TextManager;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class InformationOptionVO 
	{
		public var title:String;
		public var text:String;
		public static function fromXML(xml:XML):InformationOptionVO
		{
			var vo:InformationOptionVO = new InformationOptionVO();
			
			// initialise vo here
			vo.title = TextManager.getText(xml.@title);
			vo.text = TextManager.getText(xml.@text);
			
			return vo;
		}
		
	}

}