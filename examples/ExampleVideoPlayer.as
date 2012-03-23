package  
{
	import com.lookmum.util.TimeCodeUtil;
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
		private var videoPlayer:VideoPlayer;
		public function ExampleVideoPlayer() 
		{
			videoPlayer = new VideoPlayer(new videoPlayerClip);
			addChild(videoPlayer);
			videoPlayer.bufferTime = 1;
			videoPlayer.load('video/AMCA_HVAC.flv');
			trace(TimeCodeUtil.toTimeCode(123001, "HH:MM:SS:mmm"));
		}
		
	}

}