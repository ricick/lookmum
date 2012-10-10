package  
{
	import com.lookmum.view.ScrollingTextComponent;
	import com.lookmum.view.TextComponent;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleScrollingTextComponent extends Sprite
	{
		
		public function ExampleScrollingTextComponent() 
		{
			super();
			var scrollingTextComponent:ScrollingTextComponent = new ScrollingTextComponent(new scrollTextClip);
			scrollingTextComponent.multiline = true;
			scrollingTextComponent.wordWrap = true;
			scrollingTextComponent.autoSize = TextFieldAutoSize.LEFT;
			scrollingTextComponent.htmlText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula urna, accumsan a dignissim sit amet, tincidunt vitae libero. Sed eu metus eu felis consequat elementum. Nulla sagittis imperdiet tincidunt.<br/><br/>Vestibulum metus lacus, rutrum non scelerisque ut, euismod eu tellus. Quisque tincidunt mi congue tellus cursus lacinia. Praesent est sapien, suscipit quis rhoncus dictum, fringilla sed mauris';
			addChild(scrollingTextComponent);
		}
		
	}

}