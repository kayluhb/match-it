package com.matchit.views 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	/**
	 * @author cbrown
	 */
	public class Reveal extends Sprite
	{
		
		public function Reveal() 
		{
			
		}
		// publics
		public function init():void 
		{
			var l:Loader = new Loader();
			l.load(new URLRequest("image.jpg"));
			addChild(l);
		}
		// privates
		// event handlers
	}
}