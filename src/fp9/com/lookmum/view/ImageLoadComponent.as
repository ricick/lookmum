package com.lookmum.view 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author 
	 */
	public class ImageLoadComponent extends Component
	{
		protected var loader:Loader;
		
		public var containsImage:Boolean;
		protected var imageLoaderInfo:LoaderInfo;
			
		public function ImageLoadComponent(target:MovieClip) 
		{
			super(target);
			containsImage = false;	
			loader = new Loader();		
		}
		
		public function load(imageURI:String, context:LoaderContext = null ):void {
			if (containsImage) clearImage();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest(imageURI), context);
		}
		
		protected function onProgress(e:ProgressEvent):void 
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		protected function clearImage():void {
			containsImage = false;
			target.removeChild(loader);			
		}
		public function setSmoothing(value:Boolean):void {
			if (!containsImage) return;
			Bitmap(Loader(target.getChildAt(1)).contentLoaderInfo.content).smoothing = value;
		}
		private function onCompleteLoad(e:Event):void 
		{
			containsImage = true;
			imageLoaderInfo = e.target as LoaderInfo;
			target.addChild(loader);			
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}	
}