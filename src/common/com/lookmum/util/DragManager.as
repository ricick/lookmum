package com.lookmum.util 
{
	import caurina.transitions.Tweener;
	import com.adobe.cairngorm.commands.ICommand;
	import com.lookmum.events.DragEvent;
	import com.lookmum.view.Component;
	import com.lookmum.view.IComponent;
	import com.lookmum.view.IDraggable;
	import com.lookmum.view.IDropLocation;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		
		protected var _dragItems:Array;
		protected var _dropLocations:Array;
		protected var dragByDrop:Dictionary;
		protected var dropByDrag:Dictionary;
		protected var startLocationByDrag:Dictionary;
		protected var startLayerByDrag:Dictionary;
		protected var dragLayer:Sprite;
		protected var _dragTime:Number = 0.5;
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
		
		public function removeDragItem(dragItem:IDraggable):void
		{
			var index:int = dragItems.indexOf(dragItem);
			if (index < 0) return;
			
			delete startLocationByDrag[dragItem];
			delete startLayerByDrag[dragItem];
			
			var dropLocation:IDropLocation = dropByDrag[dragItem];
			delete dragByDrop[dropLocation];
			delete dropByDrag[dragItem];
			
			dragItems.splice(index, 1);
			
			dragItem.removeEventListener(DragEvent.START, onStartDrag);
			dragItem.removeEventListener(DragEvent.STOP, onStopDrag);
		}
		
		protected function onStartDrag(e:DragEvent):void 
		{
			//trace( "DragManager.onStartDrag > e : " + e );
			var dragItem:IDraggable = e.target as IDraggable;
			//remove listener because of re-parenting
			dragItem.removeEventListener(DragEvent.START, onStartDrag);
			dragItem.addEventListener(DragEvent.STOP, onStopDrag);
			
			Tweener.removeTweens(dragItem);
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
				if (!location) continue;
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
					// if multiple drop locations then find the closest to the center for the drag object
					var dragBounds:Rectangle = dragItem.getBounds(null);
					var minDistance:Number = getDistance(location, dragItem);
					dropLocation = location;
					for each (var loc:IComponent in dropLocations)
					{
						if (loc.hitTestObject(dragItem.target))
						{
							var distance:Number = getDistance(loc, dragItem);
							if (distance < minDistance)
							{
								dropLocation = loc;
								minDistance = distance;
							}
						}
					}
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
		
		protected function getDistance(dropLocation:IComponent, dragItem:IDraggable):Number 
		{
			// todo: take into account the bounding rectangle of both objects
			var dx:Number = (dropLocation.x - dragItem.x);
			var dy:Number = (dropLocation.y - dragItem.y);
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		protected function moveItemToLocation(item:IDraggable,point:Point):void{
			Tweener.addTween(item, { x:point.x, y:point.y, time:dragTime, onComplete:function():void {
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
		
		public function get dragTime():Number 
		{
			return _dragTime;
		}
		
		public function set dragTime(value:Number):void 
		{
			_dragTime = value;
		}
		
		public function get dragItems():Array 
		{
			return _dragItems;
		}
		
		public function set dragItems(value:Array):void 
		{
			_dragItems = value;
		}
		
		public function get dropLocations():Array 
		{
			return _dropLocations;
		}
		
		public function set dropLocations(value:Array):void 
		{
			_dropLocations = value;
		}
		
	}

}