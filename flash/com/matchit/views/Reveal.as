package com.matchit.views 
{
	import flash.display.*;
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
		public function init(h:Number, w:Number):void 
		{
			var l:Loader = new Loader();
			addChild(l);
			l.load(new URLRequest("image.jpg"));
			
			var m:Shape = new Shape();
			m.graphics.beginFill(0x000000);
			m.graphics.drawRect(0, 0, w, h);
			m.graphics.endFill();
			addChild(m);
			l.mask = m;
		}
		// privates
		// event handlers
	}
}