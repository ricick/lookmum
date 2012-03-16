package com.lookmum.util 
{
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class TimeCodeUtil
	{
		public static function toTimeCode(milliseconds:int, mask:String="HH:MM:SS:mmm") : String 
		{
			var isNegative:Boolean = false;
			if (milliseconds < 0)
			{
				isNegative = true;
				milliseconds = Math.abs(milliseconds);
			}
			
			var seconds:int = Math.floor((milliseconds / 1000) % 60);
			var strSeconds:String = (seconds < 10) ? ("0" + String(seconds)) : String(seconds);
			var minutes:int = Math.floor(Math.floor((milliseconds / 1000) / 60) % 60);
			var strMinutes:String = (minutes < 10) ? ("0" + String(minutes)) : String(minutes);
			var hours:int    = Math.floor(Math.floor((milliseconds / 1000) / 60) / 60);
			var strHours:String = (hours < 10) ? ("0" + String(hours)) : String(hours);
			
			var strMilliseconds:String = milliseconds.toString();
			strMilliseconds = strMilliseconds.substring(strMilliseconds.length - 3);
			while (strMilliseconds.length < 3) {
				strMilliseconds = "0" + strMilliseconds;
			}
			
			var timeCodeAbsolute:String = mask;
			timeCodeAbsolute = timeCodeAbsolute.split("HH").join(strHours)
			timeCodeAbsolute = timeCodeAbsolute.split("MM").join(strMinutes)
			timeCodeAbsolute = timeCodeAbsolute.split("SS").join(strSeconds)
			timeCodeAbsolute = timeCodeAbsolute.split("mmm").join(strMilliseconds);
			
			var timeCode:String = (isNegative) ? "-" + timeCodeAbsolute : timeCodeAbsolute;
			
			return timeCode;
		}
	}

}