package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
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
	public class Radius extends MovieClip
	{
		//{ region FIELDS
		public var mcTxt : MovieClip;
		public var mcRadius : MovieClip;
		
		//SET COMPONENTS COLOR
		private const RADIUS_N_COLOR : uint = 0x8f8e8e;
		private const RADIUS_CHECKED_COLOR : uint = 0xa3aa10;
		private const RADIUS_O_COLOR : uint = 0xFFFFFF;
		
		private const SIGNAL : String = "OVER & OUT";
		private var _bulletAction : Signal;
		private var _clickedSignal : Signal;
		
		private var _selNotFlag : Boolean = true;
		private var _generalIndex :int = 0;
		private var _attrExists : Boolean = false;
		private var createdSignal : Boolean = false;
		private var iAmChecked : Boolean = false;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function Radius()
		{
			TextShortcuts.init();
			
			this.visible = false;
			this.alpha = 0;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			_clickedSignal = new Signal(int, Radius);
			
			//formatting the TextField
			mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcTxt.txt.selectable = false;
			mcTxt.txt.condenseWhite = true;
			mcTxt.txt.multiline = true;
			mcTxt.txt.embedFonts = true;
			mcTxt.txt.textColor = RADIUS_N_COLOR;
			mcTxt.txt.wordWrap = false;
			mcTxt.txt.text = "";
			mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcTxt.txt.background = true;
			//mcTxt.txt.backgroundColor = 0x006633;
			
			mcRadius.O.visible = false;
			mcRadius.O.alpha = 0;
			
			mcRadius.Checked.visible = false;
			mcRadius.Checked.alpha = 0;
			
			mcRadius.Out.visible = false;
			mcRadius.Out.alpha = 0;
			
			mcRadius.OutS.visible = false;
			mcRadius.OutS.alpha = 0;
			
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
		}
		//} endregion
		
		//{ region EVENT HANDLERS/////////////////////////////////////////////
		
		//{ region ALL RADIUS SIGNAL HANDLER
		private final function allRadiusSignalHandler(pGeneralIndex : int, pRadius : Radius):void
		{
			if (pGeneralIndex == _generalIndex)
			{
				pRadius.selNotFlag = true;
				pRadius.notChecked(false);
			}
		}
		//} endregion
		
		//{ region ROLL OVER HANDLER
		internal final function rollOverHandler(e:MouseEvent = null):void 
		{
			if (e != null && createdSignal)
			{
				_bulletAction.dispatch(SIGNAL, _generalIndex, true);
			}
			
			if (!iAmChecked) 
			{
				mcRadius.O.visible = true;
				Tweener.addTween(mcRadius.O, { alpha:1, time: 0.3, transition: "easeoutquad" } );
				Tweener.addTween(mcTxt.txt, { _text_color:RADIUS_O_COLOR , time: 0.3, transition: "easeoutquad" } );
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
				Tweener.addTween(mcTxt.txt, { _text_color:RADIUS_N_COLOR , time: 0.3, transition: "easeoutquad" });
				Tweener.addTween(mcRadius.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcRadius.O.visible = false;
				} } );
			}
		}
		//} endregion
		
		//} endregion
		
		//{ region METHODS////////////////////////////////////////////////////
		
		//{ region TOGGLE SEL NOT
		private final function toggleSelNot():void
		{
			_selNotFlag = (_selNotFlag)? false : true;
			
			if (_selNotFlag)
			{
				rollOutHandler();
			}else 
			{
				_clickedSignal.dispatch(_generalIndex, this);
				rollOverHandler();
			}
		}
		//} endregion
		
		//{ region CREATE SIGNAL
		internal final function createSignal():void 
		{
			createdSignal = true;
			_bulletAction = new Signal(String, int, Boolean);
		}
		//} endregion
		
		//{ region GO LISTEN
		internal final function goListen():void 
		{
			MovieClip(parent.parent.parent).allRadiusSignal.add(allRadiusSignalHandler);
		}
		//} endregion
		
		//{ region REMOVE LISTEN
		internal final function remListen():void 
		{
			MovieClip(parent.parent.parent).allRadiusSignal.remove(allRadiusSignalHandler);
		}
		//} endregion
		
		//{ region CHECKED
		private final function checked():void
		{
			iAmChecked = true;
			mcRadius.Checked.visible = true;
			Tweener.addTween(mcTxt.txt, { _text_color:RADIUS_CHECKED_COLOR , time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcRadius.Checked, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
		}
		//} endregion
		
		//{ region NOT CHECKED
		private final function notChecked(pType : Boolean = true):void
		{
			iAmChecked = false;
			if (pType) 
			{
				mcRadius.O.visible = true;
				Tweener.addTween(mcRadius.O, { alpha:1, time: 0.3, transition: "easeoutquad" } );
				Tweener.addTween(mcTxt.txt, { _text_color:RADIUS_O_COLOR , time: 0.3, transition: "easeoutquad" } );
			}else 
			{
				Tweener.addTween(mcTxt.txt, { _text_color:RADIUS_N_COLOR , time: 0.3, transition: "easeoutquad" });
				Tweener.addTween(mcRadius.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcRadius.O.visible = false;
				} } );
			}
			
			Tweener.addTween(mcRadius.Checked, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcRadius.Checked.visible = false;
			} } );
		}
		//} endregion
		
		//} endregion
		
		//{ region PROPERTIES
		
		internal function get N_COLOR():uint { return RADIUS_N_COLOR; }
		
		internal function get O_COLOR():uint { return RADIUS_O_COLOR; }
		
		internal function set generalIndex(value:int):void 
		{
			_generalIndex = value;
		}
		
		internal function get attrExists():Boolean { return _attrExists; }
		
		internal function set attrExists(value:Boolean):void 
		{
			_attrExists = value;
		}
		
		internal function get bulletAction():Signal { return _bulletAction; }
		
		internal function set bulletAction(value:Signal):void 
		{
			_bulletAction = value;
		}
		
		internal function get clickedSignal():Signal { return _clickedSignal; }
		
		internal function set clickedSignal(value:Signal):void 
		{
			_clickedSignal = value;
		}
		
		internal function get selNotFlag():Boolean { return _selNotFlag; }
		
		internal function set selNotFlag(value:Boolean):void 
		{
			_selNotFlag = value;
		}
		//} endregion
	}
}
