package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.LabelButton;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleLabelButton extends Sprite
	{
		
		public function ExampleLabelButton() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var b1:LabelButton = new LabelButton(new labelButtonClip());
			b1.text = 'Click me';
			addChild(b1);
			
			var b2:LabelButton = new LabelButton(new labelButtonClip());
			b2.text = 'Click me';
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			b2.setTextFormat(tf);
			addChild(b2);
			
			var b3:LabelButton = new LabelButton(new labelButtonClip());
			b3.wordWrap = true;
			b3.autoSize = TextFieldAutoSize.LEFT;
			b3.width = 300;
			b3.htmlText = 'Click me Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula urna, accumsan a dignissim sit amet, tincidunt vitae libero. Sed eu metus eu felis consequat elementum. Nulla sagittis imperdiet tincidunt.<br/><br/>Vestibulum metus lacus, rutrum non scelerisque ut, euismod eu tellus. Quisque tincidunt mi congue tellus cursus lacinia. Praesent est sapien, suscipit quis rhoncus dictum, fringilla sed mauris';
			addChild(b3);
			
			var b4:LabelButton = new LabelButton(new labelButtonClip());
			b4.autoSize = TextFieldAutoSize.LEFT;
			b4.wordWrap = false;
			b4.text = 'Click me Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			addChild(b4);
			
			LayoutManager.spaceVertical([b1, b2, b3, b4], 5);
		}
		
	}

}