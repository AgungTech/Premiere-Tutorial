/**
 * @version 02/01/10
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	/**
	 * Class with static methods for working with SWFAddress.
	 */
	public class AddressUtil
	{
		public function AddressUtil()
		{
			throw new Error("AddressUtil is a class with static methods, it doesn't need instantiation.");
		}
		
		/**
		 * Transforms address string to a standard form.
		 * @param	adr		Address to clean.
		 * @param 	len 	Length of the cleaned address, 0 for max length.
		 * @return			Cleaned address string.
		 */
		public static function clean(adr:String, len:uint = 0):String
		{
			if (len == 0) len = uint.MAX_VALUE;
			
			adr += "/";
			var temp:String = "";
			var part:String = "";
			var n:uint = adr.length;
			var allowed:String = "~_-";
			
			for (var i:uint = 0; i < n; i++)
			{
				var c:String = adr.charAt(i).toLowerCase();
				if (c == "\\") c = "/";
				var cc:uint = c.charCodeAt(0);
				
				if (c == "/" || i == n - 1)
				{
					if (part != "" && part != "/")
					{
						temp += part;
						part = "/";
						
						len--;
						if (len == 0) break;
					}
				}
				else if ((cc >= 48 && cc <= 57) || (cc >= 97 && cc <= 122) || allowed.indexOf(c) >= 0)
				{
					part += c;
				}				
			}
			
			return temp;
		}
		
		/**
		 * Compare two address strings.
		 * @param	adr1		Address string.
		 * @param	adr2		Address string.
		 * @param	cleanAdr	If true, strings will first be cleaned.
		 * @return				-1 (if adr1 is contained in adr2), 0 (if adr1 == adr2), 1 (if adr1 contains adr2), -2 (if adr1 != adr2)
		 */
		public static function compare(adr1:String, adr2:String, cleanAdr:Boolean = false):int
		{
			if (cleanAdr)
			{
				adr1 = clean(adr1);
				adr2 = clean(adr2);
			}
			
			var n1:uint = adr1.length;
			var n2:uint = adr2.length;
			var n:uint = n1;
			
			if (n1 > n2)
			{
				if (adr1.charAt(n2) != "/")
					return -2;
					
				n = n2;
			}
			else if (n1 < n2)
			{
				if (adr2.charAt(n1) != "/")
					return -2;
			}
			
			for (var i:uint = 0; i < n; i++)
			{
				if (adr1.charAt(i) != adr2.charAt(i))
					return -2;
			}
			
			return NumberUtil.sign(n1 - n2);
		}
	}
}