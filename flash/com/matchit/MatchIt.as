package com.matchit 
{
	import com.matchit.controllers.MatchItController;
	import com.matchit.utils.CustomMenu;
	import flash.display.*;
	/**
	 * @author cbrown
	 */
	public class MatchIt extends Sprite
	{
		private var controller:MatchItController;
		
		public function MatchIt() 
		{
			new CustomMenu(this);
			// init the stage and the ad controller
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			controller = new MatchItController();
			addChild(controller);
			controller.init();
		}
	}
}