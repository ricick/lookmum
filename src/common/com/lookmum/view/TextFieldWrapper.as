package com.lookmum.view 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TextFieldWrapper extends TextComponent 
	{
		
		public function TextFieldWrapper(wrapTextField:TextField) 
		{
			super(new MovieClip);
			this.textField = wrapTextField;
			if (wrapTextField.parent) {
				wrapTextField.parent.addChild(this);
			}
			x = textField.x;
			y = textField.y;
			textField.x = 0;
			textField.y = 0;
			target.addChild(wrapTextField);
		}
		
	}

}