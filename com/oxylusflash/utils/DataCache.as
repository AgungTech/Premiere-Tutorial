/**
 * @version 01/04/10
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	/**
	 * Class with static methods data storage.
	 */
	public class DataCache
	{
		private static var dataHolder:Object;
		
		public function DataCache()
		{
			throw new Error("DataCache is a class with static methods, it doesn't need instantiation.");
		}
		
		/**
		 * Store data.
		 * @param	id		Data id string.
		 * @param	data	Data to be stored.
		 */
		public static function store(id:String, data:*):void
		{
			if (dataHolder == null) dataHolder = { };			
			dataHolder[id] = data;
		}
		
		/**
		 * Retrieve stored data.
		 * @param	id		Data id.
		 * @return			Data if found, or null otherwise.
		 */
		public static function retrieve(id:String):*
		{
			if (dataHolder == null) dataHolder = { };
			return dataHolder[id] == undefined ? null : dataHolder[id];
		}
		
		/**
		 * Clear data cache.
		 */
		public static function clear():void
		{
			if (dataHolder)
			{
				for each(var id:String in dataHolder)
				{
					dataHolder[id] = null;
					delete dataHolder.id;
				}
				dataHolder = null;
			}
			
		}
	}
}