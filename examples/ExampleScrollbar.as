package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.util.ScrollBarManager;
	import com.lookmum.view.ScrollBar;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleScrollbar extends Sprite
	{
		
		public function ExampleScrollbar() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			var scrollBar:ScrollBar = new ScrollBar(new scrollBarClip());
			var textField:TextField  = new TextField();
			textField.height = scrollBar.height;
			textField.wordWrap = true;
			textField.htmlText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula urna, accumsan a dignissim sit amet, tincidunt vitae libero. Sed eu metus eu felis consequat elementum. Nulla sagittis imperdiet tincidunt.<br/><br/>Vestibulum metus lacus, rutrum non scelerisque ut, euismod eu tellus. Quisque tincidunt mi congue tellus cursus lacinia. Praesent est sapien, suscipit quis rhoncus dictum, fringilla sed mauris';
			LayoutManager.spaceHorizontal([textField, scrollBar]);
			addChild(textField);
			addChild(scrollBar);
			var sbm:ScrollBarManager = new ScrollBarManager(scrollBar);
			sbm.associateTextFieldScroll(textField);
		}
		
	}

}