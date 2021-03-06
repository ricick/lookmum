package com.lookmum.view 
{
	import com.lookmum.view.Button;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	/**
	 * Flash Player dispatches the textInput event when a user enters one or more characters of text.
	 * @eventType flash.events.TextEvent.TEXT_INPUT
	 */
	[Event(name="textInput", type="flash.events.TextEvent")] 

	/**
	 * Dispatched by a TextField object after the user scrolls.
	 * @eventType flash.events.Event.SCROLL
	 */
	[Event(name="scroll", type="flash.events.Event")] 

	/**
	 * Dispatched when a user clicks a hyperlink in an HTML-enabled text field, where the URL begins with "event:".
	 * @eventType flash.events.TextEvent.LINK
	 */
	[Event(name="link", type="flash.events.TextEvent")] 

	/**
	 * Dispatched after a control value is modified, unlike the textInput event, which is dispatched before the value is modified.
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class LabelButton extends Button implements ITextComponent
	{
		
		protected var textField:TextField;
		protected var bg:MovieClip;
		protected var textFieldDimensions:Rectangle;
		protected var bgDimensions:Rectangle;
		private var _textFormatRollOver:TextFormat;
		private var _textFormatRollOut:TextFormat;
		private var _textFormatPress:TextFormat;
		private var _textFormatDisable:TextFormat;
		protected var currentTextFormat:TextFormat;
		public var autosizeBackground:Boolean = false;
		public function LabelButton(target:MovieClip) 
		{
			super(target);
			
		}
		override protected function createChildren():void 
		{
			super.createChildren();
			textField = getTextField();
			textField.mouseEnabled = false;
			textFieldDimensions = textField.getBounds(target);
			currentTextFormat = textField.getTextFormat();
			_textFormatRollOver = currentTextFormat;
			_textFormatRollOut = currentTextFormat;
			_textFormatPress = currentTextFormat;
			_textFormatDisable = currentTextFormat;
			if (target.getChildByName('bg')) {
				bg = target.getChildByName('bg') as MovieClip;
				bgDimensions = bg.getBounds(target);
				try {
					bg.gotoAndStop(FRAME_ROLL_OUT);
				} catch (e:Error) {
					//trace(e);
				}
			}
			//arrangeComponents();
		}
		override protected function arrangeComponents():void 
		{
			super.arrangeComponents();
			if (currentTextFormat) textField.setTextFormat(currentTextFormat);
			if (!bg) return;
			if(autosizeBackground){
				bg.height = textField.height + (bgDimensions.height - textFieldDimensions.height);
				bg.width = textField.width + (bgDimensions.width - textFieldDimensions.width);
			}
			dispatchEvent(new Event(Event.RESIZE));
		}
		/*
		override protected function addEventListeners():void 
		{
			super.addEventListeners();
			var eventList:Array = [
				TextEvent.TEXT_INPUT,
				TextEvent.LINK,
				Event.SCROLL,
				Event.CHANGE,
			]
			for each(var eventType:String in eventList) 
			{
				textField.addEventListener(eventType, onEvent, false, 0, true);
			}
		}
		*/
		protected function getTextField():TextField
		{
			return target.textField;
		}
		//text format setters
		
		
		public function set textFormatRollOver(value:TextFormat):void 
		{
			_textFormatRollOver = value;
		}
		
		public function set textFormatRollOut(value:TextFormat):void 
		{
			_textFormatRollOut = value;
		}
		
		public function set textFormatPress(value:TextFormat):void 
		{
			_textFormatPress = value;
		}
		
		public function set textFormatDisable(value:TextFormat):void 
		{
			_textFormatDisable = value;
		}
		
		
		
		//{region animations
		override protected function doEnable():void {
			super.doEnable();
			if (_textFormatDisable) currentTextFormat = (_textFormatRollOut);
			if (bg) {
				try {
					bg.gotoAndStop(FRAME_ROLL_OUT);
				} catch (e:Error) {
					//trace(e);
				}
			}
			arrangeComponents();
		}
		
		override protected function doDisable():void {
			super.doDisable();
			if (_textFormatDisable) currentTextFormat = (_textFormatDisable);
			if (bg) {
				try {
					bg.gotoAndStop(FRAME_DISABLE);
				} catch (e:Error) {
					//trace(e);
				}
			}
			arrangeComponents();
		}
		
		override public function set visible(value:Boolean):void 
		{
			super.visible = value;
			if (isMouseOutside)
				currentTextFormat = (_textFormatRollOut);
			arrangeComponents();
		}
		
		override protected function onRollOver(e:MouseEvent):void 
		{
			if (!enabled) {
				return;
			}
			
			super.onRollOver(e);
			
			if (_textFormatRollOver) currentTextFormat = (_textFormatRollOver);
			
			if (bg) {
				try {
					bg.gotoAndStop(FRAME_ROLL_OVER);
				} catch (e:Error) {
					//trace(e);
				}
			}
			arrangeComponents();
		}
		
		override protected function onRollOut(e:MouseEvent):void 
		{
			if (!enabled) {
				return;
			}
			
			super.onRollOut(e);
			
			if (_textFormatRollOut) currentTextFormat = (_textFormatRollOut);

			if (bg) {
				try {
					bg.gotoAndStop(FRAME_ROLL_OUT);
				} catch (e:Error) {
					//trace(e);
				}
			}
			arrangeComponents();
			
		}
		
		override protected function onMouseDown(e:MouseEvent):void 
		{
			if (!enabled) {
				return;
			}
			
			super.onMouseDown(e);
			
			if (_textFormatPress) currentTextFormat = (_textFormatPress);

			if (bg) {
				try {
					bg.gotoAndStop(FRAME_PRESS);
				} catch (e:Error) {
					//trace(e);
				}
			}
			arrangeComponents();
			
		}
		
		override protected function onMouseUp(e:MouseEvent):void 
		{
			if (!enabled) {
				return;
			}
			
			var out:Boolean = isMouseOutside;
			super.onMouseUp(e);
			
			if (!out && _textFormatRollOver) currentTextFormat = (_textFormatRollOver);

			if (bg) {
				if (out)
				{
					try {
						bg.gotoAndStop(FRAME_ROLL_OUT);
					} catch (e:Error) {
					//trace(e);
					}
				}
				else
				{
					try {
						bg.gotoAndStop(FRAME_ROLL_OVER);
					} catch (e:Error) {
						//trace(e);
					}
				}
				
			}
			arrangeComponents();
		}
		
		//}
		
		//{region overriden DisplayObject properties and methods
		
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void 
		{
			if(bg){
				bg.width = value;
				textField.width = bg.width - (bgDimensions.width - textFieldDimensions.width);
				arrangeComponents();
			}else {
				super.width = value;
			}
		}
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void 
		{
			if(bg){
				bg.height = value;
				textField.height = bg.height - (bgDimensions.height - textFieldDimensions.height);
				arrangeComponents();
			}else {
				super.height = value;
			}
		}
		
		//}
		
		//{region TextField methods and properties
		
		/**
		 * When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.
		 */
		public function get alwaysShowSelection () : Boolean {
			return textField.alwaysShowSelection;
		}
		public function set alwaysShowSelection (value:Boolean) : void {
			textField.alwaysShowSelection = value;
		}

		/**
		 * The type of anti-aliasing used for this text field.
		 */
		public function get antiAliasType () : String {
			return textField.antiAliasType;
		}
		public function set antiAliasType (antiAliasType:String) : void {
			textField.antiAliasType = antiAliasType;
			arrangeComponents();
		}

		/**
		 * Controls automatic sizing and alignment of text fields.
		 */
		public function get autoSize () : String {
			return textField.autoSize;
		}
		public function set autoSize (value:String) : void {
			textField.autoSize = value;
			arrangeComponents();
		}

		/**
		 * Specifies whether the text field has a background fill.
		 */
		public function get background () : Boolean {
			return textField.background;
		}
		public function set background (value:Boolean) : void {
			textField.background = value;
		}

		/**
		 * The color of the text field background.
		 */
		public function get backgroundColor () : uint {
			return textField.backgroundColor;
		}
		public function set backgroundColor (value:uint) : void {
			textField.backgroundColor = value;
		}

		/**
		 * Specifies whether the text field has a border.
		 */
		public function get border () : Boolean {
			return textField.border;
		}
		public function set border (value:Boolean) : void {
			textField.border = value;
		}

		/**
		 * The color of the text field border.
		 */
		public function get borderColor () : uint {
			return textField.borderColor;
		}
		public function set borderColor (value:uint) : void {
			textField.borderColor = value;
		}

		/**
		 * An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.
		 */
		public function get bottomScrollV () : int {
			return textField.bottomScrollV;
		}

		/**
		 * The index of the insertion point (caret) position.
		 */
		public function get caretIndex () : int {
			return textField.caretIndex;
		}

		/**
		 * A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.
		 */
		public function get condenseWhite () : Boolean {
			return textField.condenseWhite;
		}
		public function set condenseWhite (value:Boolean) : void {
			textField.condenseWhite = value;
		}

		/**
		 * Specifies the format applied to newly inserted text, such as text inserted with the replaceSelectedText() method or text entered by a user.
		 */
		public function get defaultTextFormat () : TextFormat {
			return textField.defaultTextFormat;
		}
		public function set defaultTextFormat (format:TextFormat) : void {
			textField.defaultTextFormat = format;
		}

		/**
		 * Specifies whether the text field is a password text field.
		 */
		public function get displayAsPassword () : Boolean {
			return textField.displayAsPassword;
		}
		public function set displayAsPassword (value:Boolean) : void {
			textField.displayAsPassword = value;
		}

		/**
		 * Specifies whether to render by using embedded font outlines.
		 */
		public function get embedFonts () : Boolean {
			return textField.embedFonts;
		}
		public function set embedFonts (value:Boolean) : void {
			textField.embedFonts = value;
		}

		/**
		 * The type of grid fitting used for this text field.
		 */
		public function get gridFitType () : String {
			return textField.gridFitType;
		}
		public function set gridFitType (gridFitType:String) : void {
			textField.gridFitType = gridFitType;
		}

		/**
		 * Contains the HTML representation of the text field contents.
		 */
		public function get htmlText () : String {
			return textField.htmlText;
		}
		public function set htmlText (value:String) : void {
			textField.htmlText = value;
			arrangeComponents();
		}

		/**
		 * The number of characters in a text field.
		 */
		public function get length () : int {
			return textField.length;
		}

		/**
		 * The maximum number of characters that the text field can contain, as entered by a user.
		 */
		public function get maxChars () : int {
			return textField.maxChars;
		}
		public function set maxChars (value:int) : void {
			textField.maxChars = value;
		}

		/**
		 * The maximum value of scrollH.
		 */
		public function get maxScrollH () : int {
			return textField.maxScrollH;
		}

		/**
		 * The maximum value of scrollV.
		 */
		public function get maxScrollV () : int {
			return textField.maxScrollV;
		}

		/**
		 * A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.
		 */
		public function get mouseWheelEnabled () : Boolean {
			return textField.mouseWheelEnabled;
		}
		public function set mouseWheelEnabled (value:Boolean) : void {
			textField.mouseWheelEnabled = value;
		}

		/**
		 * Indicates whether field is a multiline text field.
		 */
		public function get multiline () : Boolean {
			return textField.multiline;
		}
		public function set multiline (value:Boolean) : void {
			textField.multiline = value;
		}

		/**
		 * Defines the number of text lines in a multiline text field.
		 */
		public function get numLines () : int {
			return textField.numLines;
		}

		/**
		 * Indicates the set of characters that a user can enter into the text field.
		 */
		public function get restrict () : String {
			return textField.restrict;
		}
		public function set restrict (value:String) : void {
			textField.restrict = value;
		}

		/**
		 * The current horizontal scrolling position.
		 */
		public function get scrollH () : int {
			return textField.scrollH;
		}
		public function set scrollH (value:int) : void {
			textField.scrollH = value;
		}

		/**
		 * The vertical position of text in a text field.
		 */
		public function get scrollV () : int {
			return textField.scrollV;
		}
		public function set scrollV (value:int) : void {
			textField.scrollV = value;
		}

		/**
		 * A Boolean value that indicates whether the text field is selectable.
		 */
		public function get selectable () : Boolean {
			return textField.selectable;
		}
		public function set selectable (value:Boolean) : void {
			textField.selectable = value;
		}

		public function get selectedText () : String {
			return textField.selectedText;
		}

		/**
		 * The zero-based character index value of the first character in the current selection.
		 */
		public function get selectionBeginIndex () : int {
			return textField.selectionBeginIndex;
		}

		/**
		 * The zero-based character index value of the last character in the current selection.
		 */
		public function get selectionEndIndex () : int {
			return textField.selectionEndIndex;
		}

		/**
		 * The sharpness of the glyph edges in this text field.
		 */
		public function get sharpness () : Number {
			return textField.sharpness;
		}
		public function set sharpness (value:Number) : void {
			textField.sharpness = value;
		}

		/**
		 * Attaches a style sheet to the text field.
		 */
		public function get styleSheet () : StyleSheet {
			return textField.styleSheet;
		}
		public function set styleSheet (value:StyleSheet) : void {
			textField.styleSheet = value;
		}

		/**
		 * A string that is the current text in the text field.
		 */
		public function get text () : String {
			return textField.text;
		}
		public function set text (value:String) : void {
			textField.text = value;
			arrangeComponents();
		}

		/**
		 * The color of the text in a text field, in hexadecimal format.
		 */
		public function get textColor () : uint {
			return textField.textColor;
		}
		public function set textColor (value:uint) : void {
			textField.textColor = value;
		}

		/**
		 * The height of the text in pixels.
		 */
		public function get textHeight () : Number {
			return textField.textHeight;
		}

		/**
		 * The width of the text in pixels.
		 */
		public function get textWidth () : Number {
			return textField.textWidth;
		}

		/**
		 * The thickness of the glyph edges in this text field.
		 */
		public function get thickness () : Number {
			return textField.thickness;
		}
		public function set thickness (value:Number) : void {
			textField.thickness = value;
		}

		/**
		 * The type of the text field.
		 */
		public function get type () : String {
			return textField.type;
		}
		public function set type (value:String) : void {
			textField.type = value;
		}

		/**
		 * Specifies whether to copy and paste the text formatting along with the text.
		 */
		public function get useRichTextClipboard () : Boolean {
			return textField.useRichTextClipboard;
		}
		public function set useRichTextClipboard (value:Boolean) : void {
			textField.useRichTextClipboard = value;
		}

		/**
		 * A Boolean value that indicates whether the text field has word wrap.
		 */
		public function get wordWrap () : Boolean {
			return textField.wordWrap;
		}
		public function set wordWrap (value:Boolean) : void {
			textField.wordWrap = value;
			arrangeComponents();
		}

		/**
		 * Appends text to the end of the existing text of the TextField.
		 */
		public function appendText (newText:String) : void {
			textField.appendText(newText);
			arrangeComponents();
			return;
		}

		/**
		 * Returns a rectangle that is the bounding box of the character.
		 */
		public function getCharBoundaries (charIndex:int) : Rectangle {
			return textField.getCharBoundaries(charIndex);
		}

		/**
		 * Returns the zero-based index value of the character.
		 */
		public function getCharIndexAtPoint (x:Number, y:Number) : int {
			return textField.getCharIndexAtPoint(x,y);
		}

		/**
		 * The zero-based index value of the character.
		 */
		public function getFirstCharInParagraph (charIndex:int) : int {
			return textField.getFirstCharInParagraph(charIndex);
		}

		/**
		 * Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an <img> tag.
		 */
		public function getImageReference (id:String) : DisplayObject {
			return textField.getImageReference(id);
		}

		/**
		 * The zero-based index value of the line at a specified point.
		 */
		public function getLineIndexAtPoint (x:Number, y:Number) : int {
			return textField.getLineIndexAtPoint(x,y);
		}

		/**
		 * The zero-based index value of the line containing the character that the the charIndex parameter specifies.
		 */
		public function getLineIndexOfChar (charIndex:int) : int {
			return textField.getLineIndexOfChar(charIndex);
		}

		/**
		 * Returns the number of characters in a specific text line.
		 */
		public function getLineLength (lineIndex:int) : int {
			return textField.getLineLength(lineIndex);
		}

		/**
		 * Returns metrics information about a given text line.
		 */
		public function getLineMetrics (lineIndex:int) : TextLineMetrics {
			return textField.getLineMetrics(lineIndex);
		}

		/**
		 * The zero-based index value of the first character in the line.
		 */
		public function getLineOffset (lineIndex:int) : int {
			return textField.getLineOffset(lineIndex);
		}

		/**
		 * The text string contained in the specified line.
		 */
		public function getLineText (lineIndex:int) : String {
			return textField.getLineText(lineIndex);
		}

		/**
		 * The zero-based index value of the character.
		 */
		public function getParagraphLength (charIndex:int) : int {
			return textField.getParagraphLength(charIndex);
		}

		public function getRawText () : String {
			return textField.getRawText();
		}

		/**
		 * Returns a TextFormat object.
		 */
		public function getTextFormat (beginIndex:int = -1, endIndex:int = -1) : TextFormat {
			return textField.getTextFormat(beginIndex, endIndex);
		}

		public function getTextRuns (beginIndex:int = 0, endIndex:int = 2147483647) : Array {
			return textField.getTextRuns(beginIndex,endIndex);
		}

		public function getXMLText (beginIndex:int = 0, endIndex:int = 2147483647) : String {
			return textField.getXMLText(beginIndex,endIndex);
		}

		public function insertXMLText (beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void {
			textField.insertXMLText(beginIndex, endIndex, richText, pasting);
			arrangeComponents();
			return;
		}

		/**
		 * Replaces the current selection with the contents of the value parameter.
		 */
		public function replaceSelectedText (value:String) : void {
			textField.replaceSelectedText(value);
			arrangeComponents();
			return;
		}

		/**
		 * Replaces a range of characters.
		 */
		public function replaceText (beginIndex:int, endIndex:int, newText:String) : void {
			textField.replaceText(beginIndex,endIndex,newText);
			arrangeComponents();
			return;
		}

		/**
		 * Sets a new text selection.
		 */
		public function setSelection (beginIndex:int, endIndex:int) : void {
			return textField.setSelection(beginIndex,endIndex);
		}

		/**
		 * Applies text formatting.
		 */
		public function setTextFormat (format:TextFormat, beginIndex:int = -1, endIndex:int = -1) : void {
			textField.setTextFormat(format, beginIndex, endIndex);
			currentTextFormat = format;
			_textFormatRollOver = currentTextFormat;
			_textFormatRollOut = currentTextFormat;
			_textFormatPress = currentTextFormat;
			_textFormatDisable = currentTextFormat;
			arrangeComponents();
			return;
		}
		
		//}
		
	}

}