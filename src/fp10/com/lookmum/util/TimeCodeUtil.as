package com.lookmum.util 
{
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class TimeCodeUtil
	{
		public static function toTimeCode(milliseconds:int) : String 
		{
			var isNegative:Boolean = false;
			if (milliseconds < 0)
			{
				isNegative = true;
				milliseconds = Math.abs(milliseconds);			
			}
			
			var seconds:int = Math.round((milliseconds/1000) % 60);
			var strSeconds:String = (seconds < 10) ? ("0" + String(seconds)) : String(seconds);
			if(seconds == 60) strMinutes = "00";
			var minutes:int = Math.round(Math.floor((milliseconds/1000)/60));
			var strMinutes:String = (minutes < 10) ? ("0" + String(minutes)) : String(minutes);
			//hrs     = (mins    - ( mins    %= 60   )) / 60;
			var hours:int    = (minutes    - ( minutes    %= 60   )) / 60;
			var strHours:String = (hours < 10) ? ("0" + String(hours)) : String(hours);
			
			if(minutes > 60)
			{
				strSeconds = "60";
				strMinutes = "00";
			}
			
			var timeCodeAbsolute:String = strHours + ":" + strMinutes + ":" + strSeconds;
			var timeCode:String = (isNegative) ? "-" + timeCodeAbsolute : timeCodeAbsolute;
			
			return timeCode;
		}
	}

}