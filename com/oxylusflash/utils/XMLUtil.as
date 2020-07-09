/**
 * @version 12/29/09
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	/**
	 * Class with static methods for XML manipulation.
	 */
	public class XMLUtil
	{
		
		public function XMLUtil()
		{
			throw new Error("XMLUtil is a class with static methods, it doesn't need instantiation.");
		}
		
		/**
		 * Get parameters object from a xml node.
		 * @param	xmlBlock 	The xml block to parse. 
		 * @param	compactStr	Set it to true to make strings that can't be parsed, lowercase and with no extra white spaces
		 * @return				An object with the propeties coresponding to the xml nodes and attributes.
		 * @example	<settings>
		 * 				<param attrib1="string" attrib2="false"> 2 </param>
		 * 			</settings>
		 * 
		 * 			will parse to 
		 * 
		 * 			{ param: 2, param_attrib1: "string", param_attrib2: false }
		 */
		public static function getParams(xmlBlock:XMLList, compactStr:Boolean = false):Object 
		{
			var params:Object = { };
			
			var doc:XMLDocument = new XMLDocument();
			doc.ignoreWhite = true;
			doc.parseXML(xmlBlock.toString());
			
			for (var p:XMLNode = doc.firstChild.firstChild; p != null; p = p.nextSibling)
			{
				var nodeName:String = p.nodeName;

				if (p.hasChildNodes())
				{
					params[nodeName] = StringUtil.parse(p.firstChild.nodeValue, compactStr);
				}				
				
				for (var attrName:String in p.attributes)
				{
					params[nodeName + "_" + attrName] = StringUtil.parse(p.attributes[attrName], compactStr);
				}
			}
			
			return params;
		}
	}
}