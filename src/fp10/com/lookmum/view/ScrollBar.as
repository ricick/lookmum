package  com.lookmum.view {
	import com.lookmum.events.ComponentEvent;
	import com.lookmum.events.DragEvent;
	import com.lookmum.view.Component;
	import com.lookmum.view.ILevelComponent;
	import com.lookmum.view.ScrollTab;
	import com.lookmum.view.ScrollTrack;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Rectangle;
	
	[Event(name = "scroll", type = "flash.events.Event")]
	[Event(name = "resize", type = "com.lookmum.events.ComponentEvent")]
	
	public class ScrollBar extends Component implements IScrollBar
	{
		protected var tab:ScrollTab;
		protected var track : ScrollTrack;
		protected var scrollHeight:Number = 0;
		protected var _minScroll:Number = 0;
		protected var _maxScroll:Number = 0;
		protected var _scrollSize:Number;
		protected var _scroll:Number = 0;
		protected var _wheelSpeed:int = 1;
		protected var scrollRatio:Number;
		public var hideOnSelfDisable:Boolean;
		public static var SCROLL:String = 'scroll';
		protected var _width:Number;
		protected var _height:Number;
		protected var _minimumTabSize:Number;
		public function ScrollBar (target:MovieClip)
		{
			super (target);
			this.track = this.getScrollTrack();
			this.track.addEventListener(MouseEvent.CLICK,onClickTrack);
			this.tab = this.getScrollTab();
			this.tab.addEventListener(DragEvent.DRAG, doScroll);
			this.tab.tabEnabled = false;
			this.setScroll();
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			level -= e.delta * wheelSpeed;
		}
		
		private function onClickTrack(e:MouseEvent):void 
		{
			if (e.localY < tab.y) {
				level -= scrollSize;
			}else {
				level += scrollSize;
			}
		}
		/**
		 * scoping
		 */
		private function getScrollTrack():ScrollTrack{
			var newTrack:ScrollTrack = new ScrollTrack(target.getChildByName('track') as MovieClip);
			return newTrack;
		}
		private function getScrollTab():ScrollTab{
			var newTab:ScrollTab = new ScrollTab(target.getChildByName('tab') as MovieClip);
			return newTab;
		}
		/**
		 * sets the position back to min
		 */
		public function resetScroll():void{
			this.tab.y = (this._minScroll);
			doScroll(new DragEvent(DragEvent.DRAG));
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void 
		{
			this._width = value;
			this.track.width = (value);
			this.tab.width = (value);
			this.setScroll();
			this.dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void 
		{
			this._height = value;
			this.track.height = (value);
			this.setScroll();
			this.dispatchEvent(new ComponentEvent(ComponentEvent.RESIZE));
		}
		/**
		 * for a movieclip the height of the masked clip
		 * for a textfield the bottom scroll property
		 * 
		 */
		public function set scrollSize(num:Number):void{
			this._scrollSize = num;
			this.setScroll();
		}
		public function get scrollSize():Number{
			if(this._scrollSize)return this._scrollSize;
			var ratio:Number = (track.height/_maxScroll);
			var size:Number = track.height*ratio;
			return size;
		}
		/**
		 * if movieclip set the y value to -((content height - mask height) * getLevel())
		 * if textfield scroll = Math.round(maxScroll * getLevel())
		 */
		public function get level():Number {
			//trace( "level : " + _scroll );
			return this._scroll;
		}
		public function set level(val:Number):void {
			//trace( "level : " + val );
			if (val < this._minScroll) val = this._minScroll;
			if (val > this._maxScroll) val = this._maxScroll;
			var scrollSpace:Number = this.scrollHeight-this.tab.height;
			var scrollPos:Number = val / this._maxScroll;
			this.tab.y = ((scrollPos*scrollSpace)+_minScroll);
			this.doScroll(new DragEvent(DragEvent.STOP));
		}
		protected function setScroll():void{
			this.scrollHeight = getScrollHeight();
			this.scrollRatio = getScrollRatio();
			this.tab.height = (this.scrollHeight * scrollRatio);
			
			if(this._maxScroll<=0){
				this.tab.height = (this.scrollHeight);
				this.tab.enabled = false;
				this.doScroll(new DragEvent(DragEvent.STOP));
				this.tab.y = (this.track.y);
				this.tab.x = (this.track.x);
				if(this.hideOnSelfDisable){;
					this.visible = false;
				}
			}else{
				if(this.hideOnSelfDisable){
					this.visible = true;
				}
				this.tab.enabled = true;
				if(this._scroll>this._maxScroll){
					level = (this._maxScroll);
				}
			}
			if (tab.height < minimumTabSize) tab.height = (minimumTabSize);
			this.tab.dragBounds = (new Rectangle(0, this.track.y, 0, this.getScrollLimit()));
		}

		protected function getScrollHeight():Number{
			return this.track.height;
		}
		protected function getScrollRatio():Number{
			var ratio:Number = _scrollSize/(this._maxScroll+1+_scrollSize);
			return ratio;
		}
		protected function getScrollLimit():Number{
			return this.scrollHeight - this.tab.height;
		}
		protected function doScroll(event:DragEvent):void {
			var scrollSpace:Number = this.scrollHeight-this.tab.height;
			var scrollPos:Number = (scrollSpace != 0) ? (this.tab.y-_minScroll)/scrollSpace : 0;
			this._scroll = Math.ceil(this._maxScroll * scrollPos);
			var outEvent:Event = new Event(Event.SCROLL);
			this.dispatchEvent(outEvent);
		}
		
		
		override public function get enabled():Boolean { return super.enabled; }
		
		override public function set enabled(value:Boolean):void 
		{
			super.enabled = value;
			this.tab.enabled = value;
		}
		override public function get tabIndex():int { return tab.tabIndex; }
		
		override public function set tabIndex(value:int):void 
		{
			tab.tabIndex = value;
		}
		override public function get tabEnabled():Boolean { return tab.tabEnabled; }
		
		override public function set tabEnabled(value:Boolean):void 
		{
			tab.tabEnabled = value;
		}
		override public function get useHandCursor():Boolean { return tab.useHandCursor; }
		
		override public function set useHandCursor(value:Boolean):void 
		{
			tab.useHandCursor = value;
		}
		override public function get doubleClickEnabled():Boolean { return tab.doubleClickEnabled; }
		
		override public function set doubleClickEnabled(value:Boolean):void 
		{
			tab.doubleClickEnabled = value;
		}
		
		public function get minimumTabSize():Number { return _minimumTabSize; }
		
		public function set minimumTabSize(value:Number):void 
		{
			_minimumTabSize = value;
		}
		
		/**
		 * for use with textfield
		 * max scroll is max scroll property of a
		 * textfield
		 * 
		 * for use with a movieclip
		 * the height of a movieclip - the visible / mask height
		 */
		public function get maxScroll():Number { return _maxScroll; }
		
		public function set maxScroll(value:Number):void 
		{
			_maxScroll = value;
			this.setScroll();
			this.resetScroll();
		}
		/**
		 * Scroll amount per mouse wheel click.
		 */
		public function get wheelSpeed():int { return _wheelSpeed; }
		
		public function set wheelSpeed(value:int):void 
		{
			_wheelSpeed = value;
		}
		override public function setFocus():void{
			this.tab.setFocus();
		}
		override public function getIsFocus():Boolean {
			return this.tab.getIsFocus();
		}
	}
}
