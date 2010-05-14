package com.lookmum.util{
	import com.lookmum.events.TextManagerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.XMLNodeType;
	/**
	* ...
	* @author Default
	* @version 0.1
	*/
	
	[Event(name = "load", type = "com.lookmum.events.TextManagerEvent")]
	
	public class TextManager extends EventDispatcher {

		public static var debug:Boolean = false;
		public static var throwEmptyIDError:Boolean = false;
		public static var fakeTexts:Boolean = false;
		public function TextManager() {
			
		}
		private static var instance:TextManager
		public static function getInstance():TextManager {
			if(!instance)instance = new TextManager();
			return instance;
		}
		private static var texts:Object = new Object();
		private var loader:URLLoader;
		private var _loaded:Boolean = false;
		public static function getText(id:String):String {
			if (id == '' && throwEmptyIDError)
			{
				throw new Error('ERROR: no text ID supplied');
			}
			if(fakeTexts && texts[id] == null)return id;
			if (debug && texts[id] == null) {
				trace('ERROR: TextManager has no text with id ' + id);
				if (!id) return '';
				return id;
			}
			return texts[id];
		}
		public function getLoaded():Boolean{
			return _loaded;
		}
		public function loadText(url:String):void{
			loader = new URLLoader();
			var request:URLRequest = new URLRequest(url);
			loader.addEventListener(Event.COMPLETE,onLoadTextData)
			loader.load(request);
		}
		private function onLoadTextData(event:Event):void {
			var xml:XML = new XML(loader.data);
			for each(var textItem:XML in xml..textItem) {
				if (texts[textItem.@id]!= null) {
					trace('ERROR: Duplicate textItem id ' + textItem.@id);
					continue
				}
				texts[textItem.@id] = textItem
			}
			this._loaded = true;
			this.dispatchEvent(new TextManagerEvent(TextManagerEvent.LOAD));
		}
		/*
		private function onLoadTextData(event:Event):void{
			var xml:XML = new XML(loader.data);
			searchNode(xml)
			this._loaded = true;
			this.dispatchEvent(new TextManagerEvent(TextManagerEvent.LOAD));
		}
		private function searchNode(xml:XML):void{
			if(xml.text().length()>0){
				texts[xml.attributes.id] = xml.text();
			}
			for each (var node:XML in xml.children()){
				searchNode(node);
			}
		}
		*/
	}
}