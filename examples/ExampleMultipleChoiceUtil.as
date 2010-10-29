package  
{
	import com.lookmum.view.Button;
	import com.lookmum.view.MultipleChoiceStatement;
	import com.lookmum.vo.MultipleChoiceVO;
	import com.lookmum.util.MultiChoiceUtil
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class ExampleMultipleChoiceUtil extends Sprite
	{
		private var sampleXML:XML
		private var xmlLoader:URLLoader;
		private var choiceVOs:Array;
		private var indexByChoice:Dictionary;
		private var choiceRenderByChoiceVO:Dictionary;
		private var choiceRenders:Array;
		private var submitBtn:Button;
		
		public function ExampleMultipleChoiceUtil() 
		{
			super();
			
			// you need some data
			xmlLoader = new URLLoader(new URLRequest('xml/multipleChoice.xml'));
			xmlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			
			submitBtn = new Button(new buttonClip);
			submitBtn.addEventListener(MouseEvent.CLICK, onSubmitClick);
			addChild(submitBtn);
		}
		
		private function onSubmitClick(e:MouseEvent):void 
		{
			MultiChoiceUtil.markChoices(choiceVOs);
			//MultiChoiceUtil.getCorrectAnswers(choiceVOs);
			//MultiChoiceUtil.getIncorrectAnswers(choiceVOs);
			for each(var choiceRender:ExampleMultipleChoiceStatement in choiceRenders)
			{
				choiceRender.enabled = false;
				var itemIndex:int = (indexByChoice[choiceRender]);
				choiceRender.isCorrect = choiceVOs[itemIndex].correct;
			}
		}
		
		private function onLoadComplete(e:Event):void 
		{
			// you need an array of MultipleChoiceVOs, or "the choices"
			choiceVOs = [];
			sampleXML = new XML(xmlLoader.data);
			for each(var choice:XML in sampleXML.choices.choice)
			{
				choiceVOs.push(MultipleChoiceVO.fromXML(choice));
			}
			
			layOutChoices();
		}
		
		private function layOutChoices():void
		{
			var yModifier:Number = 0;
			
			indexByChoice = new Dictionary();
			choiceRenderByChoiceVO = new Dictionary();
			choiceRenders = [];
			for (var i:int = 0; i < choiceVOs.length; i++)
			{
				var choice:ExampleMultipleChoiceStatement = new ExampleMultipleChoiceStatement(new multipleChoiceStateMentClip);
				choice.x = choice.width;
				choice.y = yModifier;
				choiceRenderByChoiceVO[choiceVOs[i]] = choice;
				indexByChoice[choice] = i;
				choice.addEventListener(MouseEvent.CLICK, onChoiceClick)
				choice.choiceVO = choiceVOs[i];
				choiceRenders.push(choice);
				addChild(choice);
				yModifier += choice.height;
			}
			
			submitBtn.x = (choice.x + choice.width) - submitBtn.width;
			submitBtn.y = yModifier + submitBtn.height
		}
		
		private function onChoiceClick(e:MouseEvent):void 
		{
			var itemIndex:int = indexByChoice[e.target];
			var choice:ExampleMultipleChoiceStatement = e.target as ExampleMultipleChoiceStatement;
			choiceVOs[itemIndex].selected = choice.toggle;
		}
	
	}

}