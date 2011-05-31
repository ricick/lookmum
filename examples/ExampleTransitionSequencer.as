package  
{
	import com.lookmum.util.LayoutManager;
	import com.lookmum.view.Button;
	import com.lookmum.view.TextComponent;
	import com.lookmum.view.ToggleButton;
	import com.lookmum.view.TransitionerContainer;
	import com.lookmum.view.TransitionerSequencer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class ExampleTransitionSequencer extends Sprite
	{
		private var button1:ToggleButton;
		private var button2:ToggleButton;
		private var button3:ToggleButton;
		private var sequence1:TransitionerSequencer;
		private var sequence2:TransitionerSequencer;
		private var sequence3:TransitionerSequencer;
		public function ExampleTransitionSequencer():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var components:Array = [];
			components = components.concat(createSimpleSequence());
			components = components.concat(createComplexSequence());
			components = components.concat(createSubSequence());
			
			LayoutManager.spaceVertical(components, 25);
			
		}
		
		private function createSimpleSequence():Array
		{
			button1 = new ToggleButton(new buttonClip());
			addChild(button1);
			button1.addEventListener(MouseEvent.CLICK, onClickButton1);
			
			var holder:MovieClip = new MovieClip();
			addChild(holder);
			
			sequence1 = new TransitionerSequencer(holder);
			
			var buttons:Array = [];
			for (var i:int = 0; i < 10; i++)
			{
				var button:Button = new Button(new buttonClip);
				button.visible = false;
				holder.addChild(button);
				buttons.push(button);
				sequence1.addTransitionItem(button);
			}
			LayoutManager.spaceHorizontal(buttons, 5);
			return [button1, sequence1];
		}
		
		private function onClickButton1(e:MouseEvent):void 
		{
			if (button1.toggle)
				sequence1.transitionIn();
			else
				sequence1.transitionOut();
		}
		
		private function createComplexSequence():Array
		{			
			button2 = new ToggleButton(new buttonClip());
			addChild(button2);
			button2.addEventListener(MouseEvent.CLICK, onClickButton2);
			
			sequence2 = new TransitionerSequencer(new MovieClip);
			addChild(sequence2);
			
			var containers:Array = [];
			for (var i:int = 0; i < 10; i++)
			{
				var container:TransitionerContainer = new TransitionerContainer(new MovieClip);
				container.visible = false;
				
				var buttons:Array = [];
				for (var j:int = 0; j < 2; j++)
				{
					var button:Button = new Button(new buttonClip);
					container.addChild(button);
					button.visible = false;
					buttons.push(button);
					container.addTransitionItem(button);
				}
				
				LayoutManager.spaceVertical(buttons, 5);
				containers.push(container);
				sequence2.addTransitionItem(container);
				sequence2.addChild(container);
			}
			LayoutManager.spaceHorizontal(containers, 5);
			return [button2, sequence2];
		}
		
		private function onClickButton2(e:MouseEvent):void 
		{
			if (button2.toggle)
				sequence2.transitionIn();
			else
				sequence2.transitionOut();
		}
		
		private function createSubSequence():Array
		{
			button3 = new ToggleButton(new buttonClip());
			addChild(button3);
			button3.addEventListener(MouseEvent.CLICK, onClickButton3);
			
			sequence3 = new TransitionerSequencer(new MovieClip);
			addChild(sequence3);
			
			var sequencers:Array = [];
			for (var i:int = 0; i < 10; i++)
			{
				var sequencer:TransitionerSequencer = new TransitionerSequencer(new MovieClip);
				sequencer.visible = false;
				
				var buttons:Array = [];
				for (var j:int = 0; j < 2; j++)
				{
					var button:Button = new Button(new buttonClip);
					sequencer.addChild(button);
					button.visible = false;
					buttons.push(button);
					sequencer.addTransitionItem(button);
				}
				
				LayoutManager.spaceVertical(buttons, 5);
				sequencers.push(sequencer);
				sequence3.addTransitionItem(sequencer);
				sequence3.addChild(sequencer);
			}
			LayoutManager.spaceHorizontal(sequencers, 5);
			
			return [button3, sequence3];
		}
		
		private function onClickButton3(e:MouseEvent):void 
		{
			if (button3.toggle)
				sequence3.transitionIn();
			else
				sequence3.transitionOut();
		}
		
	}

}