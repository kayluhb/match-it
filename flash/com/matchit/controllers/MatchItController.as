package com.matchit.controllers 
{
	import com.greensock.plugins.*;
	import com.matchit.events.*;
	import com.matchit.models.*;
	import com.matchit.views.*;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author cbrown
	 */
	public class MatchItController extends Sprite
	{
		private var matchGame:MatchGame;
		
		public function MatchItController() 
		{
			TweenPlugin.activate( [ AutoAlphaPlugin ] );
			visible = false;
		}
		// publics
		public function init():void 
		{
			// add all the views and init them
			matchGame = new MatchGame();
			matchGame.addEventListener(MatchItEvent.GAME_START, onGameStart);
			addChild(matchGame);
			matchGame.init();
			
			visible = true;
			matchGame.show();
		}
		// privates
		// event handlers
		private function onGameStart(e:Event):void 
		{
			var data:Data = Data.getInstance();
			matchGame.startGame(data.getRandomCards());
		}
	}
}