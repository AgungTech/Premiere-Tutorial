package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	import org.osflash.signals.Signal;
	//} endregion
	/**
	 * ...
	 * @author Ciprian Chichirita
	 */
	public class Check extends MovieClip
	{
		//{ region FIELDS
		public var mcTxt : MovieClip;
		public var mcCheck : MovieClip;
		
		//SET COMPONENTS COLOR
		private const BULLET_N_COLOR : uint = 0x8f8e8e;
		private const BULLET_CHECKED_COLOR : uint = 0xa3aa10;
		private const BULLET_O_COLOR : uint = 0xFFFFFF;
		
		private const SIGNAL : String = "OVER & OUT";
		
		private var _selNotFlag : Boolean = true;
		private var _attrExists : Boolean = false;
		private var _generalIndex :int = 0;
		private var _bulletAction : Signal;
		private var createdSignal : Boolean = false;
		private var iAmChecked : Boolean = false;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function Check()
		{
			TextShortcuts.init();
			
			this.visible = false;
			this.alpha = 0;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			//formatting the TextField
			mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcTxt.txt.selectable = false;
			mcTxt.txt.condenseWhite = true;
			mcTxt.txt.multiline = true;
			mcTxt.txt.embedFonts = true;
			mcTxt.txt.textColor = BULLET_N_COLOR;
			mcTxt.txt.wordWrap = false;
			mcTxt.txt.text = "";
			mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcTxt.txt.background = true;
			//mcTxt.txt.backgroundColor = 0x006633;
			
			mcCheck.O.visible = false;
			mcCheck.O.alpha = 0;
			
			mcCheck.Out.visible = false;
			mcCheck.Out.alpha = 0;
			
			mcCheck.Checked.visible = false;
			mcCheck.Checked.alpha = 0;
			
			mcCheck.OutS.visible = false;
			mcCheck.OutS.alpha = 0;
			
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
		}
		//} endregion
		
		//{ region EVENT HANDLERS////////////////////////////////////////////////////////////
		
		//{ region ROLL OVER HANDLER
		internal final function rollOverHandler(e:MouseEvent = null):void 
		{
			if (e != null && createdSignal)
			{
				_bulletAction.dispatch(SIGNAL, _generalIndex, true);
			}
			
			if (!iAmChecked) 
			{
				mcCheck.O.visible = true;
				Tweener.addTween(mcCheck.O, { alpha:1, time: 0.3, transition: "easeoutquad" } );
				Tweener.addTween(mcTxt.txt, { _text_color:BULLET_O_COLOR , time: 0.3, transition: "easeoutquad" } );
			}
		}
		//} endregion
		
		//{ region CLICK HANDLER
		internal final function clickHandler(e:MouseEvent = null):void 
		{
			toggleSelNot();
			
			MovieClip(parent.parent.parent).dispatchBtnPressed();
			
			if (!_selNotFlag) 
			{
				checked();
			}else 
			{
				notChecked();
			}
		}
		//} endregion
		
		//{ region ROLL OUT HANDLER
		internal final function rollOutHandler(e:MouseEvent = null):void 
		{
			if (e != null && createdSignal)
			{
				_bulletAction.dispatch(SIGNAL, _generalIndex, false);
			}
			if (_selNotFlag)
			{
				Tweener.addTween(mcTxt.txt, { _text_color:BULLET_N_COLOR , time: 0.3, transition: "easeoutquad" });
				Tweener.addTween(mcCheck.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcCheck.O.visible = false;
				} } );
			}
		}
		//} endregion
		
		//} endregion
		
		//{ region METHODS//////////////////////////////////////////////////////////////////
		
		//{ region TOGGLE SEL NOT
		private final function toggleSelNot():void
		{
			_selNotFlag = (_selNotFlag)? false : true;
			
			if (_selNotFlag)
			{
				rollOutHandler();
			}else 
			{
				rollOverHandler();
			}
		}
		//} endregion
		
		//{ region CHECKED
		private final function checked():void
		{
			iAmChecked = true;
			mcCheck.Checked.visible = true;
			Tweener.addTween(mcCheck.Checked, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcTxt.txt, { _text_color:BULLET_CHECKED_COLOR , time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region NOT CHECKED
		private final function notChecked():void
		{
			iAmChecked = false;
			mcCheck.O.visible = true;
			Tweener.addTween(mcCheck.O, { alpha:1, time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcTxt.txt, { _text_color:BULLET_O_COLOR , time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcCheck.Checked, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcCheck.Checked.visible = false;
			} } );
		}
		//} endregion
		
		//{ region CREATE SIGNAL
		internal final function createSignal():void 
		{
			createdSignal = true;
			_bulletAction = new Signal(String, int, Boolean);
		}
		//} endregion
		
		//} endregion
		
		//{ region PROPERTIES
		internal function get selNotFlag():Boolean { return _selNotFlag; }
		
		internal function get N_COLOR():uint { return BULLET_N_COLOR; }
		
		internal function get O_COLOR():uint { return BULLET_O_COLOR; }
		
		internal function get attrExists():Boolean { return _attrExists; }
		
		internal function set attrExists(value:Boolean):void 
		{
			_attrExists = value;
		}
		
		internal function set generalIndex(value:int):void 
		{
			_generalIndex = value;
		}
		
		internal function get bulletAction():Signal { return _bulletAction; }
		
		internal function set bulletAction(value:Signal):void 
		{
			_bulletAction = value;
		}
		//} endregion
	}
}