package com.lookmum.view 
{
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.media.SoundTransform;
	import flash.text.TextSnapshot;
	import flash.ui.ContextMenu;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public interface IComponent extends IEventDispatcher
	{
		function get target():MovieClip;
		function setFocus():void;
		function getIsFocus():Boolean;
		function destroy():void;
		//{region override MovieClip properties and methods
		
		/**
		 * Specifies the number of the frame in which the playhead is located in the timeline of the MovieClip instance.
		 */
		function get currentFrame () : int;

		/**
		 * The current label in which the playhead is located in the timeline of the MovieClip instance.
		 */
		function get currentLabel () : String;

		/**
		 * Returns an array of FrameLabel objects from the current scene.
		 */
		function get currentLabels () : Array;

		/**
		 * The current scene in which the playhead is located in the timeline of the MovieClip instance.
		 */
		function get currentScene () : Scene;

		/**
		 * A Boolean value that indicates whether a movie clip is enabled.
		 */
		function get enabled () : Boolean;
		function set enabled (value:Boolean) : void;

		/**
		 * The number of frames that are loaded from a streaming SWF file.
		 */
		function get framesLoaded () : int;

		/**
		 * An array of Scene objects, each listing the name, the number of frames, and the frame labels for a scene in the MovieClip instance.
		 */
		function get scenes () : Array;

		/**
		 * The total number of frames in the MovieClip instance.
		 */
		function get totalFrames () : int;

		/**
		 * Indicates whether other display objects that are SimpleButton or MovieClip objects can receive mouse release events.
		 */
		function get trackAsMenu () : Boolean;
		function set trackAsMenu (value:Boolean) : void ;

		/**
		 * [Undocumented] Takes a collection of frame (zero-based) - method pairs that associates a method with a frame on the timeline.
		 */
		/*
		function addFrameScript (frame:int, method:Function) : void;
		*/

		/**
		 * Starts playing the SWF file at the specified frame.
		 */
		function gotoAndPlay (frame:Object, scene:String = null) : void;

		/**
		 * Brings the playhead to the specified frame of the movie clip and stops it there.
		 */
		function gotoAndStop (frame:Object, scene:String = null) : void;

		/**
		 * Sends the playhead to the next frame and stops it.
		 */
		function nextFrame () : void;

		/**
		 * Moves the playhead to the next scene of the MovieClip instance.
		 */
		function nextScene () : void;

		/**
		 * Moves the playhead in the timeline of the movie clip.
		 */
		function play () : void;

		/**
		 * Sends the playhead to the previous frame and stops it.
		 */
		function prevFrame () : void;

		/**
		 * Moves the playhead to the previous scene of the MovieClip instance.
		 */
		function prevScene () : void;

		/**
		 * Stops the playhead in the movie clip.
		 */
		function stop () : void;
		
		//}
		
		//{region overriden Sprite properties and methods
		
		/**
		 * Specifies the button mode of this sprite.
		 */
		function get buttonMode () : Boolean;
		function set buttonMode (value:Boolean) : void;

		/**
		 * Specifies the display object over which the sprite is being dragged, or on which the sprite was dropped.
		 */
		function get dropTarget () : DisplayObject;

		/**
		 * Specifies the Graphics object that belongs to this sprite where vector drawing commands can occur.
		 */
		function get graphics () : Graphics;

		/**
		 * Designates another sprite to serve as the hit area for a sprite.
		 */
		function get hitArea () : Sprite;
		function set hitArea (value:Sprite) : void;

		/**
		 * Controls sound within this sprite.
		 */
		function get soundTransform () : SoundTransform;
		function set soundTransform (sndTransform:SoundTransform) : void;

		/**
		 * A Boolean value that indicates whether the pointing hand (hand cursor) appears when the mouse rolls over a sprite in which the buttonMode property is set to true.
		 */
		function get useHandCursor () : Boolean;
		function set useHandCursor (value:Boolean) : void;

		/**
		 * Lets the user drag the specified sprite.
		 */
		function startDrag (lockCenter:Boolean = false, bounds:Rectangle = null) : void;

		/**
		 * Ends the startDrag() method.
		 */
		function stopDrag () : void;

		function toString () : String;
		
		//}
		
		//{region overriden DisplayObjectContainer properties and methods
		
		/**
		 * Determines whether or not the children of the object are mouse enabled.
		 */
		function get mouseChildren () : Boolean;
		function set mouseChildren (enable:Boolean) : void;

		/**
		 * Returns the number of children of this object.
		 */
		function get numChildren () : int;

		/**
		 * Determines whether the children of the object are tab enabled.
		 */
		function get tabChildren () : Boolean;
		function set tabChildren (enable:Boolean) : void;

		/**
		 * Returns a TextSnapshot object for this DisplayObjectContainer instance.
		 */
		function get textSnapshot () : TextSnapshot;

		/**
		 * Adds a child object to this DisplayObjectContainer instance.
		 */
		function addChild (child:DisplayObject) : DisplayObject;

		/**
		 * Adds a child object to this DisplayObjectContainer instance.
		 */
		function addChildAt (child:DisplayObject, index:int) : DisplayObject;

		/**
		 * Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point.
		 */
		function areInaccessibleObjectsUnderPoint (point:Point) : Boolean;

		/**
		 * Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself.
		 */
		function contains (child:DisplayObject) : Boolean;

		/**
		 * Returns the child display object instance that exists at the specified index.
		 */
		function getChildAt (index:int) : DisplayObject;

		/**
		 * Returns the child display object that exists with the specified name.
		 */
		function getChildByName (name:String) : DisplayObject;

		/**
		 * Returns the index number of a child DisplayObject instance.
		 */
		function getChildIndex (child:DisplayObject) : int;

		/**
		 * Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance.
		 */
		function getObjectsUnderPoint (point:Point) : Array;

		/**
		 * Removes a child display object from the DisplayObjectContainer instance.
		 */
		function removeChild (child:DisplayObject) : DisplayObject;

		/**
		 * Removes a child display object, at the specified index position, from the DisplayObjectContainer instance.
		 */
		function removeChildAt (index:int) : DisplayObject;

		/**
		 * Changes the index number of an existing child.
		 */
		function setChildIndex (child:DisplayObject, index:int) : void;

		/**
		 * Swaps the z-order (front-to-back order) of the two specified child objects.
		 */
		function swapChildren (child1:DisplayObject, child2:DisplayObject) : void;

		/**
		 * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
		 */
		function swapChildrenAt (index1:int, index2:int) : void;
		
		//}
		
		//{region overriden InteractiveObject properties and methods
		
		function get accessibilityImplementation () : AccessibilityImplementation;
		function set accessibilityImplementation (value:AccessibilityImplementation) : void;

		/**
		 * Specifies the context menu associated with this object.
		 */
		function get contextMenu () : ContextMenu;
		function set contextMenu (cm:ContextMenu) : void;

		/**
		 * Specifies whether the object receives doubleClick events.
		 */
		function get doubleClickEnabled () : Boolean;
		function set doubleClickEnabled (enabled:Boolean) : void;

		/**
		 * Specifies whether this object displays a focus rectangle.
		 */
		function get focusRect () : Object;
		function set focusRect (focusRect:Object) : void;

		/**
		 * Specifies whether this object receives mouse messages.
		 */
		function get mouseEnabled () : Boolean;
		function set mouseEnabled (enabled:Boolean) : void;

		/**
		 * Specifies whether this object is in the tab order.
		 */
		function get tabEnabled () : Boolean;
		function set tabEnabled (enabled:Boolean) : void;

		/**
		 * Specifies the tab ordering of objects in a SWF file.
		 */
		function get tabIndex () : int;
		function set tabIndex (index:int) : void;
		
		//}
		
		//{region overriden DisplayObject properties and methods
		
		/**
		 * The current accessibility options for this display object.
		 */
		function get accessibilityProperties () : AccessibilityProperties;
		function set accessibilityProperties (value:AccessibilityProperties) : void;

		/**
		 * Indicates the alpha transparency value of the object specified.
		 */
		function get alpha () : Number;
		function set alpha (value:Number) : void;

		/**
		 * A value from the BlendMode class that specifies which blend mode to use.
		 */
		function get blendMode () : String;
		function set blendMode (value:String) : void;

		/**
		 * If set to true, Flash Player caches an internal bitmap representation of the display object.
		 */
		function get cacheAsBitmap () : Boolean;
		function set cacheAsBitmap (value:Boolean) : void;

		/**
		 * An indexed array that contains each filter object currently associated with the display object.
		 */
		function get filters () : Array;
		function set filters (value:Array) : void;

		/**
		 * Indicates the height of the display object, in pixels.
		 */
		function get height () : Number;
		function set height (value:Number) : void;

		/**
		 * Returns a LoaderInfo object containing information about loading the file to which this display object belongs.
		 */
		function get loaderInfo () : LoaderInfo;

		/**
		 * The calling display object is masked by the specified mask object.
		 */
		function get mask () : DisplayObject;
		function set mask (value:DisplayObject) : void;

		/**
		 * Indicates the x coordinate of the mouse position, in pixels.
		 */
		function get mouseX () : Number;

		/**
		 * Indicates the y coordinate of the mouse position, in pixels.
		 */
		function get mouseY () : Number;

		/**
		 * Indicates the instance name of the DisplayObject.
		 */
		function get name () : String;
		function set name (value:String) : void;

		/**
		 * Specifies whether the display object is opaque with a certain background color.
		 */
		function get opaqueBackground () : Object;
		function set opaqueBackground (value:Object) : void;

		/**
		 * Indicates the DisplayObjectContainer object that contains this display object.
		 */
		function get parent () : DisplayObjectContainer;

		/**
		 * For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.
		 */
		function get root () : DisplayObject;

		/**
		 * Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation.
		 */
		function get rotation () : Number;
		function set rotation (value:Number) : void;

		/**
		 * The current scaling grid that is in effect.
		 */
		function get scale9Grid () : Rectangle;
		function set scale9Grid (innerRectangle:Rectangle) : void;

		/**
		 * Indicates the horizontal scale (percentage) of the object as applied from the registration point.
		 */
		function get scaleX () : Number;
		function set scaleX (value:Number) : void;

		/**
		 * Indicates the vertical scale (percentage) of an object as applied from the registration point of the object.
		 */
		function get scaleY () : Number;
		function set scaleY (value:Number) : void;

		/**
		 * The scroll rectangle bounds of the display object.
		 */
		function get scrollRect () : Rectangle;
		function set scrollRect (value:Rectangle) : void;

		/**
		 * The Stage of the display object.
		 */
		function get stage () : Stage;

		/**
		 * An object with properties pertaining to a display object's matrix, color transform, and pixel bounds.
		 */
		function get transform () : Transform;
		function set transform (value:Transform) : void;

		/**
		 * Indicates the width of the display object, in pixels.
		 */
		function get width () : Number;
		function set width (value:Number) : void;

		/**
		 * Whether or not the display object is visible.
		 */
		function get visible () : Boolean;
		function set visible (value:Boolean) : void;

		/**
		 * Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		 */
		function get x () : Number;
		function set x (value:Number) : void;

		/**
		 * Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
		 */
		function get y () : Number;
		function set y (value:Number) : void;


		/**
		 * Returns a rectangle that defines the area of the display object relative to the coordinate system of the targetCoordinateSpace object.
		 */
		function getBounds (targetCoordinateSpace:DisplayObject) : Rectangle;

		/**
		 * Returns a rectangle that defines the boundary of the display object, based on the coordinate system defined by the targetCoordinateSpace parameter, excluding any strokes on shapes.
		 */
		function getRect (targetCoordinateSpace:DisplayObject) : Rectangle;

		/**
		 * Converts the point object from Stage (global) coordinates to the display object's (local) coordinates.
		 */
		function globalToLocal (point:Point) : Point;

		/**
		 * Evaluates the display object to see if it overlaps or intersects with the display object passed as a parameter.
		 */
		function hitTestObject (obj:DisplayObject) : Boolean;

		/**
		 * Evaluates the display object to see if it overlaps or intersects with a point specified by x and y.
		 */
		function hitTestPoint (x:Number, y:Number, shapeFlag:Boolean = false) : Boolean;

		/**
		 * Converts the point object from the display object's (local) coordinates to the Stage (global) coordinates.
		 */
		function localToGlobal (point:Point) : Point;
		//}
		
	}
	
}