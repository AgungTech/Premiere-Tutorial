/**
 * @version 12/29/09
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	/**
	 * Class with static methods for Array manipulation.
	 */
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
			throw new Error("ArrayUtil is a class with static methods, it doesn't need instantiation.");
		}
		
		/**
		 * Normalize index according to the array length.
		 * @param	arr		Array reference.
		 * @param	idx		Index to be normalized.
		 * @return			Normalized index.
		 */
		public static function normIndex(arr:Array, idx:int):int
		{
			var n:uint = arr.length;
			idx %= n;
			
			return idx < 0 ? n + idx : idx;
		}
		
		/**
		 * Remove element at index.
		 * @param	arr		Array reference.
		 * @param	idx		Remove index, use negative index to remove from the end of the array.
		 * @param	normIdx	If true, the index will be normalized.
		 * @return			The removed object.
		 */
		public static function removeAt(arr:Array, idx:int, normIdx:Boolean = true):* 
		{
			if (normIdx || idx < 0) idx = normIndex(arr, idx);	
			
			return arr.splice(idx, 1)[0];
		}
		
		/**
		 * Insert element at index. It doesn't create a copy of the array.
		 * @param	arr		Array reference.
		 * @param	idx		Insertion index, use negative index to insert at the end of the array.
		 * @param	val		Value to insert in the array.
		 * @param	normIdx	If true, the index will be normalized.
		 * @return			Modified array;
		 */ 
		public static function insertAt(arr:Array, idx:int, value:*, normIdx:Boolean = true):Array 
		{
			if (normIdx) idx = normIndex(arr, idx);
			
			arr.splice(idx, 0, value);
			return arr;
		}	
		
		/**
		 * Search element and, if found, remove it. It doesn't create a copy of the array.
		 * @param	arr		Array reference.
		 * @param	value	Value to search and remove.
		 * @return			Modified array.
		 */ 
		public static function remove(arr:Array, value:*):Array 
		{
			var i:int = arr.indexOf(value);
			if (i >= 0) arr.splice(i, 1);
			
			return arr;
		}
		
		/**
		 * Swaps two elements in the given array. It doesn't create a copy of the array.
		 * @param	arr			Array reference.
		 * @param	swapIdx		Array element index.
		 * @param	withIdx		Array element index.
		 * @param	normIdx		If true, the indexes will be normalized.
		 * @return				Modified array.
		 */ 
		public static function swap(arr:Array, swapIdx:int, withIdx:int, normIdx:Boolean = true):Array
		{
			var n:uint = arr.length;
			if (normIdx || swapIdx < 0) swapIdx = normIndex(arr, swapIdx);
			if (normIdx || withIdx < 0) withIdx = normIndex(arr, withIdx);
			
			var aux:* 		= arr[swapIdx];
			arr[swapIdx] 	= arr[withIdx];
			arr[withIdx] 	= aux;
			
			return arr;
		}

		/**
		 * Shuffles the elements of an array. It doesn't create a copy of the array.
		 * @param	arr			Array to be randomized.
		 * @param	fromIdx		Start index, if missing it will take the first index.
		 * @param	toIdx		End index, if missing it will take the last index.
		 * @param	normIdx		If true, the indexes will be normalized.
		 * @return				Modified array;
		 */
		public static function shuffle(arr:Array, fromIdx:int = 0, toIdx:int = -1, normIdx:Boolean = true):Array 
		{
			if (normIdx || fromIdx < 0) fromIdx = normIndex(arr, fromIdx);
			if (normIdx || toIdx < 0) 	toIdx = normIndex(arr, toIdx);
			
			fromIdx = Math.min(fromIdx, toIdx);
			toIdx 	= Math.max(fromIdx, toIdx);
			
			for (var i:uint = fromIdx; i <= toIdx; i++) 
			{
				var randIdx:uint = NumberUtil.random(i, toIdx);
				swap(arr, randIdx, fromIdx);
			}

			return arr;
		}

		
		/**
		 * Creates a copy of an array.
		 * @param	arr		Source array.
		 * @return			A new array.			
		 */ 
		public static function clone(arr:Array):Array 
		{
			var newArr:Array = [];
			var n:uint = arr.length;
			for (var i:uint = 0; i < n; i++)
			{
				newArr[i] = arr[i];
			}		

			return newArr;
		}
		
		/**
		 * Rotate array elements to the left. It doesn't create a copy of the array.
		 * @param	arr		Array to rotate.
		 * @param	times	How many times to rotate the array.
		 * @return			Modified array.
		 */
		public static function rotateLeft(arr:Array, times:uint = 1):Array
		{
			var n:Number = arr.length;
			
			while (--times >= 0) 
			{
				var first:*	= arr[0];
				var i:uint = 0;
				while (++i < n)
				{
					arr[i - 1] 	= arr[i];
				}
				arr[n - 1] = first;
			}
			
			return arr;
		}
		
		/**
		 * Rotate array elements to the right. It doesn't create a copy of the array.
		 * @param	arr		Array to rotate.
		 * @param	times	How many times to rotate the array.
		 * @return			Modified array.
		 */
		public static function rotateRight(arr:Array, times:uint = 1):Array
		{
			var n:Number = arr.length;	
			
			while (--times >= 0)
			{
				var last:* = arr[n - 1];
				var i:uint = n;
				while (--i > 0)
				{
					arr[i] = arr[i - 1];
				}
				arr[0] = last;
			}
			
			return arr;
		}
	}
}