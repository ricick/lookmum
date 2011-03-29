package  
{
	import com.lookmum.view.TextComponent;
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleTextComponent extends Sprite
	{
		
		public function ExampleTextComponent() 
		{
			super();
			var textComponent:TextComponent = new TextComponent(new textComponentClip());
			addChild(textComponent);
			textComponent.type = TextFieldType.INPUT;
			textComponent.autoSize = TextFieldAutoSize.LEFT;
			textComponent.padding = 10;
		}
		
	}

}