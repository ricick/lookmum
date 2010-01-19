package com.lookmum.view 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public interface ITextComponent 
	{
		/**
		 * When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.
		 */
		function get alwaysShowSelection () : Boolean;
		function set alwaysShowSelection (value:Boolean) : void;

		/**
		 * The type of anti-aliasing used for this text field.
		 */
		function get antiAliasType () : String;
		function set antiAliasType (antiAliasType:String) : void;

		/**
		 * Controls automatic sizing and alignment of text fields.
		 */
		function get autoSize () : String;
		function set autoSize (value:String) : void;

		/**
		 * Specifies whether the text field has a background fill.
		 */
		function get background () : Boolean;
		function set background (value:Boolean) : void;

		/**
		 * The color of the text field background.
		 */
		function get backgroundColor () : uint;
		function set backgroundColor (value:uint) : void;

		/**
		 * Specifies whether the text field has a border.
		 */
		function get border () : Boolean;
		function set border (value:Boolean) : void;

		/**
		 * The color of the text field border.
		 */
		function get borderColor () : uint;
		function set borderColor (value:uint) : void;

		/**
		 * An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.
		 */
		function get bottomScrollV () : int;

		/**
		 * The index of the insertion point (caret) position.
		 */
		function get caretIndex () : int;

		/**
		 * A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.
		 */
		function get condenseWhite () : Boolean;
		function set condenseWhite (value:Boolean) : void;

		/**
		 * Specifies the format applied to newly inserted text, such as text inserted with the replaceSelectedText() method or text entered by a user.
		 */
		function get defaultTextFormat () : TextFormat;
		function set defaultTextFormat (format:TextFormat) : void;

		/**
		 * Specifies whether the text field is a password text field.
		 */
		function get displayAsPassword () : Boolean;
		function set displayAsPassword (value:Boolean) : void;

		/**
		 * Specifies whether to render by using embedded font outlines.
		 */
		function get embedFonts () : Boolean;
		function set embedFonts (value:Boolean) : void;

		/**
		 * The type of grid fitting used for this text field.
		 */
		function get gridFitType () : String;
		function set gridFitType (gridFitType:String) : void;

		/**
		 * Contains the HTML representation of the text field contents.
		 */
		function get htmlText () : String;
		function set htmlText (value:String) : void;

		/**
		 * The number of characters in a text field.
		 */
		function get length () : int;

		/**
		 * The maximum number of characters that the text field can contain, as entered by a user.
		 */
		function get maxChars () : int;
		function set maxChars (value:int) : void;

		/**
		 * The maximum value of scrollH.
		 */
		function get maxScrollH () : int;

		/**
		 * The maximum value of scrollV.
		 */
		function get maxScrollV () : int;

		/**
		 * A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.
		 */
		function get mouseWheelEnabled () : Boolean;
		function set mouseWheelEnabled (value:Boolean) : void;

		/**
		 * Indicates whether field is a multiline text field.
		 */
		function get multiline () : Boolean;
		function set multiline (value:Boolean) : void;

		/**
		 * Defines the number of text lines in a multiline text field.
		 */
		function get numLines () : int;

		/**
		 * Indicates the set of characters that a user can enter into the text field.
		 */
		function get restrict () : String;
		function set restrict (value:String) : void;

		/**
		 * The current horizontal scrolling position.
		 */
		function get scrollH () : int;
		function set scrollH (value:int) : void;

		/**
		 * The vertical position of text in a text field.
		 */
		function get scrollV () : int;
		function set scrollV (value:int) : void;

		/**
		 * A Boolean value that indicates whether the text field is selectable.
		 */
		function get selectable () : Boolean;
		function set selectable (value:Boolean) : void;

		function get selectedText () : String;

		/**
		 * The zero-based character index value of the first character in the current selection.
		 */
		function get selectionBeginIndex () : int;

		/**
		 * The zero-based character index value of the last character in the current selection.
		 */
		function get selectionEndIndex () : int;

		/**
		 * The sharpness of the glyph edges in this text field.
		 */
		function get sharpness () : Number;
		function set sharpness (value:Number) : void;

		/**
		 * Attaches a style sheet to the text field.
		 */
		function get styleSheet () : StyleSheet;
		function set styleSheet (value:StyleSheet) : void;

		/**
		 * A string that is the current text in the text field.
		 */
		function get text () : String;
		function set text (value:String) : void;

		/**
		 * The color of the text in a text field, in hexadecimal format.
		 */
		function get textColor () : uint;
		function set textColor (value:uint) : void;

		/**
		 * The height of the text in pixels.
		 */
		function get textHeight () : Number;

		/**
		 * The width of the text in pixels.
		 */
		function get textWidth () : Number;

		/**
		 * The thickness of the glyph edges in this text field.
		 */
		function get thickness () : Number;
		function set thickness (value:Number) : void;

		/**
		 * The type of the text field.
		 */
		function get type () : String;
		function set type (value:String) : void;

		/**
		 * Specifies whether to copy and paste the text formatting along with the text.
		 */
		function get useRichTextClipboard () : Boolean;
		function set useRichTextClipboard (value:Boolean) : void;

		/**
		 * A Boolean value that indicates whether the text field has word wrap.
		 */
		function get wordWrap () : Boolean;
		function set wordWrap (value:Boolean) : void;

		/**
		 * Appends text to the end of the existing text of the TextField.
		 */
		function appendText (newText:String) : void;

		/**
		 * Returns a rectangle that is the bounding box of the character.
		 */
		function getCharBoundaries (charIndex:int) : Rectangle;

		/**
		 * Returns the zero-based index value of the character.
		 */
		function getCharIndexAtPoint (x:Number, y:Number) : int;

		/**
		 * The zero-based index value of the character.
		 */
		function getFirstCharInParagraph (charIndex:int) : int;

		/**
		 * Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an <img> tag.
		 */
		function getImageReference (id:String) : DisplayObject;

		/**
		 * The zero-based index value of the line at a specified point.
		 */
		function getLineIndexAtPoint (x:Number, y:Number) : int;

		/**
		 * The zero-based index value of the line containing the character that the the charIndex parameter specifies.
		 */
		function getLineIndexOfChar (charIndex:int) : int;

		/**
		 * Returns the number of characters in a specific text line.
		 */
		function getLineLength (lineIndex:int) : int;

		/**
		 * Returns metrics information about a given text line.
		 */
		function getLineMetrics (lineIndex:int) : TextLineMetrics;

		/**
		 * The zero-based index value of the first character in the line.
		 */
		function getLineOffset (lineIndex:int) : int;

		/**
		 * The text string contained in the specified line.
		 */
		function getLineText (lineIndex:int) : String;

		/**
		 * The zero-based index value of the character.
		 */
		function getParagraphLength (charIndex:int) : int;

		function getRawText () : String;

		/**
		 * Returns a TextFormat object.
		 */
		function getTextFormat (beginIndex:int = -1, endIndex:int = -1) : TextFormat;

		function getTextRuns (beginIndex:int = 0, endIndex:int = 2147483647) : Array;

		function getXMLText (beginIndex:int = 0, endIndex:int = 2147483647) : String;

		function insertXMLText (beginIndex:int, endIndex:int, richText:String, pasting:Boolean = false) : void;


		/**
		 * Replaces the current selection with the contents of the value parameter.
		 */
		function replaceSelectedText (value:String) : void;

		/**
		 * Replaces a range of characters.
		 */
		function replaceText (beginIndex:int, endIndex:int, newText:String) : void;

		/**
		 * Sets a new text selection.
		 */
		function setSelection (beginIndex:int, endIndex:int) : void;

		/**
		 * Applies text formatting.
		 */
		function setTextFormat (format:TextFormat, beginIndex:int = -1, endIndex:int = -1) : void;
	}
	
}