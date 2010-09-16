package  
{
	import com.lookmum.view.LabelToggleButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleLabelToggleButton extends Sprite
	{
		private var b1:LabelToggleButton
		private var b2:LabelToggleButton
		private var b3:LabelToggleButton
		private var b4:LabelToggleButton
		public function ExampleLabelToggleButton() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			b1 = new LabelToggleButton(new labelToggleButtonClip());
			b1.text = 'Click me';
			addChild(b1);
			
			
			
			b2 = new LabelToggleButton(new labelToggleButtonClip());
			b2.text = 'Click me';
			addChild(b2);
			
			b2.y = 100;
			b2.textFormatRollOver = new TextFormat(null, null, 0xFF0000);
			b2.textFormatRollOverToggle = new TextFormat(null, null, 0x0000FF);
			
			
			
			b3 = new LabelToggleButton(new labelToggleButtonClip());
			b3.text = 'Disable others';
			b3.addEventListener(MouseEvent.CLICK, onClick);
			addChild(b3);
			b3.y = 200;
			
			
			
			
			b4 = new LabelToggleButton(new labelButtonClip());
			b4.wordWrap = true;
			b4.autoSize = TextFieldAutoSize.LEFT;
			b4.width = 300;
			b4.y = 300;
			b4.htmlText = 'Click me Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula urna, accumsan a dignissim sit amet, tincidunt vitae libero. Sed eu metus eu felis consequat elementum. Nulla sagittis imperdiet tincidunt.<br/><br/>Vestibulum metus lacus, rutrum non scelerisque ut, euismod eu tellus. Quisque tincidunt mi congue tellus cursus lacinia. Praesent est sapien, suscipit quis rhoncus dictum, fringilla sed mauris';
			var tf:TextFormat = new TextFormat();
			tf.leading = -5;
			b4.setTextFormat(tf);
			addChild(b4);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			b1.enabled = !b3.toggle;
			b2.enabled = !b3.toggle;
			b4.enabled = !b4.toggle;
		}
		
	}

}