package com.lookmum.util 
{
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class StackTrace
	{
		
		public function StackTrace() 
		{
			
		}
		public static function printStack():void {
			try{
				throw(new Error('Stack trace'));
			}catch (e:Error) {
				trace(e.getStackTrace());
			}
		}
	}

}