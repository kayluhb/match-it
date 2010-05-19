package com.matchit.views 
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.net.URLRequest;
	/**
	 * @author cbrown
	 */
	public class Overlay extends Sprite
	{	
		public function Overlay() 
		{
			
		}
		// publics
		public function hide():void
		{
			new TweenLite(this, .3, { autoAlpha:0 } );
		}
		public function init(h:Number, w:Number):void 
		{
			var l:Loader = new Loader();
			addChild(l);
			l.load(new URLRequest("image2.jpg"));
			
			var m:Shape = new Shape();
			m.graphics.beginFill(0x000000);
			m.graphics.drawRect(0, 0, w, h);
			m.graphics.endFill();
			addChild(m);
			l.mask = m;
			cacheAsBitmap = true;
			
		}
		
		public function show():void
		{
			new TweenLite(this, .3, { autoAlpha:1 } );
		}
		// privates
		// event handlers
	}
}