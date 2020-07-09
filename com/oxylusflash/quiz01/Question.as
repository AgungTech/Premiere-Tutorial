package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	import caurina.transitions.properties.TextShortcuts;

	import org.osflash.signals.Signal;
	
	import com.oxylusflash.quiz01.Radius;
	//} endregion
	/**
	 * ...
	 * @author Ciprian Chichirita
	 */
	public class Question extends MovieClip
	{
		//{ region FIELDS
		public var mcDropDown : MovieClip;
		public var N : MovieClip;
		public var O : MovieClip;
		public var Out : MovieClip;
		public var mcTr : MovieClip;
		public var mcDown : MovieClip;
		public var mcOk : MovieClip;
		public var mcTxt : MovieClip;
		public var mcNr : MovieClip;
		public var CurrSel : MovieClip;
		public var Sel : MovieClip;
		
		//SET COMPONENTS COLOR
		private const OK_O_COLOR : uint = 0xa3aa10;
		private const OK_N_COLOR : uint = 0x000000;
		private const OK_OUT_COLOR : uint = 0xd6d6d6;
		private const N_COLOR : uint = 0x585858;
		private const O_COLOR : uint = 0x8f8e8e;
		private const NUMBER_COLOR : uint = 0x000000;
		private const INPUT_TEXT_COLOR_N : uint = 0xa3aa10;
		
		private const _OK : String = "OK PRESSED";
		
		private var _okBtnSignal : Signal;
		private var _clickBtnSignal : Signal;
		private var _allRadiusSignal : Signal;
		
		private var _correctAnswer : Number = 0;
		private var delType : String = "";
		private var _qIndex : Number = 0;
		private var _clickType : String = "";
		private var _pWas : Boolean = true;
		private var _pOkPressed : Boolean = false;
		private var checkClick : Boolean = false;
		
		private var oldRadius : Radius;
		private var firstRadiusFlag : Boolean = true;
		private var oldRadiusIndex : int = -1;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function Question()
		{
			ColorShortcuts.init();
			TextShortcuts.init();
			
			_okBtnSignal = new Signal(String, Number);
			_clickBtnSignal = new Signal(Number, String);
			
			this.alpha = 0;
			this.visible = false;
			
			this.buttonMode = true;
			this.mouseChildren = true;
			
			mcNr.buttonMode = true;
			mcNr.mouseChildren = false;
			
			mcTxt.buttonMode = true;
			mcTxt.mouseChildren = false;
			
			mcTr.buttonMode = true;
			mcTr.mouseChildren = false;
			
			mcDropDown.visible = false;
			mcDropDown.alpha = 0;
			
			mcDropDown.mcInput.visible = false;
			mcDropDown.mcInput.alpha = 0;
			
			mcDropDown.mcInput.Out.visible = false;
			mcDropDown.mcInput.Out.alpha = 0;
			
			mcDropDown.mcInput.O.visible = false;
			mcDropDown.mcInput.O.alpha = 0;
			
			mcDropDown.mcBulletHld.visible = false;
			mcDropDown.mcBulletHld.alpha = 0;
			
			mcDropDown.mcOut.visible = false;
			mcDropDown.mcOut.alpha = 0;
			
			mcDropDown.CurrSel.visible = false;
			mcDropDown.CurrSel.alpha = 0;
			
			mcOk.buttonMode = true;
			mcOk.mouseChildren = false;
			
			Out.visible = false;
			Out.alpha = 0;
			
			Sel.visible = false;
			Sel.alpha = 0;
			
			mcOk.O.visible = false;
			mcOk.O.alpha = 0;
			
			//formatting the mcDropDown.mcInput textfield
			//mcDropDown.mcInput.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcDropDown.mcInput.mcTxt.txt.selectable = true;
			mcDropDown.mcInput.mcTxt.txt.condenseWhite = true;
			mcDropDown.mcInput.mcTxt.txt.multiline = false;
			mcDropDown.mcInput.mcTxt.txt.embedFonts = true;
			mcDropDown.mcInput.mcTxt.txt.wordWrap = true;
			mcDropDown.mcInput.mcTxt.txt.textColor = INPUT_TEXT_COLOR_N;
			mcDropDown.mcInput.mcTxt.txt.text = "";
			mcDropDown.mcInput.mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcDropDown.mcInput.mcTxt.txt.background = true;
			//mcDropDown.mcInput.mcTxt.txt.backgroundColor = 0x006633;
			
			
			//formatting the Ok button
			mcOk.N.txt.autoSize = TextFieldAutoSize.LEFT;
			mcOk.N.txt.selectable = false;
			mcOk.N.txt.condenseWhite = true;
			mcOk.N.txt.multiline = false;
			mcOk.N.txt.embedFonts = true;
			mcOk.N.txt.wordWrap = false;
			mcOk.N.txt.textColor = OK_N_COLOR;
			mcOk.N.txt.text = "";
			//for testing only
			//mcOk.N.txt.background = true;
			//mcOk.N.txt.backgroundColor = 0x006633;
			
			//formatting the button title
			mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcTxt.txt.selectable = false;
			mcTxt.txt.condenseWhite = true;
			mcTxt.txt.multiline = true;
			mcTxt.txt.embedFonts = true;
			mcTxt.txt.wordWrap = true;
			mcTxt.txt.textColor = N_COLOR;
			mcTxt.txt.text = "";
			mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcTxt.txt.background = true;
			//mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the button number textfield
			mcNr.txt.autoSize = TextFieldAutoSize.LEFT;
			mcNr.txt.selectable = false;
			mcNr.txt.condenseWhite = true;
			mcNr.txt.multiline = false;
			mcNr.txt.embedFonts = true;
			mcNr.txt.wordWrap = false;
			mcNr.txt.textColor = NUMBER_COLOR;
			mcNr.txt.text = "";
			mcNr.txt.mouseWheelEnabled = false;
			//for testing only
			//mcNr.txt.background = true;
			//mcNr.txt.backgroundColor = 0x006633;
			
			mcDropDown.mcInput.mcTxt.txt.addEventListener(FocusEvent.FOCUS_IN, input_FocusInHandler, false, 0, true);
			mcDropDown.mcInput.mcTxt.txt.addEventListener(FocusEvent.FOCUS_OUT, input_FocusOutHandler, false, 0, true);
		}
		//} endregion
		
		//{ region EVENT HANDLERS//////////////////////////////////////////////////
		
		//{ region RADIUS CLICKED SIGNAL HANDLER
		internal final function radiusClickedSignalHandler(pGeneralIndex : int, pRadius : Radius):void 
		{
			if (oldRadius != pRadius && firstRadiusFlag)
			{
				firstRadiusFlag = false;
				oldRadiusIndex = pGeneralIndex;
				oldRadius = pRadius;
			}
			
			if (oldRadius != pRadius)
			{
				_allRadiusSignal.dispatch(oldRadiusIndex, oldRadius);
				oldRadiusIndex = pGeneralIndex;
				oldRadius = pRadius;
			}
			
		}
		//} endregion
		
		//{ region DEL
		private final function del(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, del);
			
			switch (delType)
			{
				case "EXPANDED":
					removeChild(N);
					removeChild(mcTr);
					removeChild(Out);
					removeChild(Sel);
				break;
				
				case "ANSWER":
					removeChild(Sel);
					removeChild(CurrSel);
					removeChild(mcOk);
					removeChild(mcDown);
					removeChild(mcTr);
					removeChild(Out);
					removeChild(N);
					mcDropDown.removeChild(mcDropDown.mcInput);
					mcDropDown.removeChild(mcDropDown.mcBulletHld);
					mcDropDown.removeChild(mcDropDown.mcOut);
					mcDropDown.removeChild(mcDropDown.CurrSel);
				break;
				
				case "CHECK":
					mcDropDown.removeChild(mcDropDown.mcInput);
				break;
				
				case "RADIUS":
					mcDropDown.removeChild(mcDropDown.mcInput);
				break;
				
				case "INPUT":
					mcDropDown.removeChild(mcDropDown.mcBulletHld);
				break;
				
				case "REMOVE OK":
					removeChild(mcOk);
				break;
				
				case "NORMAL":
					removeChild(CurrSel);
					mcDropDown.removeChild(mcDropDown.CurrSel);
				break;
			}
			
		}
		//} endregion
		
		//{ region INPUT FOCUS HANDLER
		internal final function input_FocusInHandler(e:FocusEvent = null):void 
		{
			_pOkPressed = true;
			dispatchBtnPressed();
			mcDropDown.mcInput.O.visible = true;
			Tweener.addTween(mcDropDown.mcInput.O, { alpha:1, time: 0.3, transition: "easeoutquad" } );
		}
		//} endregion
		
		//{ region INPUT FOCUS OUT HANDLER
		internal final function input_FocusOutHandler(e:FocusEvent = null):void 
		{
			_pOkPressed = false;
			Tweener.addTween(mcDropDown.mcInput.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcDropDown.mcInput.O.visible = false;
			} } );
		}
		//} endregion
		
		//{ region MC OK ROLL OVER HANDLER
		private final function mcOk_RollOverHandler(e:MouseEvent):void 
		{
			_pOkPressed = true;
			mcOk.O.visible = true;
			Tweener.addTween(mcOk.O, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcOk.N.txt, { _text_color: OK_O_COLOR, time: 0.3, transition: "easeOutQuad" } );
		}
		//} endregion
		
		//{ region MC OK CLICK HANDLER
		private final function mcOk_ClickHandler(e:MouseEvent):void 
		{
			_pOkPressed = true;
			_okBtnSignal.dispatch(_OK, _correctAnswer);
		}
		//} endregion
		
		//{ region MC OK ROLL OUT HANDLER
		private final function mcOk_RollOutHandler(e:MouseEvent):void 
		{
			_pOkPressed = false;
			Tweener.addTween(mcOk.O, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcOk.O.visible = false;
			} });
			Tweener.addTween(mcOk.N.txt, { _text_color: OK_N_COLOR, time: 0.3, transition: "easeOutQuad" } );
		}
		//} endregion
		
		//{ region ROLL OVER HANDLER
		private final function rollOverHandler(e:MouseEvent):void 
		{
			O.visible = true;
			Tweener.addTween(O, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			
			Tweener.addTween(mcTxt.txt, { _text_color: O_COLOR, time: 0.3, transition: "easeoutquad" } );
			
			mcTr.O.visible = true;
			Tweener.addTween(mcTr.O, { alpha:1, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region CLICK HANDLER
		internal final function clickHandler(e:MouseEvent):void 
		{
			if (!_pOkPressed && checkClick)
			{
				_clickBtnSignal.dispatch(_qIndex, clickType);
			}
			
			if (!checkClick) 
			{
				_clickBtnSignal.dispatch(_qIndex, clickType);
			}
		}
		//} endregion
		
		//{ region ROLL OUT HANDLER
		private final function rollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(O, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				O.visible = false;
			} } );
			
			Tweener.addTween(mcTxt.txt, { _text_color: N_COLOR, time: 0.3, transition: "easeoutquad" } );
			
			Tweener.addTween(mcTr.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcTr.O.visible = false;
			} });
		}
		//} endregion
		
		//} endregion
		
		//{ region METHODS////////////////////////////////////////////////////////
		
		//{ region MODE
		internal final function mode(pMode: String = ""):void 
		{
			switch (pMode)
			{
				case "true":
					clickType = "EXPANDED";
					delType = "EXPANDED";
					
					checkClick = false;
					
					N.visible = false;
					N.alpha = 0;
					
					mcTr.visible = false;
					mcTr.alpha = 0;
					
					CurrSel.visible = false;
					CurrSel.alpha = 0;
					
					if (stage)
					{
						del();
					}else 
					{
						this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
					}
				break;
				
				case "remove ok btn":
					delType = "REMOVE OK";
					if (stage) 
					{
						del();
					}else 
					{
						this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
					}
					this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
				break;
				
				case "false":
					clickType = "NORMAL";
					delType = "NORMAL";
					
					checkClick = true;
					
					this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
					this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
					this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
					
					O.buttonMode = true;
					Out.buttonMode = true;
					mcDropDown.buttonMode = true;
					
					O.visible = false;
					O.alpha = 0;
					
					Sel.visible = false;
					Sel.alpha = 0;
					
					CurrSel.visible = false;
					CurrSel.alpha = 0;
					
					mcDown.visible = false;
					mcDown.alpha = 0;
					
					mcTr.O.visible = false;
					mcTr.O.alpha = 0;
					
					if (stage) 
					{
						del();
					}else 
					{
						this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
					}
				break;
				
				case "answer":
					delType = "ANSWER";
					this.buttonMode = false;
					
					CurrSel.visible = false;
					CurrSel.alpha = 0;
					
					mcOk.visible = false;
					mcOk.alpha = 0;
					
					mcDown.visible = false;
					mcDown.alpha = 0;
					
					mcTr.visible = false;
					mcTr.alpha = 0;
					
					mcNr.buttonMode = false;
					mcNr.mouseChildren = false;
					
					mcTxt.buttonMode = false;
					mcTxt.mouseChildren = false;
					
					if (stage)
					{
						del();
					}else 
					{
						this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
					}
				break;
			}
		}
		//} endregion
		
		//{ region BTN TYPE
		internal final function btnType(pType : Boolean = true):void 
		{
			if (pType)
			{
				Tweener.removeTweens(mcOk.N.txt);
				
				mcOk.N.txt.textColor = OK_NORMAL_COLOR;
				
				mcOk.addEventListener(MouseEvent.ROLL_OVER, mcOk_RollOverHandler, false, 0, true);
				mcOk.addEventListener(MouseEvent.CLICK, mcOk_ClickHandler, false, 0, true);
				mcOk.addEventListener(MouseEvent.ROLL_OUT, mcOk_RollOutHandler, false, 0, true);
				
			}else 
			{
				Tweener.removeTweens(mcOk.N.txt);
				
				mcOk.N.txt.textColor = OK_OT_COLOR;
				
				mcOk.removeEventListener(MouseEvent.ROLL_OVER, mcOk_RollOverHandler);
				mcOk.removeEventListener(MouseEvent.CLICK, mcOk_ClickHandler);
				mcOk.removeEventListener(MouseEvent.ROLL_OUT, mcOk_RollOutHandler);
			}
		}
		//} endregion
		
		//{ region REMOVE MC
		internal final function removeMc(pType : String):void 
		{
			switch (pType)
			{
				case "RADIUS":
				delType = "RADIUS";
				if (stage)
				{
					del();
				}else 
				{
					this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
				}
				break;
				
				case "CHECK":
				delType = "CHECK";
				if (stage)
				{
					del();
				}else 
				{
					this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
				}
				break;
				
				case "INPUT":
				delType = "INPUT";
				if (stage) 
				{
					del();
				}else 
				{
					this.addEventListener(Event.ADDED_TO_STAGE, del, false, 0, true);
				}
				break;
			}
		}
		//} endregion
		
		//{ region SETY
		internal final function setY(pQ:Question, pType: Boolean, padY : Number, pDropDownY : Number):void 
		{
			if (pQ.mcDropDown.visible) 
			{
				if (pType)
				{
					this.y = Math.round(pQ.y + pQ.O.height + (pQ.mcDropDown.height - pDropDownY) + padY);
				}else 
				{
					this.y = Math.round(pQ.y + pQ.O.height + pQ.mcDropDown.height + padY);
				}
			}else 
			{
				this.y = Math.round(pQ.y + pQ.O.height + padY);
			}
		}
		//} endregion
		
		//{ region RADIUS ALL SIGNAL
		internal function radiusAllSignal():void 
		{
			_allRadiusSignal = new Signal(Number, Radius);
		}
		//} endregion
		
		//{ region DISPATCH BTN PRESSED
		internal final function dispatchBtnPressed():void
		{
			if (checkClick) 
			{
				_clickBtnSignal.dispatch(_qIndex, "BTN PRESSED");
			}
		}
		//} endregion
		
		//} endregion
		
		//{ region PROPERTIES
		internal function get okBtnSignal():Signal { return _okBtnSignal; }
		
		internal function set okBtnSignal(value:Signal):void 
		{
			_okBtnSignal = value;
		}
		
		public function get OK_OVER_COLOR():uint { return OK_O_COLOR; }
		
		public function get OK_NORMAL_COLOR():uint { return OK_N_COLOR; }
		
		public function get OK_OT_COLOR():uint { return OK_OUT_COLOR; }
		
		internal function get correctAnswer():Number { return _correctAnswer; }
		
		internal function set correctAnswer(value:Number):void 
		{
			_correctAnswer = value;
		}
		
		public function get OK():String { return _OK; }
		
		internal function get clickBtnSignal():Signal { return _clickBtnSignal; }
		
		internal function set clickBtnSignal(value:Signal):void 
		{
			_clickBtnSignal = value;
		}
		
		internal function get qIndex():Number { return _qIndex; }
		
		internal function set qIndex(value:Number):void 
		{
			_qIndex = value;
		}
		
		internal function get pWas():Boolean { return _pWas; }
		
		internal function set pWas(value:Boolean):void 
		{
			_pWas = value;
		}
		
		internal function get pOkPressed():Boolean { return _pOkPressed; }
		
		internal function set pOkPressed(value:Boolean):void 
		{
			_pOkPressed = value;
		}
		
		internal function get clickType():String { return _clickType; }
		
		internal function set clickType(value:String):void 
		{
			_clickType = value;
		}
		
		public function get allRadiusSignal():Signal { return _allRadiusSignal; }
		
		public function set allRadiusSignal(value:Signal):void 
		{
			_allRadiusSignal = value;
		}
		
		//} endregion
	}
}