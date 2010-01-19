package com.lookmum.util{
	import com.lookmum.view.Component;
	public class ModalManager
	{
		private var componentList : Array;
		private var disabledList : Array;
		private static var instance : ModalManager;
		public function ModalManager ()
		{
			componentList = new Array ();
			disabledList = new Array ();
		}
		/**
		 * Singleton function returns instance of ModalManager
		 * @return
		 */
		public static function getInstance () : ModalManager
		{
			if (instance == null)
			{
				instance = new ModalManager ();
			}
			return instance;
		}
		/**
		 * Register a component with ModalManager
		 * @param	com
		 * @param	disableFunction
		 */
		public function registerComponent (com:Component, disableFunction:Function) : void
		{	
			//search componentList for component in case already added
			for (var i:int = 0; i < componentList.length; i ++)
			{
				if (com == componentList [i][0])
				{
					return;
				}
			}
			//add component to componentList
			componentList.push ([com,disableFunction]);
		}
		/**
		 * Unregister component from ModalManager
		 * @param	com
		 */
		public function unregisterComponent (com:Component) : void
		{
			//search componentList for component to remove it
			for (var i:int = 0; i < componentList.length; i ++)
			{
				if (com == componentList[i][0])
				{
					componentList.splice (i, 1);
					break;
				}
			}
			//search disabledList for component to remove it
			removeReactivation(com);
			
		}
		/**
		 * Removes a component from the reactivation list if present, so if it was disabled by ModalManager, it won't reactivate on calling activate.
		 */
		public function removeReactivation(com:Component):void {
			//search disabledList for component to remove it
			for (var j:int = 0; j < disabledList.length; j++) {
				var layer:Array = disabledList[j];
				//trace('checking layer ' + j);
				for (var k:int = 0; k < layer.length; k++) {
					//trace('comparing to ' + layer[k][0]);
					if (com == layer[k][0])
					{
						//trace('found component');
						layer.splice (k, 1);
						break;
					}
				}
			}
		}
		/**
		 * Deactivate any currently enabled components registered with ModalManager
		 */
		public function deactivate() : void
		{
			var currentLayer:Array = new Array();
			disabledList.push (currentLayer);
			var dispatchList:Array = new Array();
			for (var i:int = 0; i < componentList.length; i ++)
			{
				var component:Component = componentList [i][0];
				if (component.enabled)
				{
					componentList [i][1].call();
					currentLayer.push (componentList [i]);
				}
			}
		}
		/**
		 * Activate the disabled components. This will activate the components disabled by the last call to deactivate.
		 * @param	forceAll Enable all components currently disabled by ModalManager, including those from previous call to deactivate.
		 */
		public function activate(forceAll : Boolean = false) : void
		{
			if (disabledList.length == 0) return;
			var currentLayer:Array = disabledList.pop() as Array;
			for (var i:int = 0; i < currentLayer.length; i ++)
			{
				var component:Component = currentLayer[i][0];
				component.enabled = true;
			}
			if (forceAll && disabledList.length > 0) {
				//recursively activate the list if force all
				activate(forceAll);
			}
		}
	}
}