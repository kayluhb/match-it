package com.matchit.events
{
	import flash.events.MouseEvent;
	
	public class ButtonEvent extends MouseEvent 
	{
		public var id:Number = -1;
		
		public static const DISABLED:String = "disabled";
		public static const ENABLED:String 	= "enabled";
		public static const OUT:String 		= "btnOut";
		public static const OVER:String 	= "btnOver";
		public static const PRESS:String 	= "btnPress";
		public static const RELEASE:String 	= "btnRelease";
		
		public function ButtonEvent(type:String, id:Number = -1) {
			this.id = id;
			super(type, false, false);
		}
	}
}