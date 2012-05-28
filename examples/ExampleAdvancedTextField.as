package  
{
	import com.lookmum.view.AdvancedTextField;
	import com.lookmum.view.Button;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * ...
	 * @author theeban
	 */
	public class ExampleAdvancedTextField extends Sprite
	{
		private var advancedTextField:AdvancedTextField;
		private var normalTextField:TextField;
		private var button:Button;
		private var inputTextField:TextField;
		private var advancedBg:MovieClip;
		private var normalBg:MovieClip;
		
		public function ExampleAdvancedTextField() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			inputTextField = new TextField();
			inputTextField.border = true;
			inputTextField.width = 400;
			inputTextField.height = 100;
			inputTextField.type = TextFieldType.INPUT;
			inputTextField.multiline = true;
			inputTextField.wordWrap = true;
			addChild(inputTextField);
			
			button = new Button(new buttonClip);
			button.addEventListener(MouseEvent.CLICK, onClickButton);
			button.y = 100;
			addChild(button);
			
			normalTextField = new TextField();
			normalTextField.border = true;
			normalTextField.width = 400;
			normalTextField.height = 100;
			normalTextField.multiline = true;
			normalTextField.wordWrap = true;
			normalTextField.y = 200;
			addChild(normalTextField);
			
			var textField:TextField = new TextField();
			advancedTextField = new AdvancedTextField(textField);
			advancedTextField.border = true;
			advancedTextField.width = 400;
			advancedTextField.height = 100;
			advancedTextField.multiline = true;
			advancedTextField.wordWrap = true;
			advancedTextField.y = 400;
			addChild(textField);
			
			normalBg = new MovieClip();
			normalBg.graphics.beginFill(0xcccccc);
			normalBg.graphics.drawRect(0, 0, 400, 100);
			normalBg.y = normalTextField.y;
			addChildAt(normalBg, 0);
			
			advancedBg = new MovieClip();
			advancedBg.graphics.beginFill(0xcccccc);
			advancedBg.graphics.drawRect(0, 0, 400, 100);
			advancedBg.y = advancedTextField.y;
			addChildAt(advancedBg, 0);
		}
		
		private function onClickButton(e:MouseEvent):void 
		{
			normalTextField.htmlText = inputTextField.text;
			advancedTextField.htmlText = inputTextField.text;
			normalBg.width = normalTextField.textWidth;
			advancedBg.width = advancedTextField.textWidth;
		}
		
	}

}