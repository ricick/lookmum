/**
* Description here..
* @author Default
* @version 0.1
*/
package com.lookmum.view {
//import com.dynamicflash.utils.Delegate;

import com.lookmum.events.TweenableEvent;
import com.lookmum.view.Component;
import flash.display.MovieClip;

[Event(name = "show", type = "com.lookmum.events.Event")]

public class FadingComponent extends Component{

	protected var tweenDecorator:TweenableComponent;
	public function FadingComponent(target:MovieClip) 
	{
		super(target);
	}
	override protected function createChildren():void 
	{
		super.createChildren();
		this.tweenDecorator = new TweenableComponent(this);
		this.tweenDecorator.durationAlpha = 0.2;
	}
	override public function get visible():Boolean { return super.visible; }
	
	override public function set visible(value:Boolean):void 
	{
		if (value) {
			this.tweenDecorator.stopTween();
			if (this.alpha == 1 && super.visible) return;
			if(!super.visible)this.alpha = (0);
			super.visible = true;
			this.tweenDecorator.removeEventListener(TweenableEvent.FADE_TO,this.onHide);
			this.tweenDecorator.addEventListener(TweenableEvent.FADE_TO,this.onShow);
			this.tweenDecorator.alphaTo(1);
		}else {
			this.tweenDecorator.stopTween();
			if(this.alpha==0||!super.visible){
				super.visible = false;
				return;
			}
			this.tweenDecorator.removeEventListener(TweenableEvent.FADE_TO,this.onShow);
			this.tweenDecorator.addEventListener(TweenableEvent.FADE_TO,this.onHide);
			this.tweenDecorator.alphaTo(0);
		}
	}
	private function onShow(e:TweenableEvent):void
	{
		this.dispatchEvent(new Event(Event.SHOW));
	}
	protected function onHide(e:TweenableEvent):void {
		this.tweenDecorator.removeEventListener(TweenableEvent.FADE_TO,this.onHide);
		super.visible = false;
	}
	public function set duration(value:Number):void{
		this.tweenDecorator.duration = value;
	}
	public function get duration():Number{
		return this.tweenDecorator.duration;
	}
	
}
}