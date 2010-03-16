package com.lookmum.util{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.text.TextField;
	public class TabManager {
		private static var items:Array;
		public function TabManager(){
		}
		public static function addItem(item:InteractiveObject):void{	
			if(! items){
				items = new Array();
			}
			if (items.lastIndexOf(item)!=-1) {
				items.splice(items.lastIndexOf(item), 1);
			}
			items.push(item);
			/*
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					item.tabIndex = i;
				}
			}
			*/
			resetIndexes();
		}
		public static function removeItem(item:InteractiveObject):void{
			if (!items) return;
			if (items.lastIndexOf(item)!=-1) {
				items.splice(items.lastIndexOf(item), 1);
			}
			/*
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					item.tabIndex = i;
				}
			}
			*/
			resetIndexes();
		}
		private static function resetIndexes():void{
			for(var k:int = 0; k < items.length; k++){
				items[k].tabIndex = k
			}
		}
		
		
		////////////////
		//
		//returns the item's tab index
		///////////////
		public static function getTabIndex(item:InteractiveObject):int{
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					return i;
				}
			}
			return -1;
		}

		
		//////////////
		//
		//sets the tab index to the item passed in and edits the index's of the items around it
		//
		/////////////
		public static function setTabIndex(item:InteractiveObject, index:int):void{
			if(! items){
				items = new Array();
			}
			//trace("TabManager.setTabIndex > item : " + item + ", num : " + num);
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					//trace("item matches passed in");
					if(i > index){
						//trace("i is bigger than index");
						//move everything down++
						for(var j:int = i; j > index; j--){
							items[j] = items[j - 1];
						}
					} else if(i < index){
						//move everything up--
						//trace("i is smaller than index");
						for(var k:int = i; k < index; k++){
							items[k] = items[k + 1];
						}
					}
					items[index] = item;
					resetIndexes();
				}
			}
		}
		
		
		////////
		//
		//Move item to last tab position
		//
		////////
		public static function setLastTab(item:InteractiveObject):void{
			if(! items){
				items = new Array();
			}
			//trace("TabManager.setLastTab > item : " + item);
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					items.splice(i, 1);
				}
			}
			items.push(item);
			resetIndexes();
		}
		
		
		////////
		//
		//Move item to first tab position
		//
		////////
		public static function setFirstTab(item:InteractiveObject):void{
			if(! items){
				items = new Array();
			}
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == item){
					for(var j:int = i; j > 0; j--){
						items[j] = items[j - 1];
					}
				}
			}
			items[0] = item;
			resetIndexes();
		}
		
		
		/////////////////////
		//
		//Moves putBefore item to the tab index before item
		//
		////////////////////
		public static function setBefore(putBefore:InteractiveObject, item:InteractiveObject):void{
			if(! items){
				items = new Array();
			}
			var putBeforeIndex:int;
			var itemIndex:int;
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == putBefore){
					putBeforeIndex = i;
				}
				if(items[i] == item){
					itemIndex = i;
				}
			}
			if(putBeforeIndex > itemIndex){
				//move up --
				setTabIndex(putBefore, (itemIndex));
			} else if(putBeforeIndex < itemIndex){
				//move down ++
				setTabIndex(putBefore, (itemIndex - 1));
			}
		}
		
		
		/////////////////////
		//
		//Moves putAfter item to the tab index after item
		//
		////////////////////
		public static function setAfter(putAfter:InteractiveObject, item:InteractiveObject):void{
			if(! items){
				items = new Array();
			}
			var putAfterIndex:int;
			var itemIndex:int;
			for(var i:int = 0; i < items.length; i++){
				if(items[i] == putAfter){
					putAfterIndex = i;
				}
				if(items[i] == item){
					itemIndex = i;
				}
			}
			if(putAfterIndex > itemIndex){
				//move up --
				setTabIndex(putAfter, (itemIndex + 1));
			} else if(putAfterIndex < itemIndex){
				//move down ++
				setTabIndex(putAfter, (itemIndex));
			}
		}
		private static var disabledItems:Array;
		public static function disableTabs():void {
			if (!items) return;
			disabledItems = new Array();
			for each(var item:InteractiveObject in items) {
				if (item.tabEnabled) {
					disabledItems.push(item);
					item.tabEnabled = false;
				}
			}
		}
		public static function enableTabs():void{
			if (!disabledItems) return;
			for each(var item:InteractiveObject in disabledItems) {
				if (!item.tabEnabled) {
					item.tabEnabled = true;
				}
			}
			disabledItems = new Array();
		}
	}	
}
