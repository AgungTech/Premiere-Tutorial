/**
 * @version 12/29/09
 * @author Adrian Bota, adrian@oxylus.ro
 */
package com.oxylusflash.utils
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Add this class as Document class. 
	 * Import class and use Console.write() or Console.clear()
	 */
	public class Console extends MovieClip
	{
		private static var mcInst:Sprite;
		private static var tfInst:TextField;		
		
		public function Console()
		{
			if (!mcInst)
			{
				if (this.stage)
				{
					mcInst = stage.addChild(new Sprite) as Sprite;
					mcInst.x = 1;
					mcInst.y = 1;
					
					tfInst = mcInst.addChild(new TextField) as TextField;
					tfInst.autoSize = TextFieldAutoSize.LEFT;
					tfInst.background = true;
					tfInst.backgroundColor = 0x211E1E;
					tfInst.border = true;
					tfInst.borderColor = 0x404040;
					tfInst.mouseWheelEnabled = false;
					tfInst.multiline = true;
					tfInst.selectable = true;
					tfInst.type = TextFieldType.DYNAMIC;
					tfInst.wordWrap = false;
				
					clear();
				}
			}
		}
		
		/**
		 * Write messages to console.
		 * @param	...messages
		 */
		public static function write(...messages):void
		{
			if (mcInst)
			{
				tfInst.htmlText += "<font style='display:block;' face='Courier New' size='11' color='#C1C144'>" + messages.join("<font color='#454545'> / </font>") + "</font>";
			}
		}
		
		/**
		 * Clear console.
		 */
		public static function clear():void
		{
			if (mcInst)
			{
				tfInst.htmlText = "<font style='display:block;' face='Courier New' size='11' color='#70a0F0'><i>CONSOLE OUTPUT:</i></font>";
			}			
		}
	}
}