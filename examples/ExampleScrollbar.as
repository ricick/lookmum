package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.util.ScrollBarManager;
	import com.lookmum.view.ScrollBar;
	import flash.display.MovieClip;
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
			var scrollBar1:ScrollBar = new ScrollBar(new scrollBarClip());
			scrollBar1.tabEnabled = false;
			scrollBar1.tabChildren = false;
			var textField:TextField  = new TextField();
			textField.height = scrollBar1.height;
			textField.wordWrap = true;
			textField.htmlText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula urna, accumsan a dignissim sit amet, tincidunt vitae libero. Sed eu metus eu felis consequat elementum. Nulla sagittis imperdiet tincidunt.<br/><br/>Vestibulum metus lacus, rutrum non scelerisque ut, euismod eu tellus. Quisque tincidunt mi congue tellus cursus lacinia. Praesent est sapien, suscipit quis rhoncus dictum, fringilla sed mauris';
			scrollBar1.x = textField.width + 5;
			addChild(textField);
			addChild(scrollBar1);
			var sbm1:ScrollBarManager = new ScrollBarManager(scrollBar1);
			sbm1.associateTextFieldScroll(textField);
		
			var scrollBar2:ScrollBar = new ScrollBar(new scrollBarClip());
			var clip:MovieClip = new scrollTestClip();
			var maskClip:MovieClip = new MovieClip();
			clip.x = 200;
			maskClip.x = 200;
			maskClip.graphics.beginFill(0xFF0000);
			maskClip.graphics.drawRect(0, 0, clip.width, scrollBar2.height);
			scrollBar2.x = clip.x + clip.width + 5;
			addChild(clip);
			addChild(maskClip);
			addChild(scrollBar2);
			clip.mask = maskClip;
			var sbm2:ScrollBarManager = new ScrollBarManager(scrollBar2);
			sbm2.associateDisplayObjectY(clip, maskClip);
		}
		
	}

}