package com.matchit.models 
{
	import com.matchit.utils.ArrayUtils;
	/**
	 * @author cbrown
	 */
	public class Data
	{
		public static var POST_URL:String = "http://matchit.stage.ddfcb.com/_assets/scripts/rich-media-test.php";
		
		public var icons:Array;
		
		private static var instance:Data;
		private static const NUM_ICONS:Number = 16;
		
		public static function getInstance():Data {
			if (instance == null) instance = new Data(new SingletonBlocker());
			return instance;
		}
		
		public function Data(block:SingletonBlocker) 
		{
			if (block == null) throw new Error(Errors.SINGLETON_ERROR);
			else 
			{
				icons = [];
				for (var i:Number = 0; i < NUM_ICONS; ++i) {
					icons[icons.length] = new Icon(i);
				}
			}
		}
		// publics
		public function getRandomCards():Array {
			return ArrayUtils.shuffle(icons);
		}
		// privates
		// event handlers
	}
}
internal class SingletonBlocker {  }