package com.lookmum.view 
{
	import caurina.transitions.Tweener;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Phil Douglas
	 */
	public class TransitionerDecorator3d extends TransitionerDecorator 
	{
		private var cacheX:Number;
		private var cacheY:Number;
		private var cacheRotationX:Number;
		private var cacheRotationY:Number;
		private var cacheZ:Number;
		private static const MAX_X_VAR:Number = 200;
		private static const MAX_Y_VAR:Number = 200;
		private static const MIN_Z_VAR:Number = 500;
		private static const MAX_Z_VAR:Number = 1000;
		private static const MAX_ROTATION_VAR:Number = 100;
		public function TransitionerDecorator3d(target:MovieClip) 
		{
			
			super(target);
			
			cacheX = target.x;
			cacheY = target.y;
			
			cacheRotationX = target.rotationX;
			cacheRotationY = target.rotationY;
			
			cacheZ = target.z;
			
		}
		
		override public function transitionIn():void 
		{
			reset();
			visible = true;
			transitioning = true;
			target.alpha = 0;
			var time:Number = minInTime + (Math.random() * (maxInTime-minInTime));
			cacheX = target.x;
			cacheY = target.y;
			cacheZ = target.z;
			cacheRotationX = target.rotationX;
			cacheRotationY = target.rotationY;
			var vert:Boolean = Math.random() > 0.5;
			//target.z += MIN_Z_VAR + (Math.random() * MAX_Z_VAR);
			target.z = 1000;
			if(vert){
				target.y += (Math.random() * MAX_Y_VAR) - (MAX_Y_VAR / 2);
				target.rotationX += (Math.random() * MAX_ROTATION_VAR) - (MAX_ROTATION_VAR / 2);
			}else{
				target.x += (Math.random() * MAX_X_VAR) - (MAX_X_VAR / 2);
				target.rotationY += (Math.random() * MAX_ROTATION_VAR) - (MAX_ROTATION_VAR / 2);
			}
			//trace( "target.z : " + target.z );
			Tweener.addTween(target, { 
				x:cacheX,
				y:cacheY,
				z:cacheZ,
				rotationX:cacheRotationX,
				rotationY:cacheRotationY,
				alpha: 1,
				time: time,
				onComplete: function():void {
					//remove the 3d transform (breaks any dragging)
					this.transform.matrix3D = null;
					x = cacheX;
					y = cacheY;
					transitioning = false;
					onIn.dispatch();
				}
			} );
		}
		override public function transitionOut():void 
		{
			reset();
			transitioning = true;
			if (!target.visible) return onOut.dispatch();
			cacheX = target.x;
			cacheY = target.y;
			cacheZ = target.z;
			cacheRotationX = target.rotationX;
			cacheRotationY = target.rotationY;
			var time:Number = minOutTime + (Math.random() * (maxOutTime-minOutTime));
			var x:Number = target.x;
			var y:Number = target.y;
			var z:Number = target.z;
			var rotationX:Number = target.rotationX;
			var rotationY:Number = target.rotationY;
			var vert:Boolean = Math.random() > 0.5;
			if(vert){
				y += (Math.random() * MAX_Y_VAR) - (MAX_Y_VAR / 2);
				rotationX += (Math.random() * MAX_ROTATION_VAR) - (MAX_ROTATION_VAR / 2);
			}else{
				x += (Math.random() * MAX_X_VAR) - (MAX_X_VAR / 2);
				rotationY += (Math.random() * MAX_ROTATION_VAR) - (MAX_ROTATION_VAR / 2);
			}
			z += MIN_Z_VAR + (Math.random() * MAX_Z_VAR);
			Tweener.addTween(target, { 
				alpha:0, 
				x:x,
				y:y,
				z:z,
				rotationX:rotationX,
				rotationY:rotationY,
				time: time,
				onComplete:function():void {
					target.x = cacheX;
					target.y = cacheY;
					target.z = cacheZ;
					target.rotationX = cacheRotationX;
					target.rotationY = cacheRotationY;
					target.visible = false;
					transitioning = false;
					onOut.dispatch();
				}
			} );
		}
		
		override protected function reset():void 
		{
			if (transitioning) {
				transitioning = false;
				Tweener.removeTweens(target);
				target.x = cacheX;
				target.y = cacheY;
				target.z = cacheZ;
				target.rotationX = cacheRotationX;
				target.rotationY = cacheRotationY;
			}
		}
		
	}

}