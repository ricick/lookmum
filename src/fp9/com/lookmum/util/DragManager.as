package com.lookmum.util 
{
	import caurina.transitions.Tweener;
	import com.lookmum.events.DragEvent;
	import com.lookmum.view.IComponent;
	import com.lookmum.view.IDraggable;
	import com.lookmum.view.IDropLocation;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class DragManager 
	{
		public var drop:Signal = new Signal(IDraggable, Boolean);
		public var overlap:Signal = new Signal(IDraggable);
		public var moved:Signal = new Signal(IDraggable);
		
		private var dragItems:Array;
		protected var dropLocations:Array;
		protected var dragByDrop:Dictionary;
		protected var dropByDrag:Dictionary;
		protected var startLocationByDrag:Dictionary;
		protected var startLayerByDrag:Dictionary;
		private var dragLayer:Sprite;
		public function DragManager(dragLayer:Sprite) 
		{
			this.dragLayer = dragLayer;
			dragItems = new Array();
			dropLocations = new Array();
			dragByDrop = new Dictionary();
			dropByDrag = new Dictionary();
			startLocationByDrag = new Dictionary();
			startLayerByDrag = new Dictionary();
		}
		
		public function addDragItem(dragItem:IDraggable):void 
		{
			for each (var item:IDraggable in dragItems) 
			{
				if (item == dragItem) return;
			}
			startLocationByDrag[dragItem] = new Point(dragItem.x, dragItem.y);
			startLayerByDrag[dragItem] = dragItem.parent;
			dragItems.push(dragItem);
			//dragItem.lockCenter = true;
			dragItem.addEventListener(DragEvent.START, onStartDrag);
		}
		
		protected function onStartDrag(e:DragEvent):void 
		{
			//trace( "DragManager.onStartDrag > e : " + e );
			var dragItem:IDraggable = e.target as IDraggable;
			//remove listener because of re-parenting
			dragItem.removeEventListener(DragEvent.START, onStartDrag);
			dragItem.addEventListener(DragEvent.STOP, onStopDrag);
			
			reparentDragItem(dragItem, dragLayer);
			
		}
		protected function onStopDrag(e:DragEvent):void 
		{
			var dragItem:IDraggable = e.target as IDraggable;
			//remove listener because of re-parenting
			dragItem.removeEventListener(DragEvent.STOP, onStopDrag);
			dragItem.addEventListener(DragEvent.START, onStartDrag);
			var dropping:Boolean;
			var dropLocation:IComponent;
			//var globalCoords:Point = dragItem.parent.localToGlobal(new Point(dragItem.x, dragItem.y));
			//check if hit drop location
			for each (var location:IComponent in dropLocations) 
			{
				//trace( "location : " + location );
				
				reparentDragItem(dragItem, location.parent);
				/*
				location.parent.addChild(dragItem.target);
				var localCoords:Point = dragItem.parent.globalToLocal(globalCoords);
				dragItem.x = localCoords.x;
				dragItem.y = localCoords.y;
				*/
				var hit:Boolean = location.hitTestObject(dragItem.target);
				//trace( "hit : " + hit );
				if (hit) {
					dropLocation = location;
					break;
				}
			}
			if (dropLocation) {
				//check if no existing item at location
				if (!dragByDrop[dropLocation]) {
					//drop to location
					dropping = true;
					moveDragItemToDropLocation(dragItem, dropLocation);
					drop.dispatch(dragItem, true);
				} else {
					overlap.dispatch(dragItem, dropLocation);
				}
			}
			//if not dropped check if previous drop location and move there
			dropLocation = dropByDrag[dragItem];
			if (!dropping && dropLocation) {
				dropping = true;
				//reparentDragItem(dragItem, dropLocation.parent);
				//moveItemToLocation(dragItem, new Point(dropLocation.x, dropLocation.y));
				moveDragItemToDropLocation(dragItem, dropLocation);
				drop.dispatch(dragItem, false);
			}
			if (!dropping){
				//move to start location
				var startLayer:DisplayObjectContainer = startLayerByDrag[dragItem];
				//startLayer.addChild(dragItem.target);
				reparentDragItem(dragItem, startLayer);
				moveItemToLocation(dragItem, startLocationByDrag[dragItem]);
			}
		}
		protected function moveItemToLocation(item:IDraggable,point:Point):void{
			Tweener.addTween(item, { x:point.x, y:point.y, time:0.5, onComplete:function():void {
				moved.dispatch(item);
			}} );
		}
		public function addDropLocation(dropLocation:IComponent):void 
		{
			for each (var item:IComponent in dropLocations) 
			{
				if (item == dropLocation) return;
			}
			dropLocations.push(dropLocation);
		}
		public function getDragItemByDropLocation(dropLocation:IComponent):IDraggable{
			return dragByDrop[dropLocation];
		}
		public function getDropLocationByDragItem(dragItem:IDraggable):IComponent{
			return dropByDrag[dragItem];
		}
		
		public function moveDragItemToDropLocation(dragItem:IDraggable, dropLocation:IComponent):void 
		{
			reparentDragItem(dragItem, dropLocation.parent);
			/*
			var globalCoords:Point = dragItem.parent.localToGlobal(new Point(dragItem.x, dragItem.y));
			dropLocation.parent.addChild(dragItem.target);
			var localCoords:Point = dragItem.parent.globalToLocal(globalCoords);
			dragItem.x = localCoords.x;
			dragItem.y = localCoords.y;
			*/
			if (dropLocation is IDropLocation) {
				var p:Point = IDropLocation(dropLocation).getDropSpot();
				moveItemToLocation(dragItem, new Point(dropLocation.x + p.x, dropLocation.y + p.y));
			}else {
				moveItemToLocation(dragItem, new Point(dropLocation.x, dropLocation.y));
			}
			//remove old associations
			var oldLocation:IComponent = dropByDrag[dragItem];
			if (oldLocation) {
				dragByDrop[oldLocation] = null;
			}
			//associate items
			dragByDrop[dropLocation] = dragItem;
			dropByDrag[dragItem] = dropLocation;
		}
		
		public function moveDragItemToStartLocation(dragItem:IDraggable):void 
		{
			//move to start location
			var startLayer:DisplayObjectContainer = startLayerByDrag[dragItem];
			
			reparentDragItem(dragItem, startLayer);
			moveItemToLocation(dragItem, startLocationByDrag[dragItem]);
			
			var oldLocation:IComponent = dropByDrag[dragItem];
			if (oldLocation) {
				dragByDrop[oldLocation] = null;
			}
			
			//associate items
			dropByDrag[dragItem] = null;
		}
		
		protected function reparentDragItem(dragItem:IDraggable, newParent:DisplayObjectContainer):void {
			Tweener.removeTweens(dragItem);
			var globalCoords:Point = dragItem.parent.localToGlobal(new Point(dragItem.x, dragItem.y));
			newParent.addChild(dragItem.target);
			var localCoords:Point = dragItem.parent.globalToLocal(globalCoords);
			dragItem.x = localCoords.x;
			dragItem.y = localCoords.y;
		}
		
	}

}