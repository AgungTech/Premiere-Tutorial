package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.text.TextFieldAutoSize;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.TextShortcuts;
	//} endregion
	/**
	 * ...
	 * @author Ciprian Chichirita
	 */
	
	public class Answer extends MovieClip
	{
		//{ region FIELDS
		public var mcLine : MovieClip;
		public var mcTxt : MovieClip;
		public var mcLbl : MovieClip;
		
		private const TXT_COLOR : uint = 0xCACACA;
		private var LBL_COLOR : uint = 0x8f8e8e;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function Answer()
		{
			this.x = 0;
			this.y = 0;
			
			mcLine.x = 0;
			mcLine.y = 0;
			
			mcTxt.x = 0;
			mcTxt.y = 0;
			
			mcLbl.x = 0;
			mcLbl.y = 0;
			
			mcLine.width = 0;
			
			//formatting the mcTxt textfield
			mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcTxt.txt.selectable = false;
			mcTxt.txt.condenseWhite = true;
			mcTxt.txt.multiline = false;
			mcTxt.txt.embedFonts = true;
			mcTxt.txt.wordWrap = false;
			mcTxt.txt.textColor = TXT_COLOR;
			mcTxt.txt.text = "";
			mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcTxt.txt.background = true;
			//mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the mcLbl textfield
			mcLbl.txt.autoSize = TextFieldAutoSize.LEFT;
			mcLbl.txt.selectable = false;
			mcLbl.txt.condenseWhite = true;
			mcLbl.txt.multiline = false;
			mcLbl.txt.embedFonts = true;
			mcLbl.txt.wordWrap = false;
			mcLbl.txt.textColor = LBL_COLOR;
			mcLbl.txt.text = "";
			mcLbl.txt.mouseWheelEnabled = false;
			//for testing only
			//mcLbl.txt.background = true;
			//mcLbl.txt.backgroundColor = 0x006633;
		}
		//} endregion
	}
}