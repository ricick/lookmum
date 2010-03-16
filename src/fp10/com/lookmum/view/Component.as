package com.lookmum.view 
{
	import com.lookmum.events.ComponentEvent;
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.media.SoundTransform;
	import flash.text.TextSnapshot;
	import flash.ui.ContextMenu;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Dispatched after a component changes size
	 * @eventType com.lookmum.events.ComponentEvent.RESIZE
	 */
	[Event(name="resize", type="com.lookmum.events.ComponentEvent")]
	
	/**
	 * Dispatched after a component changes size
	 * @eventType com.lookmum.events.ComponentEvent.MOVE
	 */
	[Event(name="move", type="com.lookmum.events.ComponentEvent")]
	
	/**
	 * Dispatched after a component shows
	 * @eventType com.lookmum.events.ComponentEvent.SHOW
	 */
	[Event(name="show", type="com.lookmum.events.ComponentEvent")]
	
	/**
	 * Dispatched after a component hides
	 * @eventType com.lookmum.events.ComponentEvent.HIDE
	 */
	[Event(name="hide", type="com.lookmum.events.ComponentEvent")]
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class Component extends MovieClip implements IComponent
	{
		
		private var _target:MovieClip;
		public function Component(target:MovieClip) 
		{
			if (!target) {
				throw new Error('No MovieClip supplied to Component ' + getQualifiedClassName(this));
			}
			_target = target;
			createChildren();
			//addEventListeners();
			super.addEventListener(Event.ADDED, onAdded);
			arrangeComponents();
		}
		/**
		 * Listen for added to stage. If component itself is added, swap with target.
		 * @param	e
		 */
		private function onAdded(e:Event):void 
		{
			var _parent:DisplayObjectContainer = super.parent;
			if (!_parent) return;
			e.stopImmediatePropagation();
			var index:int = _parent.getChildIndex(this);
			_parent.removeChild(this);
			_parent.addChildAt(target, index);
		}
		/**
		 * Return the MovieClip being controlled by the component.
		 */
		public function get target():MovieClip { return _target; }
		
		
		//{region event listeners
		override public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void {
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			target.addEventListener(type, onEvent, useCapture, priority, useWeakReference);
		}
		
		protected function onEvent(e:Event):void {
			dispatchEvent(e.clone());
		}

		/// Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		override public function hasEventListener (type:String) : Boolean{
			return target.hasEventListener(type);
		}

		/// Removes a listener from the EventDispatcher object.
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			super.removeEventListener(type, listener, useCapture);
			target.removeEventListener(type, listener, useCapture);
		}

		/// Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		override public function willTrigger (type:String) : Boolean{
			return target.willTrigger(type);
		}
		//}
		/**
		 * Create any child components
		 */
		protected function createChildren():void {
			
		}
		/**
		 * Arrange any child components
		 */
		protected function arrangeComponents():void{
			
		}
		public function setFocus():void {
			if (stage) {
				stage.focus = target;
			}
		}
		public function getIsFocus():Boolean {
			return (stage) ? stage.focus == target : false;
			
		}
		/**
		 * Destroy the component and remove it from the display list.
		 */
		public function destroy():void{
			if (parent) {
				parent.removeChild(target);
			}
		}
		
		//{region override MovieClip properties and methods
		
		/**
		 * Specifies the number of the frame in which the playhead is located in the timeline of the MovieClip instance.
		 */
		override public function get currentFrame () : int {
			return target.currentFrame;
		}

		/**
		 * The current label in which the playhead is located in the timeline of the MovieClip instance.
		 */
		override public function get currentLabel () : String {
			return target.currentLabel;
		}
		/**
		 * The label at the current frame in the timeline of the MovieClip instance.
		 */
		/*
		override public function get currentFrameLabel () : String {
			return target.currentFrameLabel;
		}
		*/
		/**
		 * Returns an array of FrameLabel objects from the current scene.
		 */
		override public function get currentLabels () : Array {
			return target.currentLabels;
		}

		/**
		 * The current scene in which the playhead is located in the timeline of the MovieClip instance.
		 */
		override public function get currentScene () : Scene {
			return target.currentScene;
		}

		/**
		 * A Boolean value that indicates whether a movie clip is enabled.
		 */
		override public function get enabled () : Boolean {
			return target.enabled;
		}
		override public function set enabled (value:Boolean) : void {
			target.enabled = value;
		}

		/**
		 * The number of frames that are loaded from a streaming SWF file.
		 */
		override public function get framesLoaded () : int {
			return target.framesLoaded;
		}

		/**
		 * An array of Scene objects, each listing the name, the number of frames, and the frame labels for a scene in the MovieClip instance.
		 */
		override public function get scenes () : Array {
			return target.scenes;
		}

		/**
		 * The total number of frames in the MovieClip instance.
		 */
		override public function get totalFrames () : int {
			return target.totalFrames;
		}

		/**
		 * Indicates whether other display objects that are SimpleButton or MovieClip objects can receive mouse release events.
		 */
		override public function get trackAsMenu () : Boolean {
			return target.trackAsMenu;
		}
		override public function set trackAsMenu (value:Boolean) : void {
			target.trackAsMenu = value;
		}

		/**
		 * [Undocumented] Takes a collection of frame (zero-based) - method pairs that associates a method with a frame on the timeline.
		 */
		/*
		override public function addFrameScript (frame:int, method:Function) : void {
			return target.addFrameScript(frame, method);
		}
		*/

		/**
		 * Starts playing the SWF file at the specified frame.
		 */
		override public function gotoAndPlay (frame:Object, scene:String = null) : void {
			return target.gotoAndPlay(frame, scene);
		}

		/**
		 * Brings the playhead to the specified frame of the movie clip and stops it there.
		 */
		override public function gotoAndStop (frame:Object, scene:String = null) : void {
			return target.gotoAndStop(frame, scene);
		}

		/**
		 * Sends the playhead to the next frame and stops it.
		 */
		override public function nextFrame () : void {
			return target.nextFrame();
		}

		/**
		 * Moves the playhead to the next scene of the MovieClip instance.
		 */
		override public function nextScene () : void {
			return target.nextScene();
		}

		/**
		 * Moves the playhead in the timeline of the movie clip.
		 */
		override public function play () : void {
			return target.play();
		}

		/**
		 * Sends the playhead to the previous frame and stops it.
		 */
		override public function prevFrame () : void {
			return target.prevFrame();
		}

		/**
		 * Moves the playhead to the previous scene of the MovieClip instance.
		 */
		override public function prevScene () : void {
			return target.prevScene();
		}

		/**
		 * Stops the playhead in the movie clip.
		 */
		override public function stop () : void {
			return target.stop();
		}
		
		//}
		
		//{region overriden Sprite properties and methods
		
		/**
		 * Specifies the button mode of this sprite.
		 */
		override public function get buttonMode () : Boolean {
			return target.buttonMode;
		}
		override public function set buttonMode (value:Boolean) : void {
			target.buttonMode = value;
		}

		/**
		 * Specifies the display object over which the sprite is being dragged, or on which the sprite was dropped.
		 */
		override public function get dropTarget () : DisplayObject {
			return target.dropTarget;
		}

		/**
		 * Specifies the Graphics object that belongs to this sprite where vector drawing commands can occur.
		 */
		override public function get graphics () : Graphics {
			return target.graphics;
		}

		/**
		 * Designates another sprite to serve as the hit area for a sprite.
		 */
		override public function get hitArea () : Sprite {
			return target.hitArea;
		}
		override public function set hitArea (value:Sprite) : void {
			target.hitArea = value;
		}

		/**
		 * Controls sound within this sprite.
		 */
		override public function get soundTransform () : SoundTransform {
			return target.soundTransform;
		}
		override public function set soundTransform (sndTransform:SoundTransform) : void{
			target.soundTransform = sndTransform;
		}

		/**
		 * A Boolean value that indicates whether the pointing hand (hand cursor) appears when the mouse rolls over a sprite in which the buttonMode property is set to true.
		 */
		override public function get useHandCursor () : Boolean {
			return target.useHandCursor;
		}
		override public function set useHandCursor (value:Boolean) : void {
			target.useHandCursor = value;
		}

		/**
		 * Lets the user drag the specified sprite.
		 */
		override public function startDrag (lockCenter:Boolean = false, bounds:Rectangle = null) : void {
			return target.startDrag(lockCenter, bounds);
		}

		/**
		 * Ends the startDrag() method.
		 */
		override public function stopDrag () : void {
			return target.stopDrag();
		}

		override public function toString () : String {
			return "[object "+getQualifiedClassName(this)+"]";
		}
		
		//}
		
		//{region overriden DisplayObjectContainer properties and methods
		
		/**
		 * Determines whether or not the children of the object are mouse enabled.
		 */
		override public function get mouseChildren () : Boolean {
			return target.mouseChildren;
		}
		override public function set mouseChildren (enable:Boolean) : void {
			target.mouseChildren = enable;
		}

		/**
		 * Returns the number of children of this object.
		 */
		override public function get numChildren () : int {
			return target.numChildren;
		}

		/**
		 * Determines whether the children of the object are tab enabled.
		 */
		override public function get tabChildren () : Boolean {
			return target.tabChildren;
		}
		override public function set tabChildren (enable:Boolean) : void {
			target.tabChildren = enable;
		}

		/**
		 * Returns a TextSnapshot object for this DisplayObjectContainer instance.
		 */
		override public function get textSnapshot () : TextSnapshot {
			return target.textSnapshot;
		}

		/**
		 * Adds a child object to this DisplayObjectContainer instance.
		 */
		override public function addChild (child:DisplayObject) : DisplayObject{
			return target.addChild(child);
		}

		/**
		 * Adds a child object to this DisplayObjectContainer instance.
		 */
		override public function addChildAt (child:DisplayObject, index:int) : DisplayObject{
			return target.addChildAt(child, index);
		}

		/**
		 * Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point.
		 */
		override public function areInaccessibleObjectsUnderPoint (point:Point) : Boolean {
			return target.areInaccessibleObjectsUnderPoint(point);
		}

		/**
		 * Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.
		 */
		override public function contains (child:DisplayObject) : Boolean{
			return target.contains(child);
		}

		/**
		 * Returns the child display object instance that exists at the specified index.
		 */
		override public function getChildAt (index:int) : DisplayObject{
			return target.getChildAt(index);
		}

		/**
		 * Returns the child display object that exists with the specified name.
		 */
		override public function getChildByName (name:String) : DisplayObject{
			return target.getChildByName(name);
		}

		/**
		 * Returns the index number of a child DisplayObject instance.
		 */
		override public function getChildIndex (child:DisplayObject) : int{
			return target.getChildIndex(child);
		}

		/**
		 * Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.
		 */
		override public function getObjectsUnderPoint (point:Point) : Array{
			return target.getObjectsUnderPoint(point);
		}

		/**
		 * Removes a child display object from the DisplayObjectContainer instance.
		 */
		override public function removeChild (child:DisplayObject) : DisplayObject{
			return target.removeChild(child);
		}

		/**
		 * Removes a child display object, at the specified index position, from the DisplayObjectContainer instance.
		 */
		override public function removeChildAt (index:int) : DisplayObject{
			return target.removeChildAt(index);
		}

		/**
		 * Changes the index number of an existing child.
		 */
		override public function setChildIndex (child:DisplayObject, index:int) : void{
			return target.setChildIndex(child, index);
		}

		/**
		 * Swaps the z-order (front-to-back order) of the two specified child objects.
		 */
		override public function swapChildren (child1:DisplayObject, child2:DisplayObject) : void {
			return swapChildren(child1, child2);
		}

		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
		 */
		override public function swapChildrenAt (index1:int, index2:int) : void {
			target.swapChildrenAt(index1, index2);
		}
		
		//}
		
		//{region overriden InteractiveObject properties and methods
		
		override public function get accessibilityImplementation () : AccessibilityImplementation {
			return target.accessibilityImplementation;
		}
		override public function set accessibilityImplementation (value:AccessibilityImplementation) : void {
			target.accessibilityImplementation = value;
		}

		/**
		 * Specifies the context menu associated with this object.
		 */
		/*
		override public function get contextMenu():ContextMenu { return target.contextMenu; }
		
		override public function set contextMenu(value:ContextMenu):void 
		{
			target.contextMenu = value;
		}
		*/
		/**
		 * Specifies whether the object receives doubleClick events.
		 */
		override public function get doubleClickEnabled () : Boolean {
			return target.doubleClickEnabled;
		}
		override public function set doubleClickEnabled (enabled:Boolean) : void{
			target.doubleClickEnabled = enabled;
		}

		/**
		 * Specifies whether this object displays a focus rectangle.
		 */
		override public function get focusRect () : Object {
			return target.focusRect;
		}
		override public function set focusRect (focusRect:Object) : void {
			target.focusRect = focusRect;
		}

		/**
		 * Specifies whether this object receives mouse messages.
		 */
		override public function get mouseEnabled () : Boolean {
			return target.mouseEnabled;
		}
		override public function set mouseEnabled (enabled:Boolean) : void{
			target.mouseEnabled = enabled;
		}

		/**
		 * Specifies whether this object is in the tab order.
		 */
		override public function get tabEnabled () : Boolean {
			return target.tabEnabled;
		}
		override public function set tabEnabled (enabled:Boolean) : void {
			target.tabEnabled = enabled;
		}

		/**
		 * Specifies the tab ordering of objects in a SWF file.
		 */
		override public function get tabIndex () : int {
			return target.tabIndex;
		}
		override public function set tabIndex (index:int) : void {
			target.tabIndex = index;
		}
		
		//}
		
		//{region overriden DisplayObject properties and methods
		
		/**
		 * The current accessibility options for this display object.
		 */
		override public function get accessibilityProperties () : AccessibilityProperties {
			return target.accessibilityProperties;
		}
		override public function set accessibilityProperties (value:AccessibilityProperties) : void {
			target.accessibilityProperties = value;
		}

		/**
		 * Indicates the alpha transparency value of the object specified.
		 */
		override public function get alpha () : Number{
			return target.alpha;
		}
		override public function set alpha (value:Number) : void{
			target.alpha = value;
		}

		/**
		 * A value from the BlendMode class that specifies which blend mode to use.
		 */
		override public function get blendMode () : String{
			return target.blendMode;
		}
		override public function set blendMode (value:String) : void{
			target.blendMode = value;
		}

		/**
		 * If set to true, Flash Player caches an internal bitmap representation of the display object.
		 */
		override public function get cacheAsBitmap () : Boolean{
			return target.cacheAsBitmap;
		}
		override public function set cacheAsBitmap (value:Boolean) : void{
			target.cacheAsBitmap = value;
		}

		/**
		 * An indexed array that contains each filter object currently associated with the display object.
		 */
		override public function get filters () : Array{
			return target.filters;
		}
		override public function set filters (value:Array) : void{
			target.filters = value;
		}

		/**
		 * Indicates the height of the display object, in pixels.
		 */
		override public function get height () : Number{
			return target.height;
		}
		override public function set height (value:Number) : void {
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.RESIZE);
			target.height = value;
			dispatchEvent(event);
		}

		/**
		 * Returns a LoaderInfo object containing information about loading the file to which this display object belongs.
		 */
		override public function get loaderInfo () : LoaderInfo{
			return target.loaderInfo;
		}

		/**
		 * The calling display object is masked by the specified mask object.
		 */
		override public function get mask () : DisplayObject{
			return target.mask;
		}
		override public function set mask (value:DisplayObject) : void{
			target.mask = value;
		}

		/**
		 * Indicates the x coordinate of the mouse position, in pixels.
		 */
		override public function get mouseX () : Number{
			return target.mouseX;
		}

		/**
		 * Indicates the y coordinate of the mouse position, in pixels.
		 */
		override public function get mouseY () : Number{
			return target.mouseY;
		}

		/**
		 * Indicates the instance name of the DisplayObject.
		 */
		override public function get name () : String{
			return target.name;
		}
		override public function set name (value:String) : void{
			target.name = value;
		}

		/**
		 * Specifies whether the display object is opaque with a certain background color.
		 */
		override public function get opaqueBackground () : Object{
			return target.opaqueBackground;
		}
		override public function set opaqueBackground (value:Object) : void{
			target.opaqueBackground = value;
		}

		/**
		 * Indicates the DisplayObjectContainer object that contains this display object.
		 */
		override public function get parent () : DisplayObjectContainer {
			return target.parent;
		}

		/**
		 * For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.
		 */
		override public function get root () : DisplayObject{
			return target.root;
		}

		/**
		 * Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation.
		 */
		override public function get rotation () : Number{
			return target.rotation;
		}
		override public function set rotation (value:Number) : void{
			target.rotation = value;
		}
		/// Indicates the x-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
		override public function get rotationX () : Number{
			return target.rotationX;
		}
		override public function set rotationX (value:Number) : void{
			target.rotationX = value;
		}

		/// Indicates the y-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
		override public function get rotationY () : Number{
			return target.rotationY;
		}
		override public function set rotationY (value:Number) : void{
			target.rotationY = value;
		}

		/// Indicates the z-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
		override public function get rotationZ () : Number{
			return target.rotationZ;
		}
		override public function set rotationZ (value:Number) : void{
			target.rotationZ = value;
		}

		/**
		 * The current scaling grid that is in effect.
		 */
		override public function get scale9Grid () : Rectangle{
			return target.scale9Grid;
		}
		override public function set scale9Grid (innerRectangle:Rectangle) : void{
			target.scale9Grid = innerRectangle;
		}

		/**
		 * Indicates the horizontal scale (percentage) of the object as applied from the registration point.
		 */
		override public function get scaleX () : Number{
			return target.scaleX;
		}
		override public function set scaleX (value:Number) : void{
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.RESIZE);
			target.scaleX = value;
			dispatchEvent(event);
		}

		/**
		 * Indicates the vertical scale (percentage) of an object as applied from the registration point of the object.
		 */
		override public function get scaleY () : Number{
			return target.scaleY;
		}
		override public function set scaleY (value:Number) : void{
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.RESIZE);
			target.scaleY = value;
			dispatchEvent(event);
		}

		/**
		 * The scroll rectangle bounds of the display object.
		 */
		override public function get scrollRect () : Rectangle{
			return target.scrollRect;
		}
		override public function set scrollRect (value:Rectangle) : void{
			target.scrollRect = value;
		}

		/**
		 * The Stage of the display object.
		 */
		override public function get stage () : Stage{
			return target.stage;
		}

		/**
		 * An object with properties pertaining to a display object's matrix, color transform, and pixel bounds.
		 */
		override public function get transform () : Transform{
			return target.transform;
		}
		override public function set transform (value:Transform) : void{
			target.transform = value;
		}

		/**
		 * Indicates the width of the display object, in pixels.
		 */
		override public function get width () : Number{
			return target.width;
		}
		override public function set width (value:Number) : void{
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.RESIZE);
			target.width = value;
			dispatchEvent(event);
		}

		/**
		 * Whether or not the display object is visible.
		 */
		override public function get visible () : Boolean{
			return target.visible;
		}
		override public function set visible (value:Boolean) : void{
			target.visible = value;
			if (visible) {
				dispatchEvent(new ComponentEvent(ComponentEvent.SHOW));
			}else {
				dispatchEvent(new ComponentEvent(ComponentEvent.HIDE));
			}
		}

		/**
		 * Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		 */
		override public function get x () : Number{
			return target.x;
		}
		override public function set x (value:Number) : void {
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.MOVE);
			target.x = value;
			dispatchEvent(event);
		}

		/**
		 * Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		 */
		override public function get y () : Number{
			return target.y;
		}
		override public function set y (value:Number) : void{
			var event:ComponentEvent = new ComponentEvent(ComponentEvent.MOVE);
			target.y = value;
			dispatchEvent(event);
		}


		/**
		 * Returns a rectangle that defines the area of the display object relative to the coordinate system of the targetCoordinateSpace object.
		 */
		override public function getBounds (targetCoordinateSpace:DisplayObject) : Rectangle{
			return target.getBounds(targetCoordinateSpace);
		}

		/**
		 * Returns a rectangle that defines the boundary of the display object, based on the coordinate system defined by the targetCoordinateSpace parameter, excluding any strokes on shapes.
		 */
		override public function getRect (targetCoordinateSpace:DisplayObject) : Rectangle{
			return target.getRect(targetCoordinateSpace);
		}

		/**
		 * Converts the point object from Stage (global) coordinates to the display object's (local) coordinates.
		 */
		override public function globalToLocal (point:Point) : Point{
			return target.globalToLocal(point);
		}

		/**
		 * Evaluates the display object to see if it overlaps or intersects with the display object passed as a parameter.
		 */
		override public function hitTestObject (obj:DisplayObject) : Boolean{
			return target.hitTestObject(obj);
		}

		/**
		 * Evaluates the display object to see if it overlaps or intersects with a point specified by x and y.
		 */
		override public function hitTestPoint (x:Number, y:Number, shapeFlag:Boolean = false) : Boolean{
			return target.hitTestPoint(x, y, shapeFlag);
		}

		/**
		 * Converts the point object from the display object's (local) coordinates to the Stage (global) coordinates.
		 */
		override public function localToGlobal (point:Point) : Point{
			return target.localToGlobal(point);
		}
		//}
		
	}

}