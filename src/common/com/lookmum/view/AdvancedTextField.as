package com.lookmum.view 
{
	import com.adobe.cairngorm.business.AbstractServices;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	/**
	 * ...
	 * @author Ben Huang
	 */
	public class AdvancedTextField extends TextField
	{
		protected var textField:TextField;
		private var orphans:int = 2;
		private var cacheHtmlText:String;
		
		public var lines: Array = new Array();
		
		override public function AdvancedTextField(target:TextField) 
		{
			textField = target;
		}
		
		override public function get height () : Number{
			return textField.height;
		}
		
		override public function set height(value:Number):void {
			textField.height = value;
		}
		
		override public function get width () : Number{
			return textField.width;
		}
		override public function set width(value:Number):void {
			textField.width = value;
		}
		
		override public function get x():Number 
		{
			return textField.x;
		}
		
		override public function set x(value:Number):void 
		{
			textField.x = value;
		}
		
		override public function get y():Number 
		{
			return textField.y;
		}
		
		override public function set y(value:Number):void 
		{
			textField.y = value;
		}
		
		override public function get tabEnabled():Boolean { return textField.tabEnabled; }
		
		override public function set tabEnabled(value:Boolean):void 
		{
			textField.tabEnabled = value;
		}
		override public function get tabIndex():int { return textField.tabIndex; }
		
		override public function set tabIndex(value:int):void 
		{
			textField.tabIndex = value;
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			textField.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.
		 */
		override public function get alwaysShowSelection () : Boolean {
			return textField.alwaysShowSelection;
		}
		override public function set alwaysShowSelection (value:Boolean) : void {
			textField.alwaysShowSelection = value;
		}

		/**
		 * The type of anti-aliasing used for this text field.
		 */
		override public function get antiAliasType () : String {
			return textField.antiAliasType;
		}
		override public function set antiAliasType (antiAliasType:String) : void {
			textField.antiAliasType = antiAliasType;
		}

		/**
		 * Controls automatic sizing and alignment of text fields.
		 */
		override public function get autoSize () : String {
			return textField.autoSize;
		}
		override public function set autoSize (value:String) : void {
			textField.autoSize = value;
		}

		/**
		 * Specifies whether the text field has a background fill.
		 */
		override public function get background () : Boolean {
			return textField.background;
		}
		override public function set background (value:Boolean) : void {
			textField.background = value;
		}

		/**
		 * The color of the text field background.
		 */
		override public function get backgroundColor () : uint {
			return textField.backgroundColor;
		}
		override public function set backgroundColor (value:uint) : void {
			textField.backgroundColor = value;
		}

		/**
		 * Specifies whether the text field has a border.
		 */
		override public function get border () : Boolean {
			return textField.border;
		}
		override public function set border (value:Boolean) : void {
			textField.border = value;
		}

		/**
		 * The color of the text field border.
		 */
		override public function get borderColor () : uint {
			return textField.borderColor;
		}
		override public function set borderColor (value:uint) : void {
			textField.borderColor = value;
		}

		/**
		 * An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.
		 */
		override public function get bottomScrollV () : int {
			return textField.bottomScrollV;
		}

		/**
		 * The index of the insertion point (caret) position.
		 */
		override public function get caretIndex () : int {
			return textField.caretIndex;
		}

		/**
		 * A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.
		 */
		override public function get condenseWhite () : Boolean {
			return textField.condenseWhite;
		}
		override public function set condenseWhite (value:Boolean) : void {
			textField.condenseWhite = value;
		}

		/**
		 * Specifies the format applied to newly inserted text, such as text inserted with the replaceSelectedText() method or text entered by a user.
		 */
		override public function get defaultTextFormat () : TextFormat {
			return textField.defaultTextFormat;
		}
		override public function set defaultTextFormat (format:TextFormat) : void {
			textField.defaultTextFormat = format;
		}

		/**
		 * Specifies whether the text field is a password text field.
		 */
		override public function get displayAsPassword () : Boolean {
			return textField.displayAsPassword;
		}
		override public function set displayAsPassword (value:Boolean) : void {
			textField.displayAsPassword = value;
		}

		/**
		 * Specifies whether to render by using embedded font outlines.
		 */
		override public function get embedFonts () : Boolean {
			return textField.embedFonts;
		}
		override public function set embedFonts (value:Boolean) : void {
			textField.embedFonts = value;
		}

		/**
		 * The type of grid fitting used for this text field.
		 */
		override public function get gridFitType () : String {
			return textField.gridFitType;
		}
		override public function set gridFitType (gridFitType:String) : void {
			textField.gridFitType = gridFitType;
		}

		/**
		 * Contains the HTML representation of the text field contents.
		 */
		override public function get htmlText () : String {
			return textField.htmlText;
		}
		override public function set htmlText (value:String) : void {
			cacheHtmlText = value;
			textField.text = value;
			processOrphan();
			
		}

		/**
		 * The number of characters in a text field.
		 */
		override public function get length () : int {
			return textField.length;
		}

		/**
		 * The maximum number of characters that the text field can contain, as entered by a user.
		 */
		override public function get maxChars () : int {
			return textField.maxChars;
		}
		override public function set maxChars (value:int) : void {
			textField.maxChars = value;
		}

		/**
		 * The maximum value of scrollH.
		 */
		override public function get maxScrollH () : int {
			return textField.maxScrollH;
		}

		/**
		 * The maximum value of scrollV.
		 */
		override public function get maxScrollV () : int {
			return textField.maxScrollV;
		}

		/**
		 * A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.
		 */
		override public function get mouseWheelEnabled () : Boolean {
			return textField.mouseWheelEnabled;
		}
		override public function set mouseWheelEnabled (value:Boolean) : void {
			textField.mouseWheelEnabled = value;
		}

		/**
		 * Indicates whether field is a multiline text field.
		 */
		override public function get multiline () : Boolean {
			return textField.multiline;
		}
		override public function set multiline (value:Boolean) : void {
			textField.multiline = value;
		}

		/**
		 * Defines the number of text lines in a multiline text field.
		 */
		override public function get numLines () : int {
			return textField.numLines;
		}

		/**
		 * Indicates the set of characters that a user can enter into the text field.
		 */
		override public function get restrict () : String {
			return textField.restrict;
		}
		override public function set restrict (value:String) : void {
			textField.restrict = value;
		}

		/**
		 * The current horizontal scrolling position.
		 */
		override public function get scrollH () : int {
			return textField.scrollH;
		}
		override public function set scrollH (value:int) : void {
			textField.scrollH = value;
		}

		/**
		 * The vertical position of text in a text field.
		 */
		override public function get scrollV () : int {
			return textField.scrollV;
		}
		override public function set scrollV (value:int) : void {
			textField.scrollV = value;
		}

		/**
		 * A Boolean value that indicates whether the text field is selectable.
		 */
		override public function get selectable () : Boolean {
			return textField.selectable;
		}
		override public function set selectable (value:Boolean) : void {
			textField.selectable = value;
		}

		override public function get selectedText () : String {
			return textField.selectedText;
		}

		/**
		 * The zero-based character index value of the first character in the current selection.
		 */
		override public function get selectionBeginIndex () : int {
			return textField.selectionBeginIndex;
		}

		/**
		 * The zero-based character index value of the last character in the current selection.
		 */
		override public function get selectionEndIndex () : int {
			return textField.selectionEndIndex;
		}

		/**
		 * The sharpness of the glyph edges in this text field.
		 */
		override public function get sharpness () : Number {
			return textField.sharpness;
		}
		override public function set sharpness (value:Number) : void {
			textField.sharpness = value;
		}

		/**
		 * Attaches a style sheet to the text field.
		 */
		override public function get styleSheet () : StyleSheet {
			return textField.styleSheet;
		}
		override public function set styleSheet (value:StyleSheet) : void {
			textField.styleSheet = value;
		}

		/**
		 * A string that is the current text in the text field.
		 */
		override public function get text () : String {
			return textField.text;
		}
		override public function set text (value:String) : void {
			cacheHtmlText = text;
			textField.text = value;
			processOrphan();
		}

		/**
		 * The color of the text in a text field, in hexadecimal format.
		 */
		override public function get textColor () : uint {
			return textField.textColor;
		}
		override public function set textColor (value:uint) : void {
			textField.textColor = value;
		}

		/**
		 * The height of the text in pixels.
		 */
		override public function get textHeight () : Number {
			return textField.textHeight;
		}

		/**
		 * The width of the text in pixels.
		 */
		override public function get textWidth () : Number {
			return textField.textWidth;
		}

		/**
		 * The thickness of the glyph edges in this text field.
		 */
		override public function get thickness () : Number {
			return textField.thickness;
		}
		override public function set thickness (value:Number) : void {
			textField.thickness = value;
		}

		/**
		 * The type of the text field.
		 */
		override public function get type () : String {
			return textField.type;
		}
		override public function set type (value:String) : void {
			textField.type = value;
		}

		/**
		 * Specifies whether to copy and paste the text formatting along with the text.
		 */
		override public function get useRichTextClipboard () : Boolean {
			return textField.useRichTextClipboard;
		}
		override public function set useRichTextClipboard (value:Boolean) : void {
			textField.useRichTextClipboard = value;
		}

		/**
		 * A Boolean value that indicates whether the text field has word wrap.
		 */
		override public function get wordWrap () : Boolean {
			return textField.wordWrap;
		}
		override public function set wordWrap (value:Boolean) : void {
			textField.wordWrap = value;
		}
		
		public function get orphan():int 
		{
			return orphans;
		}
		
		public function set orphan(value:int):void 
		{
			orphans = value;
		}

		/**
		 * Appends text to the end of the existing text of the TextField.
		 */
		override public function appendText (newText:String) : void {
			textField.appendText(newText);
			processOrphan();
		}

		/**
		 * Returns a rectangle that is the bounding box of the character.
		 */
		override public function getCharBoundaries (charIndex:int) : Rectangle {
			return textField.getCharBoundaries(charIndex);
		}

		/**
		 * Returns the zero-based index value of the character.
		 */
		override public function getCharIndexAtPoint (x:Number, y:Number) : int {
			return textField.getCharIndexAtPoint(x,y);
		}

		/**
		 * The zero-based index value of the character.
		 */
		override public function getFirstCharInParagraph (charIndex:int) : int {
			return textField.getFirstCharInParagraph(charIndex);
		}

		/**
		 * Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an <img> tag.
		 */
		override public function getImageReference (id:String) : DisplayObject {
			return textField.getImageReference(id);
		}

		/**
		 * The zero-based index value of the line at a specified point.
		 */
		override public function getLineIndexAtPoint (x:Number, y:Number) : int {
			return textField.getLineIndexAtPoint(x,y);
		}

		/**
		 * The zero-based index value of the line containing the character that the the charIndex parameter specifies.
		 */
		override public function getLineIndexOfChar (charIndex:int) : int {
			return textField.getLineIndexOfChar(charIndex);
		}

		/**
		 * Returns the number of characters in a specific text line.
		 */
		override public function getLineLength (lineIndex:int) : int {
			return textField.getLineLength(lineIndex);
		}

		/**
		 * Returns metrics information about a given text line.
		 */
		override public function getLineMetrics (lineIndex:int) : TextLineMetrics {
			return textField.getLineMetrics(lineIndex);
		}

		/**
		 * The zero-based index value of the first character in the line.
		 */
		override public function getLineOffset (lineIndex:int) : int {
			return textField.getLineOffset(lineIndex);
		}

		/**
		 * The text string contained in the specified line.
		 */
		override public function getLineText (lineIndex:int) : String {
			return textField.getLineText(lineIndex);
		}

		/**
		 * The zero-based index value of the character.
		 */
		override public function getParagraphLength (charIndex:int) : int {
			return textField.getParagraphLength(charIndex);
		}

		override public function getRawText () : String {
			return textField.getRawText();
		}

		/**
		 * Returns a TextFormat object.
		 */
		override public function getTextFormat (beginIndex:int = -1, endIndex:int = -1) : TextFormat {
			return textField.getTextFormat(beginIndex, endIndex);
		}

		override public function getTextRuns (beginIndex:int = 0, endIndex:int = 2147483647) : Array {
			return textField.getTextRuns(beginIndex,endIndex);
		}

		override public function getXMLText (beginIndex:int = 0, endIndex:int = 2147483647) : String {
			return textField.getXMLText(beginIndex,endIndex);
		}

		override public function insertXMLText (beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void {
			textField.insertXMLText(beginIndex, endIndex, richText, pasting);
		}

		/**
		 * Replaces the current selection with the contents of the value parameter.
		 */
		override public function replaceSelectedText (value:String) : void {
			textField.replaceSelectedText(value);
		}

		/**
		 * Replaces a range of characters.
		 */
		override public function replaceText (beginIndex:int, endIndex:int, newText:String) : void {
			textField.replaceText(beginIndex, endIndex, newText);
		}

		/**
		 * Sets a new text selection.
		 */
		override public function setSelection (beginIndex:int, endIndex:int) : void {
			textField.setSelection(beginIndex, endIndex);
		}

		/**
		 * Applies text formatting.
		 */
		override public function setTextFormat (format:TextFormat, beginIndex:int = -1, endIndex:int = -1) : void {
			textField.setTextFormat(format, beginIndex, endIndex);
		}
		
		override public function get visible():Boolean 
		{
			return textField.visible;
		}
		
		override public function set visible(value:Boolean):void 
		{
			textField.visible = value;
		}
		
		/**
		 * Ajusts the number of words in the last line.
		 */
		protected function processOrphan():void 
		{
			// orphan code
			var findXMLSpaceExp:RegExp = new RegExp("&nbsp;", 'g');
			var findXMLSpaceAndSpaceExp:RegExp = new RegExp("&nbsp; ", 'g');
			var findSpaceExp:RegExp = new RegExp(" ", 'g');
			
			var tempText:String = cacheHtmlText.replace(findSpaceExp, "&nbsp; ");
			
			// set textField for processing
			textField.htmlText = cacheHtmlText;
			
			var numLines:Number = textField.numLines;
			var lines:Array = [];
			for (var i: int = 0;  i < numLines; i++)
			{
				var line:String = textField.getLineText(i);
				lines[i] = line;
			}	
			
			var htmlIndices:Array = [];
			var breakLines:Array = [];
			var textIndex:int = 0;
			
			for (i = 1; i < numLines; i++)
			{
				var currentline:String = lines[i];
				var previousLine:String = lines[i - 1];
				if (currentline.charCodeAt(0) != 10) // ignore blank lines
				{
					var numOfWords:int = getNumberOfWords(currentline);
					if (numOfWords < orphans)
					{
						var htmlIndex:int = getIndexFromSpacesIgnoreHTML(getSpacesFromIndex(textIndex + findIndexOfLastWord(previousLine), textField.text), tempText);
						htmlIndices.push(htmlIndex);
						breakLines.push(i);
					}
				}
				textIndex += previousLine.length;
			}
			
			var orphanText:String = '';
			var startIndex: int = 0;
			for (i = 0; i < htmlIndices.length; i++)
			{
				var index:int = htmlIndices[i];
				orphanText += tempText.substring(startIndex, index) + "<br/>";
				startIndex = index;
			}
			orphanText += tempText.substr(startIndex);
			orphanText = orphanText.replace(findXMLSpaceAndSpaceExp, " ");
			textField.htmlText = orphanText;	
		}
		
		private function getSpacesFromIndex(index:int, text:String):int
		{
			var isChar:Boolean = false;
			var spaceCount:int = 0;
			for (var i:int = 0; i < index; i++)
			{
				if (text.charAt(i) == ' ')
				{
					if (isChar || i == 0)
						spaceCount++;
					isChar = false;
				}
				else
				{
					isChar = true;
				}
			}
			return spaceCount;
		}
		
		private function getIndexFromSpacesIgnoreHTML(spaceCount:int, text:String):int
		{
			var isChar:Boolean = false;
			var bracketCount:int = 0;
			for (var i:int = 0; i < text.length; i++)
			{
				if (text.charAt(i) == ">")
					bracketCount++;
				if (text.charAt(i) == "<")
					bracketCount--;
				if (bracketCount > 0) continue;
				
				if (text.charAt(i) == ' ')
				{
					isChar = false;
				}
				else
				{
					if (isChar == false)
					{
						spaceCount--;
						if (spaceCount < 0)
							break;
					}
					isChar = true;
				}
			}
			return i;
		}
		
		private function findIndexOfLastWord(line:String):int
		{
			var foundWord:Boolean = false;
			var bracketCount:int = 0;
			for (var i:int = line.length - 1; i >= 0; i--)
			{
				var c:String = line.charAt(i);
				if (c == ">")
					bracketCount++;
				if (c == "<")
					bracketCount--;
				if (bracketCount > 0) continue;
				if (!foundWord)
				{
					if (c == ' ')
						foundWord = true;
				}
				else
				{
					if (c == ' ')
						break;
				}
			}
			return i + 1;
		}

		private function createBreaker(limit: int): String
		{
			var lineBreaker:String = "";
			for (var b:int = 0; b < limit; b++ ) 
			{
				lineBreaker = lineBreaker + " ";
			}
			return lineBreaker;
		}
		
		public function getNumberOfWords(value:String):int 
		{
			var count:int = 0;
			var a:Array = value.split(' ');
			for each (var s:String in a) {
				var b:Array = s.split('&nbsp;');
				for each (var word:String in b)
				{
					if (word == '') continue;
					count++;
				}
				
			}
			return count;
		}
		
		public function set orphanNumber(num:int): void
		{
			orphans = num;	
		}
		
		public function get orphanNumber():int
		{
			return orphans;	
		}
	}

}