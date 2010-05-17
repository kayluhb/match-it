package com.matchit.views 
{
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	/**
	 * @author cbrown
	 */
	public class CardBorder extends Sprite
	{
		
		public function CardBorder() 
		{
			
		}
		// publics
		public function init(cols:Number, rows:Number, tarX:Number, tarY:Number):void 
		{
			var main:Sprite = new Sprite();
			addChild(main);
			var sq:Shape = new Shape();
			sq.graphics.beginFill(0xffffff);
			sq.graphics.drawRect(0, 0, cols * tarX, rows * tarY);
			sq.graphics.endFill();
			main.addChild(sq);
			
			var container:Sprite = new Sprite();
			var c:CardFill;
			for (var i:Number = 0; i < cols * rows; ++i) 
			{
				c = new CardFill();
				c.x = i % cols * tarX;
				c.y = Math.floor(i / cols) * tarY;
				container.addChild(c);
			}
			container.cacheAsBitmap = true;
			container.blendMode = BlendMode.ERASE;
			main.addChild(container);
			main.blendMode = BlendMode.LAYER;
		}
		// privates
		// event handlers
	}
}