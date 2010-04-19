/**
* @author cbrown
*/
package com.matchit.utils 
{
	public class ArrayUtils 
	{
		public static function shuffle(array:Array):Array {
			var l:Number = array.length - 1;
			for (var it:Number = 0; it < l; it++) {
				var r = Math.round(Math.random() * l);
				var tmp = array[it];
				array[it] = array[r];
				array[r] = tmp;
			}
			return array;
		}
	}
}