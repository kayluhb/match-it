package com.matchit.views 
{
	import com.greensock.TweenLite;
	import com.matchit.events.ButtonEvent;
	import flash.display.*;
	import flash.events.*;
	/**
	 * @author cbrown
	 */
	public class Card extends Sprite
	{
		public var isChecked:Boolean = false;
		public var isEnabled:Boolean = false;
		public var id:Number = 0;
		public var idx:Number = 0;
		
		public function Card() 
		{
			focusRect = false;
			hit.focusRect = false;
			enabled = true;
		}
		// publics
		public function click():void 
		{
			new TweenLite(bg, .3, { autoAlpha:1 } );
			new TweenLite(icon, .3, { autoAlpha:1 } );
			TweenLite.killTweensOf(hit);
			hit.alpha = 0;
			enabled = false;
		}
		
		public function get enabled():Boolean { return isEnabled; }
		
		public function set enabled(isEnabled:Boolean):void 
		{
			if (this.isEnabled == isEnabled) return;
			
			this.isEnabled = isEnabled;
			if (isEnabled) addEvents();
			else removeEvents();
		}
		public function handleRelease(e:MouseEvent):void { this.dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE)); }
		
		public function handleRollOut(e:MouseEvent):void 
		{ 
			new TweenLite(hit, .4, { alpha:0 } );
		}
		public function handleRollOver(e:MouseEvent):void 
		{ 
			new TweenLite(hit, .25, { alpha:.3 } );
		}
		
		public function hide():void 
		{
			new TweenLite(hit, .4, { alpha:0, delay:.15 } );
		}
		
		public function init():void 
		{
			bg.visible = icon.visible = false;
			bg.alpha = icon.alpha = 0;
		}
		// privates
		private function addEvents():void 
		{
			hit.buttonMode = true;
			hit.useHandCursor = true;
			hit.addEventListener(MouseEvent.MOUSE_UP, handleRelease);
			hit.addEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			hit.addEventListener(MouseEvent.ROLL_OVER, handleRollOver);
			this.dispatchEvent(new ButtonEvent(ButtonEvent.ENABLED));
		}
		private function removeEvents():void
		{
			hit.buttonMode = false;
			hit.useHandCursor = false;
			hit.removeEventListener(MouseEvent.MOUSE_UP, handleRelease);
			hit.removeEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			hit.removeEventListener(MouseEvent.ROLL_OVER, handleRollOver);
			this.dispatchEvent(new ButtonEvent(ButtonEvent.DISABLED));
		}
	}
}