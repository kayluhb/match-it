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
		public function hideCard(card:Card):void 
		{
			// get the clips in the mask that needs to hide now
			var mc:DisplayObject = getChildByName(KEY + card.idx);
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
		public function reset():void
		{
			var mc:DisplayObject;
			for (var i:Number = 0; i < this.numChildren; ++i)
			{
				mc = this.getChildAt(i);
				mc.alpha = 1;
				mc.visible = true;
			}
			visible = true;
		}
		// privates
		// event handlers
	}

}