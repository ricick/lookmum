package com.lookmum.util 
{
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ColorUtil
	{
		
		public function ColorUtil() 
		{
			
		}
		public static function hexToColor(string:String):uint{
			if (string.indexOf('#') == 0) string = string.substring(1);
			if (string.indexOf("0x") == -1) string = "0x" + string;
			return uint(string);
		}
	}

}