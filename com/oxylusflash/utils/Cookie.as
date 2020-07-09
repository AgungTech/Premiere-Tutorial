/**
 * @version 17/01/10
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	import flash.net.SharedObject;
	
	/**
	 * Class with static methods for Flash Cookie (using SharedObject) manipulation.
	 */
	public class Cookie
	{
		
		public function Cookie()
		{
			throw new Error("Cookie is a class with static methods, it doesn't need instantiation.");
		}
		
		/**
		 * Set flash cookie.
		 * @param	cookieName		Cookie name.
		 * @param	cookieValue		Cookie value.
		 * @param	expiresAfter	Number of milliseconds for the cookie to expire (0: no expiration).
		 */
		public static function setCookie(cookieName:String, cookieValue:*, expiresAfter:Number = 0):void
		{
			var so:SharedObject	= SharedObject.getLocal(cookieName);		
			so.data.cookieValue	= cookieValue;
			so.data.expiresAfter = expiresAfter != 0 ? String((new Date()).getTime() + expiresAfter) : "never";		
			so.flush();
		}
		
		/**
		 * Get flash flash cookie value.
		 * @param	cookieName	Cookie name.
		 * @return				Cookie value, or null if expired.
		 */
		public static function getCookie(cookieName:String):*
		{		
			var so:SharedObject = SharedObject.getLocal(cookieName);
			
			var ct:Number = 0;
			if (NumberUtil.isNumber(so.data.expiresAfter))
				ct = Number(so.data.expiresAfter);

			if (ct == 0 || (ct > (new Date()).getTime() && so.data.cookieValue))
				return so.data.cookieValue;
			
			deleteCookie(cookieName);
			return null;
		}
		
		/**
		 * Delete cookie.
		 * @param	cookieName Cookie name to delete.
		 */
		public static function deleteCookie(cookieName:String):void
		{
			SharedObject.getLocal(cookieName).clear();
		}
	}
}