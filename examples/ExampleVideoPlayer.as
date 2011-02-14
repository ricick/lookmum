package  
{
	import com.lookmum.view.StandardVideoPlayer;
	import com.lookmum.view.VideoPlayer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Andrew Catchaturyan
	 */
	public class ExampleVideoPlayer extends Sprite
	{
		private var vp:VideoPlayer;
		
		public function ExampleVideoPlayer() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//vp = new VideoPlayer(new videoPlayerClip());
			vp = new StandardVideoPlayer(new updatedVideoPlayerClip());
			addChild(vp);
			
			vp.load('video/s10_5_F8_Lg.flv', false);
		}
		
	}

}