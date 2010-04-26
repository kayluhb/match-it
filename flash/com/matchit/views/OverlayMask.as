package com.matchit.views 
{
	import com.greensock.TweenLite;
	import flash.display.*;
	/**
	 * @author cbrown
	 */
	public class OverlayMask extends Sprite
	{
		private const KEY:String = "Card";
		
		public function OverlayMask() 
		{
			
		}
		// publics
		public function hideCards(first:Card, second:Card):void 
		{
			// get the clips in the mask that needs to hide now
			var mc:DisplayObject = getChildByName(KEY + first.idx);
			new TweenLite(mc, .3, { autoAlpha:0 } );
			
			mc = getChildByName(KEY + second.idx);
			new TweenLite(mc, .3, { autoAlpha:0 } );
		}
		public function init(cols:Number, rows:Number, tarX:Number, tarY:Number):void 
		{
			cacheAsBitmap = true;
			for (var i:Number = 0; i < cols * rows; ++i) 
			{
				var c:CardFill = new CardFill();
				c.x = i % cols * tarX;
				c.y = Math.floor(i / cols) * tarY;
				c.name = KEY + i;
				addChild(c);
			}
		}
		// privates
		// event handlers
	}

}