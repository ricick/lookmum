package com.lookmum.view 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author 
	 */
	public class SWFLoadComponent extends Component
	{
		protected var loader:Loader
		protected var swfLoaderInfo:LoaderInfo;
		public var containsSwf:Boolean;
			
		public function SWFLoadComponent(target:MovieClip) 
		{
			super(target);
			containsSwf = false;	
			loader = new Loader();		
		}
		
		public function load(swfURI:String, context:LoaderContext = null ):void {
			if (containsSwf) clearSwf();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest(swfURI), context);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace(e);
		}
		
		protected function onProgress(e:ProgressEvent):void 
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		protected function clearSwf():void {
			containsSwf = false;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			target.removeChild(loader);	
		}
		
		protected function onCompleteLoad(e:Event):void 
		{
			containsSwf = true;
			swfLoaderInfo = e.target as LoaderInfo;
			target.addChild(loader);			
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get content():MovieClip
		{
			return swfLoaderInfo.content as MovieClip;
		}
	}	
}