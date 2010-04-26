package com.matchit.views 
{
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
		public function get enabled():Boolean { return isEnabled; }
		public function set enabled(isEnabled:Boolean):void {
			if (this.isEnabled == isEnabled) return;
			
			this.isEnabled = isEnabled;
			if (isEnabled) addEvents();
			else removeEvents();
		}
		public function handlePress(event:MouseEvent):void { this.dispatchEvent(new ButtonEvent(ButtonEvent.PRESS)); }
		public function handleRelease(event:MouseEvent):void { this.dispatchEvent(new ButtonEvent(ButtonEvent.RELEASE)); }
		public function handleRollOut(event:MouseEvent):void { this.dispatchEvent(new ButtonEvent(ButtonEvent.OUT)); }
		public function handleRollOver(event:MouseEvent):void { this.dispatchEvent(new ButtonEvent(ButtonEvent.OVER)); }
		
		// privates
		private function addEvents():void {
			hit.buttonMode = true;
			hit.useHandCursor = true;
			hit.addEventListener(MouseEvent.MOUSE_DOWN, handlePress);
			hit.addEventListener(MouseEvent.MOUSE_UP, handleRelease);
			hit.addEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			hit.addEventListener(MouseEvent.ROLL_OVER, handleRollOver);
			this.dispatchEvent(new ButtonEvent(ButtonEvent.ENABLED));
		}
		private function removeEvents():void {
			hit.buttonMode = false;
			hit.useHandCursor = false;
			hit.removeEventListener(MouseEvent.MOUSE_DOWN, handlePress);
			hit.removeEventListener(MouseEvent.MOUSE_UP, handleRelease);
			hit.removeEventListener(MouseEvent.ROLL_OUT, handleRollOut);
			hit.removeEventListener(MouseEvent.ROLL_OVER, handleRollOver);
			this.dispatchEvent(new ButtonEvent(ButtonEvent.DISABLED));
		}
	}
}