package com.lookmum.view
{
	import com.lookmum.view.LabelToggleButton;
	import com.lookmum.vo.MultipleChoiceVO
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class MultipleChoiceStatement extends LabelToggleButton
	{
		private var _choiceVO:MultipleChoiceVO;
		private var _isCorrect:Boolean;
		
		public function MultipleChoiceStatement(target:MovieClip) 
		{
			super(target);
			
		}
		
		public function get choiceVO():MultipleChoiceVO { return _choiceVO; }
		
		public function set choiceVO(value:MultipleChoiceVO):void 
		{
			_choiceVO = value;
		}
		
		public function get isCorrect():Boolean { return _isCorrect; }
		
		public function set isCorrect(value:Boolean):void 
		{
			_isCorrect = value;
		}
		
	}

}