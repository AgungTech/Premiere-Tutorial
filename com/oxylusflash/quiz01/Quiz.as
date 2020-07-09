package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	//import flash.display.StageAlign;
	//import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	import flash.system.System;
	
	import com.oxylusflash.quiz01.Question;
	import com.oxylusflash.quiz01.ScrollBar;
	import com.oxylusflash.quiz01.Check;
	import com.oxylusflash.quiz01.Answer;
	
	import com.oxylusflash.utils.XMLUtil;
	import com.oxylusflash.utils.StringUtil;
	import com.oxylusflash.utils.Utils;
	
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	import caurina.transitions.properties.ColorShortcuts;
	
	import org.osflash.signals.Signal;
	//} endregion
	
	/**
	 * ...
	 * @author Ciprian Chichirita
	 */
	public class Quiz extends MovieClip
	{
		//{ region FIELDS
		public var Bg : MovieClip;
		public var mcMask : MovieClip;
		public var mcBody : MovieClip;
		public var mcHead : MovieClip;
		public var mcLogo : MovieClip;
		public var mcStartPage : MovieClip;
		public var mcScrollbar : ScrollBar;
		
		//SET COMPONENT COLOR
		private const VIEW_DETAILS_N_COLOR : uint = 0x010101;
		private const VIEW_DETAILS_O_COLOR : uint = 0xdd00dd;
		private const START_PAGE_BTN_N : uint = 0x010101;
		private const START_PAGE_BTN_O : uint = 0xdd00dd;
		private const BODY_BACK_TXT_N : uint = 0xdd00dd;
		private const BODY_BACK_TXT_O : uint = 0x7b8008;
		private const BODY_BACK_ARROW_N : uint = 0xdd00dd;
		private const BODY_BACK_ARROW_O : uint = 0x7a7f07;
		private const RESULT_BTN_N : uint = 0x010101;
		private const RESULT_BTN_O : uint = 0xdd00dd;
		private const QUESTION_INPUT_OUT_TXT_COLOR : uint = 0x8f8e8e;
		private const QUESTION_INPUT_NORMAL_TXT_COLOR : uint = 0xdd00dd;
		private const BODY_OK_BTN_N_COLOR : uint = 0x000000;
		private const BODY_OK_BTN_O_COLOR : uint = 0xdd00dd;
		
		//SET COMPONENT COORD
		private const LOGO_X : uint = 4;
		private const LOGO_Y : uint = 1;
		private const HEAD_TITLE_X : uint = 20;
		private const HEAD_TITLE_Y : uint = 18;
		private const HEAD_Y : uint = 0;//it acts like a margin;
		private const HEAD_X : uint = 0;//it acts like a margin;
		private const BODY_X : uint = 0;//it acts like a margin;
		private const BODY_Y : uint = 0;//it acts like a margin;
		private const STARTPAGE_X : uint = 33;
		private const STARTPAGE_Y : uint = 34;
		private const STARTPAGE_TXT_X : uint = 0;
		private const STARTPAGE_TXT_Y : uint = 0;
		private const STARTPAGE_TXT_PAD : uint = 18;
		private const STARTPAGE_BTN_TOP_PAD : uint = 11;
		private const STARTPAGE_BTN_LEFT_PAD : uint = 14;
		private const STARTPAGE_TXT_PAD_H : int = 1;
		private const STARTPAGE_TXT_PAD_W : int = -1;
		private const SCROLLBAR_LEFT_PAD_STARTPAGE : uint = 9;
		private const QUESTION_POS_X : Number = 0;
		private const QUESTION_POS_Y : Number = 2;
		private const HOLDER_POS_X : uint = 22;
		private const HOLDER_PAD_TOP : uint = 22;
		private const SCROLLBAR_LEFT_PAD_HOLDERPAD : uint = 9;
		private const SCROLLBAR_LEFT_PAD_ANSWERPAD : uint = 9;
		private const SCROLLBAR_LEFT_PAD_RESULTPAD : uint = 22;
		private const MC_H_POS_X : uint = 0;
		private const MC_H_POS_Y : uint = 0;
		private const QUESTION_NR_PAD_TOP : uint = 10;
		private const QUESTION_NR_PAD_LEFT : uint = 11;
		private const QUESTION_TXT_PAD_TOP : uint = 9;
		private const QUESTION_TXT_PAD_LEFT : uint = 0;
		private const QUESTION_TXT_PAD_RIGHT : uint = 6
		private const QUESTION_OK_PAD_LEFT : uint = 5;
		private const QUESTION_OK_PAD_TOP : uint = 7;
		private const QUESTION_OK_POS_X : uint = 6;
		private const QUESTION_OK_POS_Y : uint = 6;
		private const QUESTION_OK_OFFSET : uint = 3;
		private const QUESTION_OK_OFFSET_Y : uint = 1;
		private const QUESTION_DOWN_PAD_LEFT : uint = 14;
		private const QUESTION_DOWN_PAD_TOP : uint = 3;
		private const BODY_TIME_Y : uint = 22;
		private const BODY_TIME_X : uint = 34;
		private const BODY_TIME_X_OFFSET : uint = 8;
		private const BODY_CRT_POS_X : uint = 22;
		private const BODY_CRT_POS_Y : uint = 0;
		private const BODY_MASK_HOLDER_PAD : uint = 1;
		private const QUESTION_CURRSEL_POS_Y : uint = 0;
		private const QUESTION_CURRSEL_POS_X : uint = 0;
		private const BODY_CRT_TXT_PAD_TOP : uint = 18;
		private const BODY_CRT_TXT_PAD_LEFT : uint = 14;
		private const BODY_CRT_TXT_PAD_BOTTOM : uint = 3;
		private const QUESTION_INPUT_PAD_LEFT : uint = 13;
		private const QUESTION_INPUT_PAD_TOP : uint = 13;
		private const QUESTION_INPUT_PAD_OFFSET : uint = 3;
		private const QUESTION_INPUT_INPUTTXT_PAD_LEFT : uint = 2;
		private const QUESTION_INPUT_INPUTTXT_PAD_TOP : uint = 0;
		private const QUESTION_DROP_DOWN_PAD_TOP : uint = 3;
		private const QUESTION_DROP_DOWN_PAD_LEFT : uint = 0;
		private const QUESTION_DROP_DOWN_BULLET_HLD_PAD_TOP : uint = 3;
		private const QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT : uint = 12;
		private const QUESTION_BULLET_BULLET_POS_TOP : uint = 3;
		private const QUESTION_BULLET_BULLET_POS_LEFT : uint = 0;
		private const QUESTION_BULLET_TXT_POS_TOP : uint = 0;
		private const QUESTION_BULLET_TXT_POS_LEFT : uint = 1;
		private const QUESTION_BULLET_POS_TOP : uint = 10;
		private const QUESTION_BULLET_POS_LEFT : uint = 0;
		private const BODY_VIEWDETAILS_POS_X : uint = 22;
		private const BODY_VIEWDETAILS_POS_Y : uint = 0;
		private const BODY_VIEWDETAILS_TXT_POS_Y : Number = 22;
		private const BODY_VIEWDETAILS_WIDTH_PAD_X : uint = 9;
		private const BODY_RESULT_POS_X : uint = 33;
		private const BODY_RESULT_POS_Y : uint = 22;
		private const BODY_RESULT_CONTENT_MASK_OFFSET : uint = 22;
		private const BODY_REDOQUIZ_POS_X : uint = 22;
		private const BODY_REDOQUIZ_POS_Y : uint = 0;
		private const BODY_RESULT_TITLE_CONTENT_MASK_POS_X : uint = 0;
		private const BODY_RESULT_TITLE_CONTENT_MASK_POS_Y : uint = 0;
		private const BODY_REDOQUIZ_TXT_OFFSET_X : uint = 8;
		private const BODY_REDOQUIZ_TXT_OFFSET_Y : uint = 5;
		private const BODY_REDOQUIZ_TXT_PAD_X : uint = 1;
		private const BODY_REDOQUIZ_TXT_PAD_Y : uint = 1;
		private const BODY_BACK_ARROW_POS_X : uint = 0;
		private const BODY_BACK_ARROW_POS_Y : uint = 0;
		private const BODY_BACK_TXT_POS_Y : uint = 0;
		private const BODY_BACK_POS_Y : uint = 21;
		private const ANSWER_O_POS_X : uint = 0;
		private const ANSWER_O_POS_Y : uint = 0;
		private const ANSWER_NR_PAD_TOP : uint = 10;
		private const ANSWER_NR_PAD_LEFT : uint = 11;
		private const ANSWER_TXT_PAD_LEFT : uint = 0;
		private const ANSWER_TXT_PAD_TOP : uint = 9;
		private const ANSWER_TXT_PAD_RIGHT : uint = 6;
		private const ANSWER_POS_X : Number = 0;
		private const ANSWER_POS_Y : Number = 2;
		private const ANSWER_DROP_DOWN_PAD_LEFT : uint = 0;
		private const ANSWER_DROP_DOWN_PAD_TOP : uint = 3;
		private const ANSWER_ANSW_POS_X : uint = 9;
		private const ANSWER_ANSW_POS_Y : uint = 11;
		private const ANSWER_ANSW_CORRECT_POS_X : uint = 0;
		private const ANSWER_ANSW_CORRECT_POS_Y : uint = 0;
		private const ANSWER_ANSW_YOUR_ANSW_POS_Y : uint = 0;
		private const ANSWER_ANSW_YOUR_ANSW_POS_X : uint = 0;
		private const ANSWER_ANSW_SCORE_POS_X : uint = 0;
		private const ANSWER_ANSW_SCORE_POS_Y : uint = 0;
		private const ANSWER_ANSW_CORRECT_TXT_PAD_X : uint = 3;
		private const ANSWER_ANSW_CORRECT_TXT_PAD_Y : uint = 0;
		private const ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X : uint = 3;
		private const ANSWER_ANSW_YOUR_ANSW_TXT_PAD_Y : uint = 0;
		private const ANSWER_ANSW_SCORE_TXT_PAD_X : uint = 3;
		private const ANSWER_ANSW_SCORE_TXT_PAD_Y : uint = 0;
		private const ANSWER_ANSW_LINE_HEIGHT : uint = 1;
		private const BODY_OK_BTN_PAD_X : uint = 5;
		private const BODY_OK_BTN_PAD_Y : uint = 5;
		private const BODY_OK_BTN_POS_X : uint = 22;
		private const BODY_OK_BTN_POS_Y : uint = 0;
		
		private var xmlPath : String;
		private var urlREQ : URLRequest;
		private var dataUrlLoader : URLLoader;
		private var dataXML : XML;
		private var settings : Object;
		private var objLoader : Loader;
		private var cssREQ : URLRequest;
		private var cssStyle : StyleSheet;
		private var textY : Number = 0;
		private var yPos : Number = 0;
		
		private var qLength : Number = 0;
		private var aLength : Number = 0;
		
		private var setY : Number = 0;
		private var setX : Number = 0;
		private var setAx : Number = 0;
		private var setAy : Number = 0;
		private var scrollType : String = "";
		private var compHolderH : Number = 0;
		private var qIndex : uint;
		private var mcPrvTime : Timer;
		private var mcElapsedTime : Timer;
		private var elapsedTime : Number;
		private var elapsedTimeFlag : Boolean = true;
		private var removeHTML : RegExp = /<[^>]*>/gi;
		private var re : RegExp = /\s/gi;
		private var arrayBulletResult : Array = [];
		private var partScore : Number = 0;
		private var bulletAnswer : Number = 0;
		private var radiusAnswer : Number = 0;
		private var radiusPressed : Number = 0;
		private var finalScore : String = "";
		private var mcH : MovieClip;
		private var inputResults : Array;
		private var buttonPressed : Number = 0;
		private var compAnswerHolderH : Number = 0;
		private var textFieldType : String = "";
		private var pQind : Number = -1;
		private var hideAllQFlag : Boolean = false;
		private var xmlTOphp : Boolean = true;
		private var phpURL : URLRequest;
		private var phpVar : URLVariables;
		private var phpLoader : URLLoader;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function Quiz()
		{
			this.alpha = 0;
			this.visible = false;
			
			new Utils();
			ColorShortcuts.init();
			TextShortcuts.init();
			mcScrollbar = new ScrollBar();
			
			if (stage) 
			{
				init();
			}else 
			{
				this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			}
		}
		//} endregion
		
		//{ region INIT
		private final function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			
			xmlPath = stage.loaderInfo.parameters.xmlFile || "Kuis.xml";
			
			mcBody.mcViewDetails.buttonMode = true;
			mcBody.mcViewDetails.mouseChildren = false;
			
			mcStartPage.mcBtn.buttonMode = true;
			mcStartPage.mcBtn.mouseChildren = false;
			
			mcBody.mcBack.buttonMode = true;
			mcBody.mcBack.mouseChildren = false;
			
			mcBody.mcRedoQuiz.buttonMode = true;
			mcBody.mcRedoQuiz.mouseChildren = false;
			
			loadXML(xmlPath);
		}
		//} endregion
		
		//{ region EVENT HANDLERS ///////////////////////////////////////////////////////
		
		//{ region PHP LOADER COMPLETE HANDLER
		private final function phpLoader_CompleteHandler(e:Event):void 
		{
			var xml:XML = new XML(phpLoader.data);
			if (xml.message.text() == "success")
			{
				trace("xml file saved, name: ", xml.fileName.text());
			}else 
			{
				trace("xml file couldn't be saved");
			}
		}
		//} endregion
		
		//{ region PHP LOADER IOERROR HANDLER
		private final function phpLoader_IoErrorHandler(e:IOErrorEvent):void 
		{
			trace("php Error, class Quiz.as",e.toString());
		}
		//} endregion
		
		//{ region BULLET ACTION LISTENER
		private final function bulletAction_listener(pSignal : String, pInd : int, pType : Boolean):void
		{
			if (pType)
			{
				Question(mcH.getChildAt(pInd)).pOkPressed = true;
			}else 
			{
				Question(mcH.getChildAt(pInd)).pOkPressed = false;
			}
		}
		//} endregion
		
		//{ region MC OK ROLL OVER HANDLER
		private final function mcOk_RollOverHandler(e:MouseEvent):void 
		{
			mcBody.mcOk.O.visible = true;
			Tweener.addTween(mcBody.mcOk.O, { alpha:1 , time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcBody.mcOk.mcTxt.txt, { _text_color: BODY_OK_BTN_O_COLOR , time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC OK CLICK HANDLER
		private final function mcOk_ClickHandler(e:MouseEvent):void 
		{
			if (!settings.startExpanded && settings.generalTime)
			{
				for (var i:int = 0; i < qLength; i++)
				{
					Question(mcH.getChildAt(i)).buttonMode = false;
					Question(mcH.getChildAt(i)).clickBtnSignal.remove(mcQuestion_ClickPressedHandler);
					Question(mcH.getChildAt(i)).removeEventListener(MouseEvent.CLICK, Question(mcH.getChildAt(i)).clickHandler);
				}
			}
			
			mcBody.mcOk.removeEventListener(MouseEvent.ROLL_OVER, mcOk_RollOverHandler);
			mcBody.mcOk.removeEventListener(MouseEvent.CLICK, mcOk_ClickHandler);
			mcBody.mcOk.removeEventListener(MouseEvent.ROLL_OUT, mcOk_RollOutHandler);
			mcBody.mcOk.mouseEnabled = false;
			mcOk_RollOutHandler(null);
			
			Tweener.addTween(mcBody.mcOk, { alpha: 1, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcOk.visible = false;
			} } );
			
			calculateResult("EXPANDED GEN TIME");
		}
		//} endregion
		
		//{ region MC OK ROLL OUT HANDLER
		private final function mcOk_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcBody.mcOk.O, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcOk.O.visible = false;
			} } );
			Tweener.addTween(mcBody.mcOk.mcTxt.txt, { _text_color: BODY_OK_BTN_N_COLOR , time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region TEXTFIELD SCROLL HANDLER
		private final function textField_scrollHandler(e:Event = null):void 
		{
			switch (textFieldType) 
			{
				case "START_PAGE":
				mcStartPage.mcTxt.txt.scrollV = 0;
				break;
				
				case "RESULT":
				mcBody.mcResult.mcResultContent.txt.scrollV = 0;
				break;
			}
		}
		//} endregion
		
		//{ region MC QUESTION CLICK PRESSED HANDLER
		private function mcQuestion_ClickPressedHandler(e:Number = -1, pType : String = ""):void
		{
			switch (pType)
			{
				case "BTN PRESSED":
					if (pQind != -1 && pQind != e)
					{
						Tweener.addTween(Question(mcH.getChildAt(pQind)).Sel, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
						{
							Question(mcH.getChildAt(pQind)).Sel.visible = false;
						} } );
					}
					
					if (e != pQind)
					{
						Question(mcH.getChildAt(e)).Sel.visible = true;
						Tweener.addTween(Question(mcH.getChildAt(e)).Sel, { alpha:1 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
						{
							pQind = e;
						} } );
					}
				break;
				
				case "NORMAL":
					if (settings.autoClose)
					{
						if (pQind != -1 && pQind != e && !Question(mcH.getChildAt(pQind)).pWas)
						{
							toggleRotation(pQind, "PRV TIME");
						}
						
						if (e != pQind || pQind == e)
						{
							toggleRotation(e, "PRV TIME");
							pQind = e;
						}
					}else 
					{
						toggleRotation(e, "PRV TIME");
					}
				break;
				
				case "NORMAL GEN TIME":
					if (settings.autoClose)
					{
						if (!hideAllQFlag && pQind != -1 && pQind != e)
						{
							Tweener.addTween(Question(mcH.getChildAt(pQind)).Sel, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
							{
								Question(mcH.getChildAt(pQind)).Sel.visible = false;
							} } );
						}
						
						if (pQind != -1 && pQind != e && !Question(mcH.getChildAt(pQind)).pWas)
						{
							toggleRotation(pQind, "GEN TIME");
						}
						
						if (e != pQind || pQind == e)
						{
							toggleRotation(e, "GEN TIME");
							if (!hideAllQFlag)
							{
								Question(mcH.getChildAt(e)).Sel.visible = true;
								Tweener.addTween(Question(mcH.getChildAt(e)).Sel, { alpha:1 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
								{
									pQind = e;
								}} );
							}else 
							{
								pQind = e;
							}
						}
					}else 
					{
						toggleRotation(e, "GEN TIME");
					}
				break;
				
				case "EXPANDED":
					if (pQind != -1 && pQind != e)
					{
						Tweener.addTween(Question(mcH.getChildAt(pQind)).CurrSel, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
						{
							Question(mcH.getChildAt(pQind)).CurrSel.visible = false;
						} } );
						
						Tweener.addTween(Question(mcH.getChildAt(pQind)).mcDropDown.CurrSel, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
						{
							Question(mcH.getChildAt(pQind)).mcDropDown.CurrSel.visible = false;
						} } );
					}
					
					if (e != pQind)
					{
						Question(mcH.getChildAt(e)).CurrSel.visible = true;
						Tweener.addTween(Question(mcH.getChildAt(e)).CurrSel, { alpha:1 , time: 0.3, transition: "easeoutquad" } );
						
						Question(mcH.getChildAt(e)).mcDropDown.CurrSel.visible = true;
						Tweener.addTween(Question(mcH.getChildAt(e)).mcDropDown.CurrSel, { alpha:1 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
						{
							pQind = e;
						} } );
					}
				break;
			}
		}
		//} endregion
		
		//{ region MC QUESTION OK BTN PRESSED HANDLER
		private final function mcQuestion_OkBtnPressedHandler(e:String = "", correctAnswer : Number = 0, pLast : Boolean = false):void 
		{
			if (!pLast)
			{
				elapsedTime = -1;
				mcElapsedTime_CompleteHandler();
			}else 
			{
				stopTimer();
				mcBody.mcTxt.txt.htmlText = settings.remainingTime + elapsedTimeFun(0);
				hidePrev(qIndex);
				calculateResult("EXPANDED PRV TIME");
			}
			Question(mcH.getChildAt(qIndex-1)).okBtnSignal.remove(mcQuestion_OkBtnPressedHandler);
		}
		//} endregion
		
		//{ region MC ELAPSED TIME COMPLETE HANDLER
		private final function mcElapsedTime_CompleteHandler(e:TimerEvent = null):void 
		{
			
			if (elapsedTime <= -1)
			{
				stopTimer();
				
				if (settings.generalTime)
				{
					mcBody.mcTxt.txt.htmlText = settings.remainingTime + settings.timeElapsed;
					if (settings.startExpanded)
					{
						hideAllQ();
					}else 
					{
						hideAllQn();
					}
					
				}else 
				{
					if (qIndex + 1 < qLength)
					{
						if (qIndex < qLength-1)
						{
							qIndex++;
							
							//if on, it will autoScroll
							if (settings.autoScroll)
							{
								var holderY:Number = Math.min(0, Math.max(mcBody.mcMask.height - compHolderH, -Question(mcH.getChildAt(qIndex)).y));
								Tweener.addTween(mcH, { y: holderY, time: .3, transition: "easeoutquad", onUpdate: function ():void 
								{
									mcScrollbar.perc = Math.max(0, Math.min(1, mcH.y / (mcBody.mcMask.height - compHolderH)));
									mcScrollbar.mcBtn.y = yPos = Math.round(mcScrollbar.perc * (mcScrollbar.mcTrack.height - mcScrollbar.mcBtn.height));
								}, onComplete: function ():void 
								{
									if (settings.autoOpen && !settings.startExpanded && Question(mcH.getChildAt(qIndex)).pWas)
									{
										mcQuestion_ClickPressedHandler(qIndex, "NORMAL");
									}
								} } );
							}else 
							{
								if (settings.autoOpen && !settings.startExpanded && Question(mcH.getChildAt(qIndex)).pWas)
								{
									mcQuestion_ClickPressedHandler(qIndex, "NORMAL");
								}
							}
							
							goNext();
						}
					}else 
					{
						mcQuestion_OkBtnPressedHandler("", 0, true);
					}
				}
			}
			
			if (elapsedTime >= 0)
			{
				mcBody.mcTxt.txt.htmlText = settings.remainingTime + elapsedTimeFun(elapsedTime);
			}
			elapsedTime--;
		}
		//} endregion
		
		//{ region MOUSE WHEEL HANDLER
		private final function mouseWheelHandler(e:MouseEvent = null):void 
		{
			if ((e.delta < 0 && Math.round(mcScrollbar.mcBtn.y) < Math.round(mcScrollbar.mcTrack.height - mcScrollbar.mcBtn.height)) || 
			(e.delta > 0 && mcScrollbar.mcBtn.y > mcScrollbar.mcTrack.y))
			{
				yPos += (-(e.delta) * settings.scrollbarMultiplier);
				mcScrollbar.updateMcBtn(yPos);
			}
		}
		//} endregion
		
		//{ region MC SCROLLBAR DRAG HANDLER
		private final function mcScrollbar_DragHandler(e:String = "", pYpos : Number = 0, pAutoScroll : Boolean = false):void
		{
			switch (scrollType)
			{
				case "START_PAGE":
					yPos = pYpos;
					textY = Math.round(mcScrollbar.perc * (mcStartPage.mcMask.height - mcStartPage.mcTxt.height));
					Tweener.addTween(mcStartPage.mcTxt, { y:textY, time:.3, transition:"easeOutQuad" } );
				break;
				
				case "Q_EXPANDED":
					yPos = pYpos;
					textY = Math.round(mcScrollbar.perc * (mcBody.mcMask.height - compHolderH));
					Tweener.addTween(mcH, { y:textY, time:.3, transition:"easeOutQuad" } );
				break;
				
				case "Q_NORMAL":
					yPos = pYpos;
					textY = Math.round(mcScrollbar.perc * (mcBody.mcMask.height - compHolderH));
					Tweener.addTween(mcH, { y:textY, time:.3, transition:"easeOutQuad" } );
				break;
				
				case "RESULT":
					yPos = pYpos;
					textY = Math.round(mcScrollbar.perc * (mcBody.mcResult.mcMask.height - mcBody.mcResult.mcResultContent.height));
					Tweener.addTween(mcBody.mcResult.mcResultContent, { y:textY, time:.3, transition:"easeOutQuad" } );
				break;
				
				case "ANSWER":
					yPos = pYpos;
					textY = Math.round(mcScrollbar.perc * (mcBody.mcMask.height - compAnswerHolderH));
					Tweener.addTween(mcH, { y:textY, time:.3, transition:"easeOutQuad" } );
				break;
			}
		}
		//} endregion
		
		//{ region MC RESULT ROLL OVER HANDLER
		private final function mcResult_RollOverHandler(e:MouseEvent):void 
		{
			mcBody.mcRedoQuiz.O.visible = true;
			Tweener.addTween(mcBody.mcRedoQuiz.O, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcBody.mcRedoQuiz.mcTxt.txt, { _text_color: RESULT_BTN_O, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC RESULT CLICK HANDLER
		private final function mcResult_ClickHandler(e:MouseEvent):void 
		{
			hideAllQFlag = false;
			mcBody.mcRedoQuiz.mouseEnabled = false;
			setY = 0;
			arrayBulletResult = [];
			partScore = 0;
			bulletAnswer = 0;
			setX = 0;
			setY = 0;
			setAx = 0;
			setAy = 0;
			compHolderH = 0;
			compAnswerHolderH = 0;
			
			if (!xmlTOphp) 
			{
				xmlTOphp = true;
			}
			
			mcBody.mcTxt.y += BODY_TIME_X_OFFSET;
			
			mcBody.mcBack.removeEventListener(MouseEvent.ROLL_OVER, mcBack_RollOverHandler);
			mcBody.mcBack.removeEventListener(MouseEvent.CLICK, mcBack_ClickHandler);
			mcBody.mcBack.removeEventListener(MouseEvent.ROLL_OUT, mcBack_RollOutHandler);
			
			mcBody.mcViewDetails.removeEventListener(MouseEvent.ROLL_OVER, mcViewDetails_RollOverHandler);
			mcBody.mcViewDetails.removeEventListener(MouseEvent.CLICK, mcViewDetails_ClickHandler);
			mcBody.mcViewDetails.removeEventListener(MouseEvent.ROLL_OUT, mcViewDetails_RollOutHandler);
			
			mcBody.mcTxt.txt.htmlText = "";
			mcBody.mcResult.mcResultContent.txt.htmlText = "";
			
			testScrollBar();
			
			if (settings.viewDetails)
			{
				Tweener.addTween(mcBody.mcViewDetails, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcBody.mcViewDetails.visible = false;
				} } );
			}
			
			Tweener.addTween(mcBody.mcRedoQuiz, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcRedoQuiz.visible = false;
			} } );
			
			Tweener.addTween(mcBody.mcResult, { alpha:0, delay:0.3, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcResult.visible = false;
				introPage();
			} } );
		}
		//} endregion
		
		//{ region MC RESULT ROLL OUT HANDLER
		private final function mcResult_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcBody.mcRedoQuiz.O, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcRedoQuiz.O.visible = false;
			} } );
			Tweener.addTween(mcBody.mcRedoQuiz.mcTxt.txt, { _text_color: RESULT_BTN_N, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC BACK ROLL OVER HANDLER
		private final function mcBack_RollOverHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcBody.mcBack.mcArrow, { _color: BODY_BACK_ARROW_O, time: 0, transition: "easeoutquad" } );
			mcBody.mcBack.mcTxt.txt.htmlText = "<u>" + settings.backBtn + "</u>";
			Tweener.addTween(mcBody.mcBack.mcTxt.txt, { _text_color: BODY_BACK_TXT_O, time: 0, transition: "easeoutquad" } );
		}
		//} endregion
		
		//{ region MC BACK CLICK HANDLER
		private final function mcBack_ClickHandler(e:MouseEvent):void 
		{
			mcBody.mcBack.mouseEnabled = false;
			testScrollBar();
			Tweener.addTween(mcBody.mcHolder, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcHolder.visible = false;
				setAx = 0;
				setAy = 0;
				mcBody.mcResult.mcResultContent.y = 0;
				compAnswerHolderH = 0;
				genHolder("DEL");
			} } );
			
			Tweener.addTween(mcBody.mcBack, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcBack.visible = false;
			} });
			
			Tweener.addTween(mcBody.mcCrt, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcCrt.visible = false;
				mcBody.mcCrt.mcTxt.txt.htmlText = "";
				
			} } );
			
			Tweener.addTween(mcBody.mcTxt, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcViewDetails.visible = true;
				Tweener.addTween(mcBody.mcViewDetails, { alpha:1, delay: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcBody.mcViewDetails.mouseEnabled = true;
				} } );
				
				mcBody.mcRedoQuiz.visible = true;
				Tweener.addTween(mcBody.mcRedoQuiz, { alpha:1, delay: 0, time: 0.3, transition: "easeoutquad" } );
				
				mcBody.mcResult.visible = true;
				Tweener.addTween(mcBody.mcResult, { alpha:1, delay: 0, time: 0.3, transition: "easeoutquad" } );
				
				Tweener.addTween(mcBody.mcTxt, { alpha: 0, delay: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Tweener.addTween(mcBody.mcTxt, { alpha:1, time: 0.3, transition: "easeoutquad" } );
					testScrollBar("RESULT");
				} } );
				
			} });
		}
		//} endregion
		
		//{ region MC BACK ROLL OUT HANDLER
		private final function mcBack_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcBody.mcBack.mcTxt.txt, { _text_color: BODY_BACK_TXT_N, time: 0, transition: "easeoutquad" } );
			mcBody.mcBack.mcTxt.txt.htmlText = settings.backBtn;
			Tweener.addTween(mcBody.mcBack.mcArrow, { _color: BODY_BACK_ARROW_N, time: 0, transition: "easeoutquad" } );
		}
		//} endregion
		
		//{ region MC START PAGE ROLL OVER HANDLER
		private final function mcStartPage_RollOverHandler(e:MouseEvent):void 
		{
			mcStartPage.mcBtn.O.visible = true;
			Tweener.addTween(mcStartPage.mcBtn.O, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			Tweener.addTween(mcStartPage.mcBtn.mcTxt.txt, { _text_color: START_PAGE_BTN_O, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC START PAGE CLICK HANDLER
		private final function mcStartPage_ClickHandler(e:MouseEvent  = null):void 
		{
			mcStartPage.mcBtn.mouseEnabled = false;
			showFirstPage(false);
			
			mcBody.setChildIndex(mcBody.mcHolder, numChildren);
			
			genHolder("GEN");
			
			if (!settings.timer && !settings.generalTime) 
			{
				settings.generalTime = true;
			}
			
			mcBody.mcHolder.visible = true;
			Tweener.addTween(mcBody.mcHolder, { alpha:1, time: 0.3, transition: "easeoutquad" });
			
			if (settings.startExpanded)
			{
				for (var i:int = 0; i <= qLength-1; i++)
				{
					var mcQuestion : Question = new Question();
					generateQuestion(true, mcQuestion, i);
				}
			}else 
			{
				for (var l:int = 0; l <= qLength-1; l++)
				{
					var mcQuestN : Question = new Question();
					generateQuestion(false, mcQuestN, l);
				}
			}
		}
		//} endregion
		
		//{ region MC START PAGE ROLL OUT HANDLER
		private final function mcStartPage_RollOUtHandler(e:MouseEvent = null):void 
		{
			Tweener.addTween(mcStartPage.mcBtn.O, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcStartPage.mcBtn.O.visible = false;
			} } );
			Tweener.addTween(mcStartPage.mcBtn.mcTxt.txt, { _text_color: START_PAGE_BTN_N, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC VIEW DETAILS ROLL OVER HANDLER
		private final function mcViewDetails_RollOverHandler(e:MouseEvent):void 
		{
			mcBody.mcViewDetails.O.visible = true;
			Tweener.addTween(mcBody.mcViewDetails.O, { alpha: 1, time: 0.3, transition: "easeoutquad" });
			Tweener.addTween(mcBody.mcViewDetails.mcTxt.txt, { _text_color: VIEW_DETAILS_O_COLOR , time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region MC VIEW DETAILS CLICK HANDLER
		private final function mcViewDetails_ClickHandler(e:MouseEvent):void 
		{
			mcBody.mcViewDetails.mouseEnabled = false;
			if (!mcBody.mcBack.hasEventListener(MouseEvent.ROLL_OVER))
			{
				mcBody.mcBack.addEventListener(MouseEvent.ROLL_OVER, mcBack_RollOverHandler, false, 0, true);
				mcBody.mcBack.addEventListener(MouseEvent.CLICK, mcBack_ClickHandler, false, 0, true);
				mcBody.mcBack.addEventListener(MouseEvent.ROLL_OUT, mcBack_RollOutHandler, false, 0, true);
			}
			
			testScrollBar();
			
			Tweener.addTween(mcBody.mcViewDetails, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcViewDetails.visible = false;
			} } );
			
			Tweener.addTween(mcBody.mcRedoQuiz, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcRedoQuiz.visible = false;
			} } );
			
			Tweener.addTween(mcBody.mcResult, { alpha:0, delay: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcResult.visible = false;
			} } );
			
			Tweener.addTween(mcBody.mcTxt, { alpha: 0, delay: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcCrt.mcTxt.txt.htmlText = "<b>" + qLength + "</b>";
				mcBody.mcCrt.Bg.width = Math.round(2 * BODY_CRT_TXT_PAD_LEFT + mcBody.mcCrt.mcTxt.txt.textWidth);
				mcBody.mcCrt.Bg.height = Math.round(mcBody.mcCrt.mcTxt.txt.textHeight + BODY_CRT_TXT_PAD_TOP + BODY_CRT_TXT_PAD_BOTTOM);
				mcBody.mcCrt.mcTxt.x = Math.floor(mcBody.mcCrt.Bg.width / 2 - mcBody.mcCrt.mcTxt.width / 2);
				mcBody.mcCrt.x = Math.round(mcBody.Bg.width - (mcBody.mcCrt.Bg.width + BODY_CRT_POS_X));
				mcBody.mcCrt.y = BODY_CRT_POS_Y;
				
				mcBody.mcBack.mcArrow.x = BODY_BACK_ARROW_POS_X;
				mcBody.mcBack.mcTxt.x = mcBody.mcBack.mcArrow.x + mcBody.mcBack.mcArrow.width;
				mcBody.mcBack.mcTxt.y = BODY_BACK_TXT_POS_Y;
				mcBody.mcBack.mcArrow.y = Math.floor(mcBody.mcBack.mcTxt.height / 2 - mcBody.mcBack.mcArrow.height / 2);
				
				mcBody.mcBack.x = Math.round(mcBody.mcCrt.x - (mcBody.mcBack.width + 4));
				mcBody.mcBack.y = BODY_BACK_POS_Y;
				
				Tweener.addTween(mcBody.mcTxt, { alpha:1, time: 0.3, transition: "easeoutquad" } );
				
				mcBody.mcBack.visible = true;
				Tweener.addTween(mcBody.mcBack, { alpha:1, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcBody.mcBack.mouseEnabled = true;
				} } );
				
				mcBody.mcCrt.visible = true;
				Tweener.addTween(mcBody.mcCrt, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			} } );
			
			genHolder("GEN");
			
			mcBody.mcHolder.visible = true;
			
			Tweener.addTween(mcBody.mcHolder, { alpha:1 , delay: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				generateAnswers();
				
			} } );
		}
		//} endregion
		
		//{ region MC VIEW DETAILS ROLL OUT HANDLER
		private final function mcViewDetails_RollOutHandler(e:MouseEvent):void 
		{
			Tweener.addTween(mcBody.mcViewDetails.O, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcViewDetails.O.visible = false;
			} });
			Tweener.addTween(mcBody.mcViewDetails.mcTxt.txt, { _text_color: VIEW_DETAILS_N_COLOR , time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region DATA URL LOADER INPUT OUTPUT ERROR HANDLER
		private final function dataUrlLoader_IoErrorHandler(e:IOErrorEvent):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, dataUrlLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dataUrlLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, dataUrlLoader_CompleteHandler);
			
			trace("XML loader input output error, class Quiz.as", e.toString());
		}
		//} endregion
		
		//{ region DATA URL LOADER SECURITY ERROR HANDLER
		private final function dataUrlLoader_SecurityErrorHandler(e:SecurityErrorEvent):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, dataUrlLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dataUrlLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, dataUrlLoader_CompleteHandler);
			
			trace("XML loader security error, class Quiz.as", e.toString());
		}
		//} endregion
		
		//{ region DATA URL LOADER COMPLETE HANDLER
		private final function dataUrlLoader_CompleteHandler(e:Event):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, dataUrlLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, dataUrlLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, dataUrlLoader_CompleteHandler);
			
			xmlPath = "";
			urlREQ = null;
			
			dataXML = new XML(dataUrlLoader.data);
			settings = XMLUtil.getParams(dataXML.settings);
			
			try 
			{
				dataUrlLoader.close();
				dataUrlLoader = null;
			}catch (err:Error)
			{
				trace("Data url loader complete handler, class Quiz.as", err);
			}
			
			loadCSS();
			reset();
		}
		//} endregion
		
		//{ region OBJ LOADER INPUT OUTPUT ERROR HANDLER
		private final function objLoader_IoErrorHandler(e:IOErrorEvent):void 
		{
			objLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, objLoader_IoErrorHandler);
			objLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, objLoader_ProgressHandler);
			objLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, objLoader_CompleteHandler);
			
			trace("Object loader IOError, class Quiz.as",e.toString());
		}
		//} endregion
		
		//{ region OBJ LOADER PROGRESS HANDLER
		private final function objLoader_ProgressHandler(e:ProgressEvent):void 
		{
			mcLogo.mcPreloader.visible = true;
			Tweener.addTween(mcLogo.mcPreloader, { alpha: 1 , time: 0.3, transition: "easeoutquad" } );
		}
		//} endregion
		
		//{ region OBJ LOADER COMPLETE HANDLER
		private final function objLoader_CompleteHandler(e:Event):void 
		{
			objLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, objLoader_IoErrorHandler);
			objLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, objLoader_ProgressHandler);
			objLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, objLoader_CompleteHandler);
			
			urlREQ = null;
			
			mcLogo.mcHolder.addChild(objLoader.content);
			
			Tweener.addTween(mcLogo.mcPreloader, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
			{
				mcLogo.mcPreloader.visible = false;
				mcLogo.removeChild(mcLogo.mcPreloader);
			} } );
			
			mcLogo.mcHolder.fitToSize(settings.logoW, settings.logoH, false);
			mcLogo.mcHolder.visible = true;
			Tweener.addTween(mcLogo.mcHolder, { alpha: 1, time: 0.3, transition: "easeoutquad" });
			
			try 
			{
				objLoader.unload();
				objLoader = null;
			}catch (err:Error)
			{
				//trace("Obj Loader complete handler, class Quiz.as", err);
			}
		}
		//} endregion
		
		//{ region CSS LOADER IOERROR HANDLER
		private final function cssLoader_IoErrorHandler(e:IOErrorEvent):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, cssLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, cssLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, cssLoader_CompleteHandler);
			
			trace("CSS loader IOError, class Quiz.as", e.toString());
		}
		//} endregion
		
		//{ region CSS LOADER SECURITY ERROR HANDLER
		private final function cssLoader_SecurityErrorHandler(e:SecurityErrorEvent):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, cssLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, cssLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, cssLoader_CompleteHandler);
			
			trace("CSS loader SecurityError, class Quiz.as", e.toString());
		}
		//} endregion
		
		//{ region CSS LOADER COMPLETE HANDLER
		private final function cssLoader_CompleteHandler(e:Event):void 
		{
			dataUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, cssLoader_IoErrorHandler);
			dataUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, cssLoader_SecurityErrorHandler);
			dataUrlLoader.removeEventListener(Event.COMPLETE, cssLoader_CompleteHandler);
			
			cssREQ = null;
			
			cssStyle = new StyleSheet();
			cssStyle.parseCSS(dataUrlLoader.data);
			
			try 
			{
				dataUrlLoader.close();
				dataUrlLoader = null;
			}catch (err:Error)
			{
				trace("CSS loader coomplete handler, class Quiz.as", err);
			}
			
			loadImg();
			startApp();
		}
		//} endregion
		
		//} endregion
		
		//{ region MERHODS //////////////////////////////////////////////////////////////
		
		//{ region LOAD XML
		public final function loadXML(pXML : String):void
		{
			try 
			{
				urlREQ = new URLRequest(pXML);
				dataUrlLoader = new URLLoader();
				dataUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, dataUrlLoader_IoErrorHandler, false, 0, true);
				dataUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dataUrlLoader_SecurityErrorHandler, false, 0, true);
				dataUrlLoader.addEventListener(Event.COMPLETE, dataUrlLoader_CompleteHandler, false, 0, true);
				dataUrlLoader.load(urlREQ);
			}catch (err:Error)
			{
				trace("Load XML Error, class Quiz.as", err);
			}
		}
		//} endregion
		
		//{ region RESET
		private final function reset():void
		{
			this.mask = mcMask;
			Bg.alpha = 0;
			
			mcBody.addChild(mcScrollbar);
			
			mcBody.mcHolder.mask = mcBody.mcMask;
			mcStartPage.mcTxt.mask = mcStartPage.mcMask;
			mcBody.mcResult.mcResultContent.mask = mcBody.mcResult.mcMask;
			
			//formatting the startPage btn
			mcStartPage.mcBtn.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcStartPage.mcBtn.mcTxt.txt.selectable = false;
			mcStartPage.mcBtn.mcTxt.txt.condenseWhite = true;
			mcStartPage.mcBtn.mcTxt.txt.multiline = false;
			mcStartPage.mcBtn.mcTxt.txt.embedFonts = true;
			mcStartPage.mcBtn.mcTxt.txt.wordWrap = false;
			mcStartPage.mcBtn.mcTxt.txt.text = "";
			//for testing only
			//mcStartPage.mcBtn.mcTxt.txt.background = true;
			//mcStartPage.mcBtn.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the startPage content
			mcStartPage.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcStartPage.mcTxt.txt.selectable = true;
			mcStartPage.mcTxt.txt.condenseWhite = true;
			mcStartPage.mcTxt.txt.multiline = true;
			mcStartPage.mcTxt.txt.embedFonts = true;
			mcStartPage.mcTxt.txt.wordWrap = true;
			mcStartPage.mcTxt.txt.text = "";
			mcStartPage.mcTxt.txt.mouseWheelEnabled = false;
			//for testing only
			//mcStartPage.mcTxt.txt.background = true;
			//mcStartPage.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the object Preloader
			mcLogo.mcPreloader.alpha = 0;
			mcLogo.mcPreloader.visible = false;
			mcLogo.mcPreloader.x = Math.round(settings.logoW / 2);
			mcLogo.mcPreloader.y = Math.round(settings.logoH / 2);
			Tweener.addTween(mcLogo.mcPreloader, { _color:settings.loaderColor , time: 0 } );
			
			//formatting the object Holder
			mcLogo.mcHolder.visible = false;
			mcLogo.mcHolder.alpha = 0;
			mcLogo.mcHolder.x = mcLogo.mcHolder.y = 0;
			
			//formatting the title textfield
			mcHead.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcHead.mcTxt.txt.selectable = false;
			mcHead.mcTxt.txt.condenseWhite = true;
			mcHead.mcTxt.txt.multiline = false;
			mcHead.mcTxt.txt.embedFonts = true;
			mcHead.mcTxt.txt.wordWrap = false;
			mcHead.mcTxt.txt.text = "";
			//for testing only
			//mcHead.mcTxt.txt.background = true;
			//mcHead.mcTxt.txt.backgroundColor = 0x006633;
			
			Tweener.addTween(mcBody.mcBack.mcArrow, { _color: BODY_BACK_ARROW_N, time: 0 });
			
			//formatting the mcBack textfield title
			mcBody.mcBack.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcBack.mcTxt.txt.selectable = false;
			mcBody.mcBack.mcTxt.txt.condenseWhite = true;
			mcBody.mcBack.mcTxt.txt.multiline = false;
			mcBody.mcBack.mcTxt.txt.embedFonts = true;
			mcBody.mcBack.mcTxt.txt.wordWrap = false;
			mcBody.mcBack.mcTxt.txt.textColor = BODY_BACK_TXT_N;
			mcBody.mcBack.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcBack.mcTxt.txt.background = true;
			//mcBody.mcBack.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the result content
			mcBody.mcResult.mcResultContent.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcResult.mcResultContent.txt.selectable = true;
			mcBody.mcResult.mcResultContent.txt.condenseWhite = true;
			mcBody.mcResult.mcResultContent.txt.multiline = true;
			mcBody.mcResult.mcResultContent.txt.embedFonts = true;
			mcBody.mcResult.mcResultContent.txt.wordWrap = true;
			mcBody.mcResult.mcResultContent.txt.mouseWheelEnabled = false;
			mcBody.mcResult.mcResultContent.txt.text = "";
			//for testing only
			//mcBody.mcResult.mcResultContent.txt.background = true;
			//mcBody.mcResult.mcResultContent.txt.backgroundColor = 0x006633;
			
			//formatting the result btn textfield
			mcBody.mcRedoQuiz.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcRedoQuiz.mcTxt.txt.selectable = false;
			mcBody.mcRedoQuiz.mcTxt.txt.condenseWhite = true;
			mcBody.mcRedoQuiz.mcTxt.txt.multiline = true;
			mcBody.mcRedoQuiz.mcTxt.txt.embedFonts = true;
			mcBody.mcRedoQuiz.mcTxt.txt.wordWrap = false;
			mcBody.mcRedoQuiz.mcTxt.txt.textColor = RESULT_BTN_N;
			mcBody.mcRedoQuiz.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcRedoQuiz.mcTxt.txt.background = true;
			//mcBody.mcRedoQuiz.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the view details textfield
			mcBody.mcViewDetails.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcViewDetails.mcTxt.txt.selectable = false;
			mcBody.mcViewDetails.mcTxt.txt.condenseWhite = true;
			mcBody.mcViewDetails.mcTxt.txt.multiline = false;
			mcBody.mcViewDetails.mcTxt.txt.embedFonts = true;
			mcBody.mcViewDetails.mcTxt.txt.wordWrap = false;
			mcBody.mcViewDetails.mcTxt.txt.textColor = VIEW_DETAILS_N_COLOR;
			mcBody.mcViewDetails.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcViewDetails.mcTxt.txt.background = true;
			//mcBody.mcViewDetails.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the ok textfield
			mcBody.mcOk.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcOk.mcTxt.txt.selectable = false;
			mcBody.mcOk.mcTxt.txt.condenseWhite = true;
			mcBody.mcOk.mcTxt.txt.multiline = false;
			mcBody.mcOk.mcTxt.txt.embedFonts = true;
			mcBody.mcOk.mcTxt.txt.wordWrap = false;
			mcBody.mcOk.mcTxt.txt.textColor = BODY_OK_BTN_N_COLOR;
			mcBody.mcOk.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcOk.mcTxt.txt.background = true;
			//mcBody.mcOk.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the current number textfield
			mcBody.mcCrt.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcCrt.mcTxt.txt.selectable = false;
			mcBody.mcCrt.mcTxt.txt.condenseWhite = true;
			mcBody.mcCrt.mcTxt.txt.multiline = false;
			mcBody.mcCrt.mcTxt.txt.embedFonts = true;
			mcBody.mcCrt.mcTxt.txt.wordWrap = false;
			mcBody.mcCrt.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcCrt.mcTxt.txt.background = true;
			//mcBody.mcCrt.mcTxt.txt.backgroundColor = 0x006633;
			
			//formatting the time textfield
			mcBody.mcTxt.txt.autoSize = TextFieldAutoSize.LEFT;
			mcBody.mcTxt.txt.selectable = true;
			mcBody.mcTxt.txt.condenseWhite = true;
			mcBody.mcTxt.txt.multiline = false;
			mcBody.mcTxt.txt.embedFonts = true;
			mcBody.mcTxt.txt.wordWrap = false;
			mcBody.mcTxt.txt.mouseWheelEnabled = false;
			mcBody.mcTxt.txt.text = "";
			//for testing only
			//mcBody.mcTxt.txt.background = true;
			//mcBody.mcTxt.txt.backgroundColor = 0x006633;
			
			//hidding elements
			mcStartPage.visible = false;
			mcStartPage.alpha = 0;
			
			mcStartPage.mcBtn.O.visible = false;
			mcStartPage.mcBtn.O.alpha = 0;
			
			mcBody.mcHolder.visible = false;
			mcBody.mcHolder.alpha = 0;
			
			mcBody.mcViewDetails.visible = false;
			mcBody.mcViewDetails.alpha = 0;
			mcBody.mcViewDetails.O.visible = false;
			mcBody.mcViewDetails.O.alpha = 0;
			
			mcBody.mcOk.visible = false;
			mcBody.mcOk.alpha = 0;
			mcBody.mcOk.O.visible = false;
			mcBody.mcOk.O.alpha = 0;
			
			mcBody.mcTxt.visible = false;
			mcBody.mcTxt.alpha = 0;
			
			mcBody.mcCrt.visible = false;
			mcBody.mcCrt.alpha = 0;
			
			mcBody.mcBack.visible = false;
			mcBody.mcBack.alpha = 0;
			
			mcBody.mcResult.visible = false;
			mcBody.mcResult.alpha = 0;
			mcBody.mcRedoQuiz.visible = false;
			mcBody.mcRedoQuiz.alpha = 0;
			mcBody.mcRedoQuiz.O.visible = false;
			mcBody.mcRedoQuiz.O.alpha = 0;
		}
		//} endregion
		
		//{ region LOAD IMG
		private final function loadImg():void
		{
			try 
			{
				urlREQ = new URLRequest(settings.imgPath);
				objLoader = new Loader();
				objLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, objLoader_IoErrorHandler, false, 0, true);
				objLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, objLoader_ProgressHandler, false, 0, true);
				objLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, objLoader_CompleteHandler, false, 0, true);
				objLoader.load(urlREQ);
				
			}catch (err:Error)
			{
				trace("Object Loading, class Quiz.as", err);
			}
		}
		//} endregion
		
		//{ region LOAD CSS
		private final function loadCSS():void
		{
			try 
			{
				cssREQ = new URLRequest(settings.cssPath);
				dataUrlLoader = new URLLoader();
				dataUrlLoader.addEventListener(IOErrorEvent.IO_ERROR, cssLoader_IoErrorHandler, false, 0, true);
				dataUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, cssLoader_SecurityErrorHandler, false, 0, true);
				dataUrlLoader.addEventListener(Event.COMPLETE, cssLoader_CompleteHandler, false, 0, true);
				dataUrlLoader.load(cssREQ);
			}catch (err:Error)
			{
				trace("CSS loader error, class Quiz.as",err);
			}
		}
		//} endregion
		
		//{ region START APP
		private final function startApp():void
		{
			mcBody.mcTxt.txt.styleSheet = cssStyle;
			mcBody.mcCrt.mcTxt.txt.styleSheet = cssStyle;
			mcBody.mcResult.mcResultContent.txt.styleSheet = cssStyle;
			mcHead.mcTxt.txt.styleSheet = cssStyle;
			mcStartPage.mcTxt.txt.styleSheet = cssStyle;
			
			qLength = dataXML.questions.question.length();
			
			mcHead.mcTxt.txt.htmlText = settings.title;
			mcStartPage.mcBtn.mcTxt.txt.htmlText = settings.startQuiz;
			mcStartPage.mcTxt.txt.htmlText = settings.startContent;
			
			mcBody.mcBack.mcTxt.txt.htmlText = settings.backBtn;
			resize();
		}
		//} endregion
		
		//{ region RESIZE
		private final function resize():void
		{
			mcMask.x = mcMask.y = 0;
			//setting the mcMask, Bg, mcHead and mcBody width
			mcMask.width = Bg.width = mcHead.Bg.width = mcBody.Bg.width = settings.width;
			
			mcMask.height = Bg.height = settings.height;
			
			mcLogo.x = LOGO_X;
			mcLogo.y = LOGO_Y;
			
			mcHead.x = HEAD_X;
			mcHead.y = HEAD_Y;
			
			mcHead.mcTxt.x = LOGO_X + settings.logoW + HEAD_TITLE_X;
			mcHead.mcTxt.y = HEAD_TITLE_Y;
			
			mcBody.Bg.height = settings.height - mcHead.Bg.height;
			
			mcBody.x = BODY_X;
			mcBody.y = HEAD_Y + mcHead.Bg.height + BODY_Y;
			
			mcStartPage.x = STARTPAGE_X;
			mcStartPage.y = mcBody.y + STARTPAGE_Y;
			
			mcStartPage.mcTxt.x = mcStartPage.mcMask.x = STARTPAGE_TXT_X;
			mcStartPage.mcTxt.y = mcStartPage.mcMask.y = STARTPAGE_TXT_Y;
			
			mcStartPage.mcMask.width = mcStartPage.mcTxt.txt.width = Math.round(mcBody.Bg.width - 2 * STARTPAGE_X);
			
			mcStartPage.mcBtn.O.width = mcStartPage.mcBtn.N.width = Math.round(mcStartPage.mcBtn.mcTxt.width + 2 * STARTPAGE_BTN_LEFT_PAD);
			mcStartPage.mcBtn.O.height = mcStartPage.mcBtn.N.height = Math.round(mcStartPage.mcBtn.mcTxt.height + 2 * STARTPAGE_BTN_TOP_PAD);
			
			mcStartPage.mcBtn.mcTxt.x = Math.round(mcStartPage.mcBtn.N.width / 2 - (mcStartPage.mcBtn.mcTxt.width / 2 - STARTPAGE_TXT_PAD_W));
			mcStartPage.mcBtn.mcTxt.y = Math.round(mcStartPage.mcBtn.N.height / 2 - (mcStartPage.mcBtn.mcTxt.height / 2 - STARTPAGE_TXT_PAD_H));
			
			mcStartPage.mcMask.height = Math.round(mcBody.Bg.height - (STARTPAGE_Y + STARTPAGE_TXT_PAD + mcStartPage.mcBtn.N.height));
			
			mcStartPage.mcBtn.x = Math.round(mcBody.Bg.width / 2 - (mcStartPage.mcBtn.N.width / 2 + STARTPAGE_X));
			mcStartPage.mcBtn.y = Math.round(mcBody.Bg.height - (mcStartPage.mcBtn.N.height + STARTPAGE_Y));
			
			mcBody.mcHolder.x = mcBody.mcMask.x = HOLDER_POS_X;
			mcBody.mcHolder.y = mcBody.mcMask.y = mcBody.mcCrt.Bg.height + BODY_MASK_HOLDER_PAD;
			
			mcBody.mcMask.width = Math.round(mcBody.Bg.width - 2 * HOLDER_POS_X);
			mcBody.mcMask.height = Math.round(mcBody.Bg.height - (mcBody.mcMask.y + HOLDER_PAD_TOP));
			
			mcBody.mcTxt.x = BODY_TIME_X;
			mcBody.mcTxt.y = BODY_TIME_Y;
			
			mcBody.mcCrt.mcTxt.x = Math.floor(mcBody.mcCrt.Bg.width / 2 - mcBody.mcCrt.mcTxt.width / 2);
			mcBody.mcCrt.mcTxt.y = BODY_CRT_TXT_PAD_TOP;
			
			this.visible = true;
			Tweener.addTween(this, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
			
			//show the first page | do not show the first page
			introPage();
			
		}
		//} endregion
		
		//{ region TEST SCROLLBAR
		private final function testScrollBar(pType : String = "", updScroll : Boolean = false):void
		{
			switch (pType)
			{
				case "START_PAGE":
					if (mcStartPage.mcTxt.height > mcStartPage.mcMask.height)
					{
						mcScrollbar.updateBtn = false;
						scrollType = "START_PAGE";
						mcStartPage.mcTxt.y = textY = 0;
						yPos = 0;
						
						mcScrollbar.scrollbarMinSize = settings.scrollbarMinH;
						
						mcScrollbar.x = Math.round(mcBody.Bg.width - (mcScrollbar.mcTrack.width + SCROLLBAR_LEFT_PAD_STARTPAGE)); 
						mcScrollbar.y = STARTPAGE_Y;
						
						mcScrollbar.mcTrack.height = mcStartPage.mcMask.height;
						
						mcScrollbar.prop = mcStartPage.mcMask.height / mcStartPage.mcTxt.height;
						
						mcScrollbar.visible = true;
						Tweener.addTween(mcScrollbar, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
						
						mcScrollbar.scrollBarSignal.add(mcScrollbar_DragHandler);
						this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
					}
				break;
				
				case "Q_EXPANDED":
					if (compHolderH > mcBody.mcMask.height)
					{
						mcScrollbar.updateBtn = false;
						scrollType = "Q_EXPANDED";
						mcH.y = textY = 0;
						yPos = 0;
						
						mcScrollbar.scrollbarMinSize = settings.scrollbarMinH;
						
						mcScrollbar.x = Math.round(mcBody.Bg.width - (mcScrollbar.mcTrack.width + SCROLLBAR_LEFT_PAD_HOLDERPAD));
						mcScrollbar.y = mcBody.mcMask.y;
						
						mcScrollbar.mcTrack.height = mcBody.mcMask.height;
						
						mcScrollbar.prop = mcBody.mcMask.height / compHolderH;
						
						mcScrollbar.visible = true;
						Tweener.addTween(mcScrollbar, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
						
						mcScrollbar.scrollBarSignal.add(mcScrollbar_DragHandler);
						this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
					}
				break;
				
				case "Q_NORMAL":
					if (compHolderH > mcBody.mcMask.height)
					{
						mcScrollbar.updateBtn = false;
						scrollType = "Q_NORMAL";
						mcH.y = textY = 0;
						yPos = 0;
						
						mcScrollbar.scrollbarMinSize = settings.scrollbarMinH;
						
						mcScrollbar.x = Math.round(mcBody.Bg.width - (mcScrollbar.mcTrack.width + SCROLLBAR_LEFT_PAD_HOLDERPAD));
						mcScrollbar.y = mcBody.mcMask.y;
						
						mcScrollbar.mcTrack.height = mcBody.mcMask.height;
						
						mcScrollbar.prop = mcBody.mcMask.height / compHolderH;
						
						mcScrollbar.visible = true;
						Tweener.addTween(mcScrollbar, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
						
						mcScrollbar.scrollBarSignal.add(mcScrollbar_DragHandler);
						this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
					}
				break;
				
				case "UPDATE_SIZE":
					if (Question(mcH.getChildAt(qLength - 1)).mcDropDown.visible && !updScroll)
					{
						compHolderH = Question(mcH.getChildAt(qLength - 1)).y + Question(mcH.getChildAt(qLength - 1)).O.height +
						(Question(mcH.getChildAt(qLength - 1)).mcDropDown.Bg.height - QUESTION_DROP_DOWN_PAD_TOP) + QUESTION_POS_Y;
					}else 
					{
						compHolderH = Question(mcH.getChildAt(qLength - 1)).y + Question(mcH.getChildAt(qLength - 1)).O.height + QUESTION_POS_Y;
					}
					
					mcScrollbar.updateBtn = true;
					mcScrollbar.prop = Math.max(0, Math.min(1, mcBody.mcMask.height / compHolderH));
					mcScrollbar.perc = Math.max(0, Math.min(1, mcH.y / (mcBody.mcMask.height - compHolderH)));
					mcScrollbar.updateMcBtn(mcScrollbar.perc * (mcScrollbar.mcTrack.height - mcScrollbar.btnSize));
				break;
				
				case "RESULT":
					if (mcBody.mcResult.mcResultContent.height > mcBody.mcResult.mcMask.height)
					{
						mcScrollbar.updateBtn = false;
						scrollType = "RESULT";
						mcBody.mcResult.mcResultContent.y = textY = 0;
						yPos = 0;
						
						mcScrollbar.scrollbarMinSize = settings.scrollbarMinH;
						
						mcScrollbar.x = Math.round(mcBody.Bg.width - (mcScrollbar.mcTrack.width + SCROLLBAR_LEFT_PAD_RESULTPAD));
						mcScrollbar.y = mcBody.mcResult.y;
						
						mcScrollbar.mcTrack.height = mcBody.mcResult.mcMask.height;
						
						mcScrollbar.prop = mcBody.mcResult.mcMask.height / mcBody.mcResult.mcResultContent.height;
						
						mcScrollbar.visible = true;
						Tweener.addTween(mcScrollbar, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
						
						mcScrollbar.scrollBarSignal.add(mcScrollbar_DragHandler);
						this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
					}
				break;
				
				case "ANSWER":
					if (compAnswerHolderH > mcBody.mcMask.height)
					{
						mcScrollbar.updateBtn = false;
						scrollType = "ANSWER";
						mcH.y = textY = 0;
						yPos = 0;
						
						mcScrollbar.scrollbarMinSize = settings.scrollbarMinH;
						
						mcScrollbar.x = Math.round(mcBody.Bg.width - (mcScrollbar.mcTrack.width + SCROLLBAR_LEFT_PAD_ANSWERPAD));
						mcScrollbar.y = mcBody.mcMask.y;
						
						mcScrollbar.mcTrack.height = mcBody.mcMask.height;
						
						mcScrollbar.prop = mcBody.mcMask.height / compAnswerHolderH;
						
						mcScrollbar.visible = true;
						Tweener.addTween(mcScrollbar, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
						
						mcScrollbar.scrollBarSignal.add(mcScrollbar_DragHandler);
						this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
					}
				break;
				
				default:
					mcScrollbar.updateBtn = false;
					mcScrollbar.scrollBarSignal.remove(mcScrollbar_DragHandler);
					this.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
					
					Tweener.addTween(mcScrollbar, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
					{
						mcScrollbar.visible = false;
					} } );
				break;
			}
		}
		//} endregion
		
		//{ region GO NEXT
		private final function goNext():void
		{
			if (qIndex > 0)
			{
				hidePrev(qIndex-1);
			}
			
			if (!mcBody.mcTxt.visible)
			{
				mcBody.mcTxt.visible = true;
				Tweener.addTween(mcBody.mcTxt, { alpha:1, time: 0.3, transition: "easeoutquad" });
			}
			
			if (!mcBody.mcCrt.visible)
			{
				mcBody.mcCrt.mcTxt.txt.htmlText = "<p color = 'grey'>" + String(qLength) + "</p>" + settings.crtSeparator + "<b>" + String(qLength) + "</b>";
				mcBody.mcCrt.Bg.width = Math.round(2 * BODY_CRT_TXT_PAD_LEFT + mcBody.mcCrt.mcTxt.txt.textWidth);
				mcBody.mcCrt.Bg.height = Math.round(mcBody.mcCrt.mcTxt.txt.textHeight + BODY_CRT_TXT_PAD_TOP + BODY_CRT_TXT_PAD_BOTTOM);
				
				mcBody.mcCrt.mcTxt.txt.htmlText = "<p color = 'grey'>" + String(qIndex + 1) + "</p>" + settings.crtSeparator + "<b>" + String(qLength) + "</b>";
				mcBody.mcCrt.mcTxt.x = Math.floor(mcBody.mcCrt.Bg.width / 2 - mcBody.mcCrt.mcTxt.width / 2);
				
				mcBody.mcCrt.x = Math.round(mcBody.Bg.width - (mcBody.mcCrt.Bg.width + BODY_CRT_POS_X));
				mcBody.mcCrt.y = BODY_CRT_POS_Y;
				
				mcBody.mcCrt.visible = true;
				Tweener.addTween(mcBody.mcCrt, { alpha:1, time: 0.3, transition: "easeoutquad" });
			}else 
			{
				mcBody.mcCrt.mcTxt.txt.htmlText = "<p color = 'grey'>" + String(qIndex + 1) + "</p>" + settings.crtSeparator + "<b>" + String(qLength) + "</b>";
				mcBody.mcCrt.mcTxt.x = Math.floor(mcBody.mcCrt.Bg.width / 2 - mcBody.mcCrt.mcTxt.width / 2);
			}
			
			enableNext();
			
			startCounter(dataXML.questions.question[qIndex].timeLimit);
		}
		//} endregion
		
		//{ region START COUNTER
		private final function startCounter(pTimeLimit : *):void
		{
			elapsedTime = Number(pTimeLimit);
			mcElapsedTime = new Timer(1000);
			mcElapsedTime.addEventListener(TimerEvent.TIMER, mcElapsedTime_CompleteHandler, false, 0, true);
			mcElapsedTime.start();
		}
		//} endregion
		
		//{ region ENABLE NEXT
		private final function enableNext():void
		{
			Question(mcH.getChildAt(qIndex)).btnType(true);
			Question(mcH.getChildAt(qIndex)).mcOk.buttonMode = true;
			
			if (settings.startExpanded)
			{
				Question(mcH.getChildAt(qIndex)).CurrSel.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(qIndex)).CurrSel, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
				
				Question(mcH.getChildAt(qIndex)).mcDropDown.CurrSel.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(qIndex)).mcDropDown.CurrSel, { alpha:1, time: 0.3, transition: "easeoutquad" });
			}else 
			{
				Question(mcH.getChildAt(qIndex)).Sel.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(qIndex)).Sel, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
				
				Tweener.addTween(Question(mcH.getChildAt(qIndex)).mcDropDown.mcOut, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(qIndex)).mcDropDown.mcOut.visible = false;
				} } );
				
				if (qIndex == 0 && !settings.startExpanded && Question(mcH.getChildAt(qIndex)).pWas && settings.autoOpen)
				{
					mcQuestion_ClickPressedHandler(qIndex, "NORMAL");
				}
			}
			
			switch (dataXML.questions.question[qIndex].questionType.toLowerCase()) 
			{
				case "check":
					//unlock buttons
					buttonNormal(qIndex);
				break;
				
				case "input":
					//unlock input fields
					inputNormal(qIndex);
				break;
				
				case "radius":
					//unlock Radio buttons
					buttonRadiusNormal(qIndex);
				break;
			}
		}
		//} endregion
		
		//{ region HIDE PREV
		private final function hidePrev(pInd : uint, pGt : Boolean = false):void
		{
			Question(mcH.getChildAt(pInd)).mcOk.O.visible = false;
			Question(mcH.getChildAt(pInd)).mcOk.O.alpha = 0;
			Question(mcH.getChildAt(pInd)).btnType(false);
			Question(mcH.getChildAt(pInd)).mcOk.buttonMode = false;
			
			switch (dataXML.questions.question[pInd].questionType.toLowerCase()) 
			{
				case "check":
					//lock buttons
					buttonOut(pInd);
				break;
				
				case "input":
					//lock input fields
					inputOut(pInd);
				break;
				
				case "radius":
					//lock radio buttons
					buttonRadiusOut(pInd);
				break;
			}
			
			if (settings.startExpanded) 
			{
				Tweener.addTween(Question(mcH.getChildAt(pInd)).CurrSel, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(pInd)).CurrSel.visible = false;
				} } );
				
				Tweener.addTween(Question(mcH.getChildAt(pInd)).mcDropDown.CurrSel, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(pInd)).mcDropDown.CurrSel.visible = false;
					checkResult(pInd, pGt);
				} } );
				
			}else 
			{
				Tweener.addTween(Question(mcH.getChildAt(pInd)).Sel, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(pInd)).Sel.visible = false;
					if (!settings.startExpanded && !settings.generalTime) 
					{
						Question(mcH.getChildAt(pInd)).pOkPressed = false;
						Question(mcH.getChildAt(pInd)).mouseChildren = false;
					}
				} } );
				
				Question(mcH.getChildAt(pInd)).Out.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(pInd)).Out, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
				Tweener.addTween(Question(mcH.getChildAt(pInd)).N, { alpha: 0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(pInd)).N.visible = false;
				} } );
				
				Question(mcH.getChildAt(pInd)).mcDropDown.mcOut.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(pInd)).mcDropDown.mcOut, { alpha:1, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					checkResult(pInd, pGt);
				} } );
			}
		}
		//} endregion
		
		//{ region BUTTON RADIUS OUT
		private final function buttonRadiusOut(pQind : Number = 0, pBind : Number = 0, pFirst : Boolean = false):void
		{
			var bLimit : uint = dataXML.questions.question[pQind].answers.answer.length();
			var objBulletResult : Array = [];
			
			if (!pFirst)
			{
				for (var j:int = 0; j < bLimit; j++)
				{
					Tweener.removeTweens(Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcTxt.txt);
					Tweener.removeTweens(Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.O);
					
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.O.visible = false;
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.O.alpha = 0;
					
					if (!Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).selNotFlag) 
					{
						Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.OutS.visible = true;
						Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.OutS.alpha = 1;
					}else 
					{
						Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.Out.visible = true;
						Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.Out.alpha = 1;
					}
					
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).buttonMode = false;
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.ROLL_OVER, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOverHandler);
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.ROLL_OUT, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOutHandler);
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.CLICK, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).clickHandler);
					Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcTxt.txt.textColor = Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).N_COLOR;
					
					objBulletResult[j] = Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).selNotFlag;
				}
				
				arrayBulletResult[pQind] = objBulletResult;
				
			}else 
			{
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).mcRadius.Out.visible = true;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).mcRadius.Out.alpha = 1;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).buttonMode = false;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.ROLL_OVER, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).rollOverHandler);
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.ROLL_OUT, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).rollOutHandler);
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.CLICK, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).clickHandler);
			}
		}
		//} endregion
		
		//{ region BUTTON OUT
		private final function buttonOut(pQind : Number = 0, pBind : Number = 0, pFirst : Boolean = false):void
		{
			var bLimit : uint = dataXML.questions.question[pQind].answers.answer.length();
			var objBulletResult : Array = [];
			
			if (!pFirst)
			{
				for (var j:int = 0; j < bLimit; j++)
				{
					Tweener.removeTweens(Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcTxt.txt);
					Tweener.removeTweens(Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.O);
					
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.O.visible = false;
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.O.alpha = 0;
					
					if (!Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).selNotFlag) 
					{
						Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.OutS.visible = true;
						Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.OutS.alpha = 1;
					}else 
					{
						Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.Out.visible = true;
						Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.Out.alpha = 1;
					}
					
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).buttonMode = false;
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.ROLL_OVER, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOverHandler);
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.ROLL_OUT, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOutHandler);
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).removeEventListener(MouseEvent.CLICK, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).clickHandler);
					Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcTxt.txt.textColor = Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).N_COLOR;
					
					objBulletResult[j] = Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).selNotFlag;
				}
				
				arrayBulletResult[pQind] = objBulletResult;
				
			}else 
			{
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).mcCheck.Out.visible = true;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).mcCheck.Out.alpha = 1;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).buttonMode = false;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.ROLL_OVER, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).rollOverHandler);
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.ROLL_OUT, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).rollOutHandler);
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).removeEventListener(MouseEvent.CLICK, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(pBind)).clickHandler);
			}
		}
		//} endregion
		
		//{ region BUTTON RADIUS NORMAL
		private final function buttonRadiusNormal(pQind : Number = 0):void
		{
			var bLimit : uint = dataXML.questions.question[pQind].answers.answer.length();
			for (var j:int = 0; j < bLimit; j++)
			{
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.Out.visible = false;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcRadius.Out.alpha = 0;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).buttonMode = true;
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.ROLL_OVER, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOverHandler, false, 0, true);
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.ROLL_OUT, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOutHandler, false, 0, true);
				Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.CLICK, Radius(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).clickHandler, false, 0, true);
			}
		}
		//} endregion
		
		//{ region BUTON NORMAL
		private final function buttonNormal(pQind : Number = 0):void
		{
			var bLimit : uint = dataXML.questions.question[pQind].answers.answer.length();
			for (var j:int = 0; j < bLimit; j++)
			{
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.Out.visible = false;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).mcCheck.Out.alpha = 0;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).buttonMode = true;
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.ROLL_OVER, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOverHandler, false, 0, true);
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.ROLL_OUT, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).rollOutHandler, false, 0, true);
				Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).addEventListener(MouseEvent.CLICK, Check(Question(mcH.getChildAt(pQind)).mcDropDown.mcBulletHld.getChildAt(j)).clickHandler, false, 0, true);
			}
		}
		//} endregion
		
		//{ region INPUT OUT
		private final function inputOut(pQind : Number = 0, pFirst : Boolean = false):void
		{
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_IN, Question(mcH.getChildAt(pQind)).input_FocusInHandler);
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_OUT, Question(mcH.getChildAt(pQind)).input_FocusOutHandler);
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.textColor = QUESTION_INPUT_OUT_TXT_COLOR;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.type = TextFieldType.DYNAMIC;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.selectable = false;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.Out.visible = true;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.Out.alpha = 1;
			
			if (!pFirst)
			{
				arrayBulletResult[pQind] = Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.text.toLowerCase();
			}
		}
		//} endregion
		
		//{ region INPUT NORMAL
		private final function inputNormal(pQind : Number = 0):void
		{
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.addEventListener(FocusEvent.FOCUS_IN, Question(mcH.getChildAt(pQind)).input_FocusInHandler, false, 0, true);
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.addEventListener(FocusEvent.FOCUS_OUT, Question(mcH.getChildAt(pQind)).input_FocusOutHandler, false, 0, true);
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.textColor = QUESTION_INPUT_NORMAL_TXT_COLOR;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.type = TextFieldType.INPUT;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.mcTxt.txt.selectable = true;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.Out.visible = false;
			Question(mcH.getChildAt(pQind)).mcDropDown.mcInput.Out.alpha = 0;
		}
		//} endregion
		
		//{ region ELAPSED TIME FUN
		private final function elapsedTimeFun(ts:Number):String
		{
			ts = Math.round(ts);
			var hrs:Number = Math.floor(ts / 3600);
			var min:Number = Math.floor((ts % 3600) / 60);
			var sec:Number = Math.round((ts % 3600) % 60);
			
			var hrsStr:String = (hrs < 10 ? "0" : "") + String(hrs); 
			var minStr:String = (min < 10 ? "0" : "") + String(min); 
			var secStr:String = (sec < 10 ? "0" : "") + String(sec);
			
			return (hrs > 0)? hrsStr + ":" + minStr + ":" + secStr : minStr + ":" + secStr;
		}
		//} endregion
		
		//{ region STOP TIMER
		private final function stopTimer():void
		{
			mcElapsedTime.removeEventListener(TimerEvent.TIMER, mcElapsedTime_CompleteHandler);
			mcElapsedTime.reset();
			mcElapsedTime.stop();
		}
		//} endregion
		
		//{ region CALCULATE RESULT
		private final function calculateResult(pType : String = ""):void
		{
			switch (pType)
			{
				case "EXPANDED PRV TIME":
				calculateIt();
				break;
				
				case "EXPANDED GEN TIME":
				if (settings.timer) 
				{
					stopTimer();
				}
				
				if (settings.startExpanded) 
				{
					hideAllQ();
				}else 
				{
					hideAllQn();
				}
				calculateIt();
				showResult();
				break;
			}
		}
		//} endregion
		
		//{ region SHOW RESULT
		private final function showResult():void
		{
			for (var v:int = 0; v <= qLength-1; v++)
			{
				if (dataXML.questions.question[v].questionType.toLowerCase() == "radius") 
				{
					var radLength : Number = dataXML.questions.question[v].answers.answer.length();
					
					for (var z:int = 0; z < radLength; z++) 
					{
						Radius(Question(mcH.getChildAt(v)).mcDropDown.mcBulletHld.getChildAt(z)).clickedSignal.remove(Question(mcH.getChildAt(v)).radiusClickedSignalHandler);
						Radius(Question(mcH.getChildAt(v)).mcDropDown.mcBulletHld.getChildAt(z)).remListen();
					}
				}
			}
			
			//removing the Question Holder
			Tweener.addTween(mcBody.mcHolder, { alpha:0 , time: 0.5, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcHolder.visible = false;
				genHolder("DEL");
				
				testScrollBar();
			} } );
			
			Tweener.addTween(mcBody.mcTxt, { alpha: 0, time: 0.5, delay:0.5, transition: "easeoutquad", onComplete: function ():void 
			{
				mcBody.mcTxt.y -= BODY_TIME_X_OFFSET;
				finalScore = settings.finalScore;
				finalScore = finalScore.replace("%RESULT%", partScore);
				finalScore = finalScore.replace("%TOTALSCORE%", settings.totalScore);
				
				mcBody.mcTxt.txt.htmlText = finalScore;
				
				Tweener.addTween(mcBody.mcTxt, { alpha:1, time: 0.5, transition: "easeoutquad" } );
				
			} } );
			
			var rLength : int = dataXML.results.result.length();
			
			var j : int = 0;
			var qouta : Number = settings.totalScore / dataXML.results.result.length();
			
			for (var i:int = 0; i < rLength; i++)
			{
				if (partScore >= qouta * i && partScore <= qouta * (i + 1))
				{
					mcBody.mcRedoQuiz.mouseEnabled = true;
					mcBody.mcRedoQuiz.addEventListener(MouseEvent.ROLL_OVER, mcResult_RollOverHandler, false, 0, true);
					mcBody.mcRedoQuiz.addEventListener(MouseEvent.CLICK, mcResult_ClickHandler, false, 0, true);
					mcBody.mcRedoQuiz.addEventListener(MouseEvent.ROLL_OUT, mcResult_RollOutHandler, false, 0, true);
					
					if (settings.viewDetails) 
					{
						mcBody.mcViewDetails.mouseEnabled = true;
						mcBody.mcViewDetails.addEventListener(MouseEvent.ROLL_OVER, mcViewDetails_RollOverHandler, false, 0, true);
						mcBody.mcViewDetails.addEventListener(MouseEvent.CLICK, mcViewDetails_ClickHandler, false, 0, true);
						mcBody.mcViewDetails.addEventListener(MouseEvent.ROLL_OUT, mcViewDetails_RollOutHandler, false, 0, true);
					}
					
					mcBody.mcResult.mcResultContent.txt.htmlText = dataXML.results.result[j].resultTitle + "\n" + dataXML.results.result[j].resultContent;
					
					textFieldType = "RESULT";
					mcBody.mcResult.mcResultContent.txt.removeEventListener(Event.SCROLL, textField_scrollHandler);
					mcBody.mcResult.mcResultContent.txt.addEventListener(Event.SCROLL, textField_scrollHandler, false, 0, true);
					
					mcBody.mcRedoQuiz.mcTxt.txt.htmlText = settings.restartQuiz;
					mcBody.mcViewDetails.mcTxt.txt.htmlText = settings.detailsBtn;
					
					mcBody.mcRedoQuiz.O.width = mcBody.mcRedoQuiz.N.width = Math.round(mcBody.mcRedoQuiz.mcTxt.width + 2 * BODY_REDOQUIZ_TXT_OFFSET_X);
					mcBody.mcRedoQuiz.O.height = mcBody.mcRedoQuiz.N.height = Math.round(mcBody.mcRedoQuiz.mcTxt.height + 2 * BODY_REDOQUIZ_TXT_OFFSET_Y);
					
					mcBody.mcRedoQuiz.mcTxt.x = Math.round(mcBody.mcRedoQuiz.N.width / 2 - mcBody.mcRedoQuiz.mcTxt.width / 2) - BODY_REDOQUIZ_TXT_PAD_X;
					mcBody.mcRedoQuiz.mcTxt.y = Math.round(mcBody.mcRedoQuiz.N.height / 2 - mcBody.mcRedoQuiz.mcTxt.height / 2) + BODY_REDOQUIZ_TXT_PAD_Y;
					
					mcBody.mcViewDetails.O.width = mcBody.mcViewDetails.N.width = Math.round(2 * BODY_VIEWDETAILS_WIDTH_PAD_X + mcBody.mcViewDetails.mcTxt.width);
					
					mcBody.mcViewDetails.mcTxt.x = Math.round(mcBody.mcViewDetails.N.width/2 - mcBody.mcViewDetails.mcTxt.width/2);
					mcBody.mcViewDetails.mcTxt.y = BODY_VIEWDETAILS_TXT_POS_Y;
					
					mcBody.mcViewDetails.x = Math.round(mcBody.Bg.width - (mcBody.mcViewDetails.O.width + BODY_VIEWDETAILS_POS_X));
					mcBody.mcViewDetails.y = BODY_VIEWDETAILS_POS_Y;
					
					mcBody.mcResult.x = BODY_RESULT_POS_X;
					mcBody.mcResult.y = Math.round(mcBody.mcViewDetails.y + mcBody.mcViewDetails.N.height + BODY_RESULT_POS_Y);
					
					mcBody.mcResult.mcMask.width = mcBody.mcResult.mcResultContent.txt.width = Math.round(mcBody.Bg.width - (2 * BODY_RESULT_POS_X));
					
					mcBody.mcResult.mcResultContent.x = mcBody.mcResult.mcMask.x = BODY_RESULT_TITLE_CONTENT_MASK_POS_X;
					
					mcBody.mcResult.mcResultContent.y = mcBody.mcResult.mcMask.y = BODY_RESULT_TITLE_CONTENT_MASK_POS_Y;
					
					mcBody.mcRedoQuiz.x = Math.round(mcBody.Bg.width - (mcBody.mcRedoQuiz.N.width + BODY_REDOQUIZ_POS_X));
					mcBody.mcRedoQuiz.y = Math.round(mcBody.Bg.height - (mcBody.mcRedoQuiz.N.height + BODY_REDOQUIZ_POS_Y));
					
					mcBody.mcResult.mcMask.height = Math.round(mcBody.Bg.height - (mcBody.mcResult.y + mcBody.mcRedoQuiz.N.height + BODY_RESULT_CONTENT_MASK_OFFSET));
					
					//removing the mcCrt
					Tweener.addTween(mcBody.mcCrt, { alpha: 0, delay:0.5, time: 0.5, transition: "easeoutquad", onComplete: function ():void 
					{
						mcBody.mcCrt.visible = false;
						mcBody.mcCrt.mcTxt.txt.htmlText = "";
						
						if (settings.viewDetails) 
						{
							mcBody.mcViewDetails.visible = true;
							Tweener.addTween(mcBody.mcViewDetails, { alpha:1, time: 0.3, transition: "easeoutquad" } );
						}else 
						{
							if (settings.sendDataToPhp)
							{
								generateReport();
							}
						}
						
						mcBody.mcRedoQuiz.visible = true;
						Tweener.addTween(mcBody.mcRedoQuiz, { alpha:1, time: 0.3, transition: "easeoutquad" } );
						
						mcBody.mcResult.visible = true;
						Tweener.addTween(mcBody.mcResult, { alpha:1, time: 0.3, transition: "easeoutquad" } );
						
						testScrollBar("RESULT");
					} } );
					
					j++;
				}else 
				{
					j++;
				}
			}
		}
		//} endregion
		
		//{ region SHOW FIRST PAGE
		private final function showFirstPage(pMode : Boolean):void
		{
			if (pMode)
			{
				mcStartPage.mcBtn.mouseEnabled = true;
				mcBody.mcRedoQuiz.removeEventListener(MouseEvent.ROLL_OVER, mcResult_RollOverHandler);
				mcBody.mcRedoQuiz.removeEventListener(MouseEvent.CLICK, mcResult_ClickHandler);
				mcBody.mcRedoQuiz.removeEventListener(MouseEvent.ROLL_OUT, mcResult_RollOutHandler);
				
				mcBody.mcResult.mcResultContent.txt.removeEventListener(Event.SCROLL, textField_scrollHandler);
				textFieldType = "";
				
				mcStartPage.mcBtn.addEventListener(MouseEvent.ROLL_OVER, mcStartPage_RollOverHandler, false, 0, true);
				mcStartPage.mcBtn.addEventListener(MouseEvent.CLICK, mcStartPage_ClickHandler, false, 0, true);
				mcStartPage.mcBtn.addEventListener(MouseEvent.ROLL_OUT, mcStartPage_RollOUtHandler, false, 0, true);
				
				textFieldType = "START_PAGE";
				mcStartPage.mcTxt.txt.removeEventListener(Event.SCROLL, textField_scrollHandler);
				mcStartPage.mcTxt.txt.addEventListener(Event.SCROLL, textField_scrollHandler, false, 0, true);
				
				mcStartPage.visible = true;
				Tweener.addTween(mcStartPage, { alpha: 1, delay: 0.3, time: 0.3, transition: "easeoutquad" } );
				
				//SHOW | DO NOT SHOW THE SCROLLBAR
				testScrollBar("START_PAGE");
				
			}else 
			{
				Tweener.addTween(mcStartPage, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcStartPage.visible = false;
					mcStartPage.mcTxt.txt.removeEventListener(Event.SCROLL, textField_scrollHandler);
					textFieldType = "";
					
					mcStartPage.mcBtn.removeEventListener(MouseEvent.ROLL_OVER, mcStartPage_RollOverHandler);
					mcStartPage.mcBtn.removeEventListener(MouseEvent.CLICK, mcStartPage_ClickHandler);
					mcStartPage.mcBtn.removeEventListener(MouseEvent.ROLL_OUT, mcStartPage_RollOUtHandler);
					mcStartPage_RollOUtHandler();
					
				} } );
				
				testScrollBar();
			}
		}
		//} endregion
		
		//{ region GENERATE HOLDER
		private final function genHolder(pType : String):void
		{
			switch (pType)
			{
				case "GEN":
					mcH = new MovieClip();
					mcH.name = "mcH";
					mcBody.mcHolder.addChild(mcH);
					mcH.x = MC_H_POS_X;
					mcH.y = MC_H_POS_Y;
				break;
				
				case "DEL":
					mcH.y = 0;
					mcH.height = 0;
					mcBody.mcHolder.removeChild(mcH);
					mcH = null;
				break;
			}
		}
		//} endregion
		
		//{ region ARRANGE ANSWERS
		private final function arrangeAnswers(mcFirst : MovieClip, mcSecond : MovieClip, mcThird : MovieClip, mcAnswerW : Number):void
		{
			var biggest : Number = 0;
			var xPos : Number = 0;
			
			if (mcFirst.mcLbl.width >= mcSecond.mcLbl.width && mcFirst.mcLbl.width >= mcThird.mcLbl.width)
			{
				biggest = mcFirst.mcLbl.width;
				xPos = mcFirst.mcLbl.x;
			}
			
			if (mcSecond.mcLbl.width >= mcFirst.mcLbl.width && mcSecond.mcLbl.width >= mcThird.mcLbl.width)
			{
				biggest = mcSecond.mcLbl.width;
				xPos = mcSecond.mcLbl.x;
			}
			
			if (mcThird.mcLbl.width >= mcFirst.mcLbl.width && mcThird.mcLbl.width >= mcSecond.mcLbl.width)
			{
				biggest = mcThird.mcLbl.width;
				xPos = mcThird.mcLbl.x;
			}
			
			if (Math.round(mcFirst.mcTxt.width) >=
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_CORRECT_TXT_PAD_X + biggest + xPos)))
			{
				mcFirst.mcTxt.txt.wordWrap = true;
				mcFirst.mcTxt.txt.multiline = true;
				
				mcFirst.mcTxt.txt.width = 
				Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_CORRECT_TXT_PAD_X + biggest + xPos));
			}
			
			mcFirst.mcLine.width =	
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_CORRECT_TXT_PAD_X + biggest + xPos));
			
			if (Math.round(mcSecond.mcTxt.width) >=
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X + biggest + xPos)))
			{
				mcSecond.mcTxt.txt.wordWrap = true;
				mcSecond.mcTxt.txt.multiline = true;
				
				mcSecond.mcTxt.txt.width = 
				Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X + biggest + xPos));
			}
			
			mcSecond.mcLine.width = 
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X + biggest + xPos));
			
			if (Math.round(mcThird.mcTxt.width) >=
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_SCORE_TXT_PAD_X + biggest + xPos)))
			{
				mcThird.mcTxt.txt.wordWrap = true;
				mcThird.mcTxt.txt.multiline = true;
				
				mcThird.mcTxt.txt.width = 
				Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_SCORE_TXT_PAD_X + biggest + xPos));
			}
			
			mcThird.mcLine.width = 
			Math.round(mcAnswerW - (2 * ANSWER_ANSW_POS_X + ANSWER_ANSW_SCORE_TXT_PAD_X + biggest + xPos));
			
			if (mcFirst.mcLbl.width >= mcSecond.mcLbl.width && mcFirst.mcLbl.width >= mcThird.mcLbl.width)
			{
				mcFirst.x = ANSWER_ANSW_POS_X;
				mcFirst.y = ANSWER_ANSW_POS_Y;
				mcFirst.mcLbl.x = ANSWER_ANSW_CORRECT_POS_X;
				mcFirst.mcLbl.y = ANSWER_ANSW_CORRECT_POS_Y;
				mcFirst.mcTxt.x = Math.round(mcFirst.mcLbl.x + mcFirst.mcLbl.width + ANSWER_ANSW_CORRECT_TXT_PAD_X);
				mcFirst.mcTxt.y = ANSWER_ANSW_CORRECT_TXT_PAD_Y;
				
				mcSecond.x = Math.round(mcFirst.x + (mcFirst.mcLbl.width - mcSecond.mcLbl.width));
				mcSecond.y = Math.round(mcFirst.height + mcFirst.y);
				mcSecond.mcLbl.x = ANSWER_ANSW_YOUR_ANSW_POS_X;
				mcSecond.mcLbl.y = ANSWER_ANSW_YOUR_ANSW_POS_Y;
				mcSecond.mcTxt.x = Math.round(mcSecond.mcLbl.x + mcSecond.mcLbl.width + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X);
				mcSecond.mcTxt.y = ANSWER_ANSW_YOUR_ANSW_TXT_PAD_Y;
				
				mcThird.x = Math.round(mcFirst.x + (mcFirst.mcLbl.width - mcThird.mcLbl.width));
				mcThird.y = Math.round(mcSecond.height + mcSecond.y);
				mcThird.mcLbl.x = ANSWER_ANSW_SCORE_POS_X;
				mcThird.mcLbl.y = ANSWER_ANSW_SCORE_POS_Y;
				mcThird.mcTxt.x = Math.round(mcThird.mcLbl.x + mcThird.mcLbl.width + ANSWER_ANSW_SCORE_TXT_PAD_X);
				mcThird.mcTxt.y = ANSWER_ANSW_SCORE_TXT_PAD_Y;
			}
			
			if (mcSecond.mcLbl.width > mcFirst.mcLbl.width && mcSecond.mcLbl.width > mcThird.mcLbl.width)
			{
				mcSecond.x = ANSWER_ANSW_POS_X;
				mcFirst.x = Math.round(mcSecond.x + (mcSecond.mcLbl.width - mcFirst.mcLbl.width));
				mcFirst.y = ANSWER_ANSW_POS_Y;
				mcFirst.mcLbl.x = ANSWER_ANSW_CORRECT_POS_X;
				mcFirst.mcLbl.y = ANSWER_ANSW_CORRECT_POS_Y;
				mcFirst.mcTxt.x = Math.round(mcFirst.mcLbl.x + mcFirst.mcLbl.width + ANSWER_ANSW_CORRECT_TXT_PAD_X);
				mcFirst.mcTxt.y = ANSWER_ANSW_CORRECT_TXT_PAD_Y;
				
				mcSecond.y = Math.round(mcFirst.height + mcFirst.y);
				mcSecond.mcLbl.x = ANSWER_ANSW_YOUR_ANSW_POS_X;
				mcSecond.mcLbl.y = ANSWER_ANSW_YOUR_ANSW_POS_Y;
				mcSecond.mcTxt.x = Math.round(mcSecond.mcLbl.x + mcSecond.mcLbl.width + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X);
				mcSecond.mcTxt.y = ANSWER_ANSW_YOUR_ANSW_TXT_PAD_Y;
				
				mcThird.x = Math.round(mcSecond.x + (mcSecond.mcLbl.width - mcThird.mcLbl.width));
				mcThird.y = Math.round(mcSecond.height + mcSecond.y);
				mcThird.mcLbl.x = ANSWER_ANSW_SCORE_POS_X;
				mcThird.mcLbl.y = ANSWER_ANSW_SCORE_POS_Y;
				mcThird.mcTxt.x = Math.round(mcThird.mcLbl.x + mcThird.mcLbl.width + ANSWER_ANSW_SCORE_TXT_PAD_X);
				mcThird.mcTxt.y = ANSWER_ANSW_SCORE_TXT_PAD_Y;
			}
			
			if (mcThird.mcLbl.width >= mcFirst.mcLbl.width && mcThird.mcLbl.width >= mcSecond.mcLbl.width) 
			{
				mcThird.x = ANSWER_ANSW_POS_X;
				mcFirst.x = Math.round(mcThird.x + (mcThird.mcLbl.width - mcFirst.mcLbl.width));
				mcFirst.y = ANSWER_ANSW_POS_Y;
				mcFirst.mcLbl.x = ANSWER_ANSW_CORRECT_POS_X;
				mcFirst.mcLbl.y = ANSWER_ANSW_CORRECT_POS_Y;
				mcFirst.mcTxt.x = Math.round(mcFirst.mcLbl.x + mcFirst.mcLbl.width + ANSWER_ANSW_CORRECT_TXT_PAD_X);
				mcFirst.mcTxt.y = ANSWER_ANSW_CORRECT_TXT_PAD_Y;
				
				mcSecond.x = Math.round(mcThird.x + (mcThird.mcLbl.width - mcSecond.mcLbl.width));
				mcSecond.y = Math.round(mcFirst.height + mcFirst.y);
				mcSecond.mcLbl.x = ANSWER_ANSW_YOUR_ANSW_POS_X;
				mcSecond.mcLbl.y = ANSWER_ANSW_YOUR_ANSW_POS_Y;
				mcSecond.mcTxt.x = Math.round(mcSecond.mcLbl.x + mcSecond.mcLbl.width + ANSWER_ANSW_YOUR_ANSW_TXT_PAD_X);
				mcSecond.mcTxt.y = ANSWER_ANSW_YOUR_ANSW_TXT_PAD_Y;
				
				mcThird.y = Math.round(mcSecond.height + mcSecond.y);
				mcThird.mcLbl.x = ANSWER_ANSW_SCORE_POS_X;
				mcThird.mcLbl.y = ANSWER_ANSW_SCORE_POS_Y;
				mcThird.mcTxt.x = Math.round(mcThird.mcLbl.x + mcThird.mcLbl.width + ANSWER_ANSW_SCORE_TXT_PAD_X);
				mcThird.mcTxt.y = ANSWER_ANSW_SCORE_TXT_PAD_Y;
			}
			
			mcFirst.mcLine.x = Math.ceil(mcFirst.mcTxt.x);
			mcFirst.mcLine.y = Math.ceil(mcFirst.mcTxt.height + mcFirst.mcTxt.y);
			mcFirst.mcLine.height = ANSWER_ANSW_LINE_HEIGHT;
			
			mcSecond.mcLine.x = Math.ceil(mcSecond.mcTxt.x);
			mcSecond.mcLine.y = Math.ceil(mcSecond.mcTxt.height + mcSecond.mcTxt.y);
			mcSecond.mcLine.height = ANSWER_ANSW_LINE_HEIGHT;
			
			mcThird.mcLine.x = Math.ceil(mcThird.mcTxt.x);
			mcThird.mcLine.y = Math.ceil(mcThird.mcTxt.height + mcThird.mcTxt.y);
			mcThird.mcLine.height = ANSWER_ANSW_LINE_HEIGHT;
		}
		//} endregion
		
		//{ region START GENERAL TIMER
		private final function startGeneralTimer():void
		{
			
			if (!mcBody.mcTxt.visible)
			{
				mcBody.mcTxt.visible = true;
				Tweener.addTween(mcBody.mcTxt, { alpha:1, time: 0.3, transition: "easeoutquad" });
			}
			
			if (settings.timer) 
			{
				startCounter(settings.generalTimeLimit);
			}else 
			{
				mcBody.mcTxt.txt.text = "";
			}
			
		}
		//} endregion
		
		//{ region HIDE ALL QUESTIONS
		private final function hideAllQ():void
		{
			for (var i:int = 0; i < qLength; i++)
			{
				Question(mcH.getChildAt(i)).buttonMode = false;
				Question(mcH.getChildAt(i)).clickBtnSignal.remove(mcQuestion_ClickPressedHandler);
				Question(mcH.getChildAt(i)).removeEventListener(MouseEvent.CLICK, Question(mcH.getChildAt(i)).clickHandler);
				hidePrev(i, true);
				Question(mcH.getChildAt(i)).mcDropDown.mcOut.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(i)).mcDropDown.mcOut, { alpha: 1, time: 0.3, transition: "easeoutquad" });
			}
		}
		//} endregion
		
		//{ region HIDE ALL QUESTIONS NOT EXPANDED
		private final function hideAllQn():void 
		{
			hideAllQFlag = true;
			for (var i:int = 0; i < qLength; i++)
			{
				hidePrev(i, true);
				Question(mcH.getChildAt(i)).mcDropDown.mcOut.visible = true;
				
				Question(mcH.getChildAt(i)).mouseChildren = false;
				
				if (Question(mcH.getChildAt(i)).pOkPressed)
				{
					Question(mcH.getChildAt(i)).pOkPressed = false;
				}
				
				Tweener.addTween(Question(mcH.getChildAt(i)).mcDropDown.mcOut, { alpha: 1, time: 0.3, transition: "easeoutquad" });
			}
		}
		//} endregion
		
		//{ region CALCULATE IT
		private final function calculateIt():void
		{
			for (var i:int = 0; i < qLength; i++)
			{
				switch (dataXML.questions.question[i].questionType.toLowerCase()) 
				{
					case "check":
						var bLength : int = dataXML.questions.question[i].answers.answer.length();
						
						bulletAnswer = 0;
						buttonPressed = 0;
						
						for (var j:int = 0; j < bLength; j++)
						{
							if (!Check(Question(mcH.getChildAt(i)).mcDropDown.mcBulletHld.getChildAt(j)).selNotFlag)
							{
								if (Check(Question(mcH.getChildAt(i)).mcDropDown.mcBulletHld.getChildAt(j)).attrExists) 
								{
									bulletAnswer++;
								}
								
								buttonPressed++;
							}
						}
						
						if (Question(mcH.getChildAt(i)).correctAnswer == 0 && buttonPressed == 0 && bulletAnswer == 0)
						{
							partScore += Number(dataXML.questions.question[i].score);
						}
						
						if (buttonPressed != 0 && bulletAnswer == 0 || buttonPressed > bulletAnswer)
						{
							buttonPressed = 0;
						}
						
						if(Question(mcH.getChildAt(i)).correctAnswer == bulletAnswer && buttonPressed != 0)
						{
							partScore += Number(dataXML.questions.question[i].score);
						}
					break;
					
					case "input":
						var searchFlag : Boolean = false;
						var idemFlag : Boolean = false;
						
						Question(mcH.getChildAt(i)).mcDropDown.mcInput.mcTxt.txt.htmlText = 
						StringUtil.squeeze(Question(mcH.getChildAt(i)).mcDropDown.mcInput.mcTxt.txt.text).toLowerCase();
						inputResults = Question(mcH.getChildAt(i)).mcDropDown.mcInput.mcTxt.txt.text.split(re);
						
						if (StringUtil.stripHTML(StringUtil.squeeze(String(dataXML.questions.question[i].answers.answer))).length == 
						StringUtil.squeeze(Question(mcH.getChildAt(i)).mcDropDown.mcInput.mcTxt.txt.text).length)
						{
							idemFlag = true;
						}
						
						var iLength : uint = inputResults.length;
						for (var k:int = 0; k < iLength; k++)
						{
							if (StringUtil.stripHTML(StringUtil.squeeze(String(dataXML.questions.question[i].answers.answer).toLowerCase())).search(inputResults[k].toLowerCase()) != -1)
							{
								searchFlag = true;
							}
						}
						
						if (searchFlag && idemFlag)
						{
							partScore += Number(dataXML.questions.question[i].score);
						}
					break;
					
					case "radius":
						var rLength : int = dataXML.questions.question[i].answers.answer.length();
						
						radiusAnswer = 0;
						radiusPressed = 0;
						
						for (var l:int = 0; l < rLength; l++)
						{
							if (!Radius(Question(mcH.getChildAt(i)).mcDropDown.mcBulletHld.getChildAt(l)).selNotFlag)
							{
								if (Radius(Question(mcH.getChildAt(i)).mcDropDown.mcBulletHld.getChildAt(l)).attrExists)
								{
									radiusAnswer++;
								}
								
								radiusPressed++;
							}
						}
						
						if (Question(mcH.getChildAt(i)).correctAnswer == 0 && radiusPressed == 0 && radiusAnswer == 0)
						{
							partScore += Number(dataXML.questions.question[i].score);
						}
						
						if (radiusPressed != 0 && radiusAnswer == 0 || radiusPressed > radiusAnswer)
						{
							radiusPressed = 0;
						}
						
						if(Question(mcH.getChildAt(i)).correctAnswer == radiusAnswer && radiusPressed != 0)
						{
							partScore += Number(dataXML.questions.question[i].score);
						}
					break;
				}
			}
		}
		//} endregion
		
		//{ region GENERATE QUESTION
		private final function generateQuestion(pType : Boolean, mcQ : MovieClip, i : int):void
		{
			mcQ.mode(String(settings.startExpanded));
			
			mcQ.qIndex = i;
			
			//formatting the Question Button
			mcQ.mcNr.txt.htmlText = "<b>" + String(i+1) + "." + "</b>";
			mcQ.mcTxt.txt.htmlText = dataXML.questions.question[i].questionText;
			
			mcQ.O.width = mcBody.mcMask.width;
			
			mcQ.mcNr.x = QUESTION_NR_PAD_LEFT;
			mcQ.mcNr.y = QUESTION_NR_PAD_TOP;
			
			mcQ.mcTxt.x = Math.round(mcQ.mcNr.x + mcQ.mcNr.width + QUESTION_TXT_PAD_LEFT);
			mcQ.mcTxt.y = QUESTION_TXT_PAD_TOP;
			
			if (settings.generalTime)
			{
				mcQ.mcTxt.txt.width = Math.round(mcQ.O.width - (2 * mcQ.mcTxt.x));
				mcQ.buttonMode = true;
				
				if (!pType)
				{
					mcQ.mcOk.N.txt.htmlText = settings.okBtn;
					mcQ.mcOk.O.width = Math.round(mcQ.mcOk.N.width + 2 * QUESTION_OK_PAD_LEFT);
					mcQ.mcOk.O.height = Math.round(mcQ.mcOk.N.txt.textHeight + 2 * QUESTION_OK_PAD_TOP) - QUESTION_OK_OFFSET;
					mcQ.mcOk.N.x = Math.floor(mcQ.mcOk.O.width / 2 - mcQ.mcOk.N.width / 2);
					mcQ.mcOk.N.y = Math.ceil(mcQ.mcOk.O.height / 2 - mcQ.mcOk.N.height / 2) + QUESTION_OK_OFFSET_Y;
					
					mcQ.mcOk.x = Math.round(mcQ.O.width - (mcQ.mcOk.O.width + QUESTION_OK_POS_X));
					mcQ.mcOk.y = QUESTION_OK_POS_Y;
					
					mcQ.mcTr.x = Math.round(mcQ.mcOk.x + mcQ.mcOk.width / 2 );
					mcQ.mcTr.y = Math.round(mcQ.mcOk.y + mcQ.mcOk.height / 2 );
					
					mcQ.clickType = "NORMAL GEN TIME";
				}
				
				mcQ.clickBtnSignal.add(mcQuestion_ClickPressedHandler);
				mcQ.mode("remove ok btn");
			}else 
			{
				mcQ.okBtnSignal.add(mcQuestion_OkBtnPressedHandler);
				
				mcQ.mcOk.N.txt.htmlText = settings.okBtn;
				mcQ.mcOk.O.width = Math.round(mcQ.mcOk.N.width + 2 * QUESTION_OK_PAD_LEFT);
				mcQ.mcOk.O.height = Math.round(mcQ.mcOk.N.txt.textHeight + 2 * QUESTION_OK_PAD_TOP) - QUESTION_OK_OFFSET;
				mcQ.mcOk.N.x = Math.floor(mcQ.mcOk.O.width / 2 - mcQ.mcOk.N.width / 2);
				mcQ.mcOk.N.y = Math.ceil(mcQ.mcOk.O.height / 2 - mcQ.mcOk.N.height / 2) + QUESTION_OK_OFFSET_Y;
				
				mcQ.mcOk.x = Math.round(mcQ.O.width - (mcQ.mcOk.O.width + QUESTION_OK_POS_X));
				mcQ.mcOk.y = QUESTION_OK_POS_Y;
				
				mcQ.mcDropDown.mcOut.visible = true;
				mcQ.mcDropDown.mcOut.alpha = 1;
				
				mcQ.mcOk.buttonMode = false;
				mcQ.btnType(false);
				
				if (!pType)
				{
					mcQ.clickBtnSignal.add(mcQuestion_ClickPressedHandler);
					mcQ.mcTr.x = Math.round(mcQ.mcOk.x + mcQ.mcOk.width / 2 );
					mcQ.mcTr.y = Math.round(mcQ.mcOk.y + mcQ.mcOk.height / 2 );
					
					mcQ.mcOk.visible = false;
					mcQ.mcOk.alpha = 0;
				}else 
				{
					mcQ.buttonMode = false;
				}
				
				mcQ.mcTxt.txt.width = Math.round(mcQ.mcOk.x - (mcQ.mcTxt.x + QUESTION_TXT_PAD_RIGHT));
			}
			
			if (pType)
			{
				mcQ.CurrSel.x = mcQ.O.x = QUESTION_CURRSEL_POS_X;
				mcQ.CurrSel.y = mcQ.O.y = QUESTION_CURRSEL_POS_Y;
				
				mcQ.O.height = mcQ.CurrSel.height = Math.round(mcQ.mcTxt.height + 2 * QUESTION_TXT_PAD_TOP);
				mcQ.mcTxt.buttonMode = false;
				mcQ.mcNr.buttonMode = false;
				mcQ.mcDropDown.Bg.width = mcQ.mcDropDown.mcOut.width = mcQ.mcDropDown.CurrSel.width = mcQ.CurrSel.width = mcBody.mcMask.width;
				
			}else 
			{
				mcQ.N.x = mcQ.Sel.x = mcQ.O.x = mcQ.Out.x = QUESTION_CURRSEL_POS_X;
				mcQ.N.y = mcQ.Sel.y = mcQ.O.y = mcQ.Out.y = QUESTION_CURRSEL_POS_Y;
				
				mcQ.O.height = mcQ.Sel.height = mcQ.N.height = mcQ.Out.height = Math.round(mcQ.mcTxt.height + 2 * QUESTION_TXT_PAD_TOP);
				mcQ.mcDropDown.Bg.width = mcQ.mcDropDown.mcOut.width = mcQ.Sel.width = mcQ.N.width = mcQ.Out.width = mcBody.mcMask.width;
			}
			
			mcQ.mcDown.x = Math.round(mcQ.O.width - (QUESTION_DOWN_PAD_LEFT + mcQ.mcDown.width));
			mcQ.mcDown.y = Math.round(mcQ.O.height - QUESTION_DOWN_PAD_TOP);
			
			mcQ.x = 0;
			mcQ.y = 0;
			mcH.addChildAt(mcQ, i);
			
			switch (dataXML.questions.question[i].questionType.toLowerCase())
			{
				case "check":
					mcQ.mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_IN, mcQ.input_FocusInHandler);
					mcQ.mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_OUT, mcQ.input_FocusOutHandler);
						
					aLength = dataXML.questions.question[i].answers.answer.length();
					
					for (var j:int = 0; j < aLength; j++)
					{
						var mcCheck : Check = new Check();
						
						if (!settings.startExpanded)
						{
							mcCheck.generalIndex = i;
							mcCheck.createSignal();
							mcCheck.bulletAction.add(bulletAction_listener);
						}
						
						mcCheck.mcTxt.txt.htmlText = dataXML.questions.question[i].answers.answer[j];
						
						if(mcCheck.mcTxt.width > Math.ceil(mcQ.mcDropDown.Bg.width - (2 * QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT + mcCheck.mcCheck.width)))
						{
							var str : String = mcCheck.mcTxt.txt.htmlText;
							mcCheck.mcTxt.txt.wordWrap = true;
							mcCheck.mcTxt.txt.width = Math.round(mcQ.mcDropDown.Bg.width - (2 * QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT + mcCheck.mcCheck.width));
							mcCheck.mcTxt.txt.htmlText = str;
						}
						
						mcCheck.mcTxt.x = Math.round(QUESTION_BULLET_TXT_POS_LEFT + mcCheck.mcCheck.width);
						mcCheck.mcTxt.y = QUESTION_BULLET_TXT_POS_TOP;
						mcCheck.mcCheck.x = QUESTION_BULLET_BULLET_POS_LEFT;
						mcCheck.mcCheck.y = QUESTION_BULLET_BULLET_POS_TOP;
						
						mcQ.mcDropDown.mcBulletHld.addChild(mcCheck);
						
						mcQ.mcDropDown.mcBulletHld.x = QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT;
						mcQ.mcDropDown.mcBulletHld.y = QUESTION_DROP_DOWN_BULLET_HLD_PAD_TOP;
						
						//mcCheck Out state
						if (!settings.generalTime)
						{
							buttonOut(i, j, true);
						}
						
						if (j-1 >= 0)
						{
							if (Math.ceil(mcCheck.mcCheck.x + mcCheck.mcCheck.width + mcCheck.mcTxt.x + mcCheck.mcTxt.width) <
							Math.floor(mcQ.mcDropDown.Bg.width - 
							( 
							Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).x + 
							(Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).mcCheck.x +
							Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).mcCheck.width +
							Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).mcTxt.x +
							Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).mcTxt.width) +
							QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT)))
							{
								mcCheck.x = Math.round(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1).x +
								mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1).width + QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT);
								mcCheck.y = Check(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1)).y;
							}else 
							{
								mcCheck.x = QUESTION_BULLET_POS_LEFT;
								mcCheck.y = Math.round(mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1).y + mcQ.mcDropDown.mcBulletHld.getChildAt(j - 1).height);
							}
							
						}else 
						{
							mcCheck.x = QUESTION_BULLET_POS_LEFT;
							mcCheck.y = QUESTION_BULLET_POS_TOP;			
						}
						
						if (dataXML.questions.question[i].answers.answer[j].@correct != undefined)
						{
							mcQ.correctAnswer++;
							mcCheck.attrExists = true;
						}
						
						mcQ.mcDropDown.Bg.height = mcQ.mcDropDown.mcOut.height = mcQ.mcDropDown.CurrSel.height = 
						Math.round(2 * QUESTION_BULLET_POS_TOP + mcQ.mcDropDown.mcBulletHld.height);
						
						mcCheck.visible = true;
						mcCheck.alpha = 1;
					}
						mcQ.removeMc("CHECK");
						
						mcQ.mcDropDown.mcBulletHld.visible = true;
						mcQ.mcDropDown.mcBulletHld.alpha = 1;
				break;
				
				case "input":
					mcQ.mcDropDown.mcInput.N.width = mcQ.mcDropDown.mcInput.O.width =
					mcQ.mcDropDown.mcInput.Out.width = 
					Math.round(mcBody.mcMask.width - 2 * QUESTION_INPUT_PAD_LEFT);
					
					mcQ.mcDropDown.mcInput.mcTxt.txt.width = Math.round(mcQ.mcDropDown.mcInput.N.width - 2 * QUESTION_INPUT_INPUTTXT_PAD_LEFT);
					
					if (dataXML.questions.question[i].restrictInput != undefined)
					{
						switch (dataXML.questions.question[i].restrictInput.toLowerCase())
						{
							case "number":
							mcQ.mcDropDown.mcInput.mcTxt.txt.restrict = "0-9.\\-";
							break;
							
							case "integer":
							mcQ.mcDropDown.mcInput.mcTxt.txt.restrict = "0-9\\-";
							break;
							
							case "spacechar":
							mcQ.mcDropDown.mcInput.mcTxt.txt.restrict = "aA-zZ ^\\^_";
							break;
							
							case "char":
							mcQ.mcDropDown.mcInput.mcTxt.txt.restrict = "aA-zZ^\\^_";
							break;
						}
					}
					
					if (dataXML.questions.question[i].charLimit != undefined)
					{
						mcQ.mcDropDown.mcInput.mcTxt.txt.maxChars = Number(dataXML.questions.question[i].charLimit);
					}
					
					mcQ.mcDropDown.mcInput.mcTxt.x = QUESTION_INPUT_INPUTTXT_PAD_LEFT;
					mcQ.mcDropDown.mcInput.mcTxt.y = QUESTION_INPUT_INPUTTXT_PAD_TOP;
					
					mcQ.mcDropDown.mcInput.x = QUESTION_INPUT_PAD_LEFT;
					mcQ.mcDropDown.mcInput.y = QUESTION_INPUT_PAD_TOP + QUESTION_INPUT_PAD_OFFSET;
					
					mcQ.mcDropDown.Bg.height = mcQ.mcDropDown.mcOut.height = mcQ.mcDropDown.CurrSel.height = 
					Math.round(2 * QUESTION_INPUT_PAD_TOP + mcQ.mcDropDown.mcInput.height + QUESTION_INPUT_PAD_OFFSET);
					
					if (!settings.generalTime)
					{
						inputOut(i, true);
					}
					
					mcQ.mcDropDown.Bg.x = mcQ.mcDropDown.mcOut.x = 0;
					mcQ.mcDropDown.Bg.y = mcQ.mcDropDown.mcOut.y = 0;
					
					mcQ.removeMc("INPUT");
					
					mcQ.mcDropDown.mcInput.visible = true;
					mcQ.mcDropDown.mcInput.alpha = 1;
				break;
					
				case "radius":
					mcQ.mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_IN, mcQ.input_FocusInHandler);
					mcQ.mcDropDown.mcInput.mcTxt.txt.removeEventListener(FocusEvent.FOCUS_OUT, mcQ.input_FocusOutHandler);
						
					aLength = dataXML.questions.question[i].answers.answer.length();
					
					mcQ.radiusAllSignal();
					
					for (var k:int = 0; k < aLength; k++)
					{
						var mcRadius : Radius = new Radius();
						
						mcRadius.generalIndex = i;
						
						if (!settings.startExpanded)
						{
							//mcRadius.generalIndex = i;
							mcRadius.createSignal();
							mcRadius.bulletAction.add(bulletAction_listener);
						}
						
						mcRadius.mcTxt.txt.htmlText = dataXML.questions.question[i].answers.answer[k];
						
						if(mcRadius.mcTxt.width > Math.ceil(mcQ.mcDropDown.Bg.width - (2 * QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT + mcRadius.mcRadius.width)))
						{
							var strRad : String = mcRadius.mcTxt.txt.htmlText;
							mcRadius.mcTxt.txt.wordWrap = true;
							mcRadius.mcTxt.txt.width = Math.round(mcQ.mcDropDown.Bg.width - (2 * QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT + mcRadius.mcRadius.width));
							mcRadius.mcTxt.txt.htmlText = strRad;
						}
						
						mcRadius.mcTxt.x = Math.round(QUESTION_BULLET_TXT_POS_LEFT + mcRadius.mcRadius.width);
						mcRadius.mcTxt.y = QUESTION_BULLET_TXT_POS_TOP;
						mcRadius.mcRadius.x = QUESTION_BULLET_BULLET_POS_LEFT;
						mcRadius.mcRadius.y = QUESTION_BULLET_BULLET_POS_TOP;
						
						mcQ.mcDropDown.mcBulletHld.addChild(mcRadius);
						mcRadius.clickedSignal.add(mcQ.radiusClickedSignalHandler);
						
						mcQ.mcDropDown.mcBulletHld.x = QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT;
						mcQ.mcDropDown.mcBulletHld.y = QUESTION_DROP_DOWN_BULLET_HLD_PAD_TOP;
						
						//mcRadius Out state
						if (!settings.generalTime)
						{
							
							//buttonOut(i, j, true);
							buttonRadiusOut(i, k, true);
						}
						
						if (k-1 >= 0)
						{
							if (Math.ceil(mcRadius.mcRadius.x + mcRadius.mcRadius.width + mcRadius.mcTxt.x + mcRadius.mcTxt.width) <
							Math.floor(mcQ.mcDropDown.Bg.width - 
							( 
							Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).x + 
							(Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).mcRadius.x +
							Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).mcRadius.width +
							Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).mcTxt.x +
							Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).mcTxt.width) +
							QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT)))
							{
								mcRadius.x = Math.round(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1).x +
								mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1).width + QUESTION_DROP_DOWN_BULLET_HLD_PAD_LEFT);
								mcRadius.y = Radius(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1)).y;
							}else 
							{
								mcRadius.x = QUESTION_BULLET_POS_LEFT;
								mcRadius.y = Math.round(mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1).y + mcQ.mcDropDown.mcBulletHld.getChildAt(k - 1).height);
							}
							
						}else 
						{
							mcRadius.x = QUESTION_BULLET_POS_LEFT;
							mcRadius.y = QUESTION_BULLET_POS_TOP;			
						}
						
						if (dataXML.questions.question[i].answers.answer[k].@correct != undefined)
						{
							mcQ.correctAnswer++;
							mcRadius.attrExists = true;
						}
						
						mcQ.mcDropDown.Bg.height = mcQ.mcDropDown.mcOut.height = mcQ.mcDropDown.CurrSel.height = 
						Math.round(2 * QUESTION_BULLET_POS_TOP + mcQ.mcDropDown.mcBulletHld.height);
						
						mcRadius.goListen();
						
						mcRadius.visible = true;
						mcRadius.alpha = 1;
					}
						mcQ.removeMc("RADIUS");
						
						mcQ.mcDropDown.mcBulletHld.visible = true;
						mcQ.mcDropDown.mcBulletHld.alpha = 1;
				break;
			}
			
			//set the mcDropDown menu x and y, also alpha and visibility
			mcQ.mcDropDown.x = QUESTION_DROP_DOWN_PAD_LEFT;
			mcQ.mcDropDown.y = mcQ.O.height - QUESTION_DROP_DOWN_PAD_TOP;
			
			if (pType)
			{
				mcQ.mcDropDown.visible = true;
				mcQ.mcDropDown.alpha = 1;
			}
			
			//set X and Y for mcQuestion MovieClip
			setX = QUESTION_POS_X;
			
			if (i>=1)
			{
				setY += (pType)? Math.round(QUESTION_POS_Y + Question(mcH.getChildAt(i - 1)).height) :
				Math.round(QUESTION_POS_Y + Question(mcH.getChildAt(i - 1)).O.height);
			}
			
			//show mcQuestion MovieClip
			mcQ.visible = true;
			
			if (i < qLength-1)
			{
				Tweener.addTween(mcQ, { alpha:1, x: setX, y: setY, time: 0.5, transition: "easeoutquad" } );
			}else 
			{
				Tweener.addTween(mcQ, { alpha:1, x: setX, y: setY, time: 0.5, transition: "easeoutquad", onComplete: function ():void 
				{
					if (pType)
					{
						compHolderH = setY + mcQ.height + QUESTION_POS_Y;
						testScrollBar("Q_EXPANDED");
					}else 
					{
						compHolderH = setY + mcQ.O.height + QUESTION_POS_Y;
						testScrollBar("Q_NORMAL");
					}
					
					if (settings.generalTime)
					{
							mcBody.mcOk.addEventListener(MouseEvent.ROLL_OVER, mcOk_RollOverHandler, false, 0, true);
							mcBody.mcOk.addEventListener(MouseEvent.CLICK, mcOk_ClickHandler, false, 0, true);
							mcBody.mcOk.addEventListener(MouseEvent.ROLL_OUT, mcOk_RollOutHandler, false, 0, true);
							
							if (!mcBody.mcOk.buttonMode)
							{
								mcBody.mcOk.mcTxt.txt.htmlText = settings.okBtn;
								mcBody.mcOk.O.width = mcBody.mcOk.N.width = Math.round(2 * BODY_OK_BTN_PAD_X + mcBody.mcOk.mcTxt.width);
								mcBody.mcOk.O.height = mcBody.mcOk.N.height = Math.round(2 * BODY_OK_BTN_PAD_Y + mcBody.mcOk.mcTxt.height);
								
								mcBody.mcOk.mcTxt.x = Math.floor(mcBody.mcOk.N.width / 2 - mcBody.mcOk.mcTxt.width / 2);
								mcBody.mcOk.mcTxt.y = Math.ceil(mcBody.mcOk.N.height / 2 - mcBody.mcOk.mcTxt.height / 2);
								
								mcBody.mcOk.x = Math.round(mcBody.Bg.width - (mcBody.mcOk.O.width + BODY_OK_BTN_POS_X));
								mcBody.mcOk.y = BODY_OK_BTN_POS_Y;
							}
							
							mcBody.mcOk.buttonMode = true;
							mcBody.mcOk.mouseChildren = false;
							mcBody.mcOk.mouseEnabled = true;
							mcBody.mcOk.visible = true;
							Tweener.addTween(mcBody.mcOk, { alpha:1 , time: 0.3, transition: "easeoutquad" } );
							
						mcBody.mcTxt.txt.htmlText = settings.remainingTime;
						qIndex = 0;
						startGeneralTimer();
						
					}else 
					{
						mcBody.mcTxt.txt.htmlText = settings.remainingTime;
						qIndex = 0;
						if (settings.timer)
						{
							goNext();
						}
					}
					
				} } );
			}
		}
		//} endregion
		
		//{ region TOGGLE ROTATION
		private final function toggleRotation(e: Number, pType : String):void
		{
			switch (pType)
			{
				case "PRV TIME":
					var qHeight : Number = Question(mcH.getChildAt(e)).mcDropDown.Bg.height;
					Question(mcH.getChildAt(e)).mcDropDown.height = 0;
					var qCloseHeight : Number = 0;
					toggleMcQ(e, qHeight, qCloseHeight);	
				break;
				
				case "GEN TIME":
					if (!hideAllQFlag && !settings.autoClose)
					{
						if (pQind != -1 && pQind != e)
						{
							Tweener.addTween(Question(mcH.getChildAt(pQind)).Sel, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
							{
								Question(mcH.getChildAt(pQind)).Sel.visible = false;
							} } );
						}
						
						if (e != pQind)
						{
							Question(mcH.getChildAt(e)).Sel.visible = true;
							Tweener.addTween(Question(mcH.getChildAt(e)).Sel, { alpha:1 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
							{
								pQind = e;
							} } );
						}
					}
					
					var qHeightG : Number = Question(mcH.getChildAt(e)).mcDropDown.Bg.height;
					Question(mcH.getChildAt(e)).mcDropDown.height = 0;
					var qCloseHeightG : Number = 0;
					var oldE : Number = -1;
					toggleMcQ(e, qHeightG, qCloseHeightG);
				break;
			}
		}
		//} endregion
		
		//{ region TOGGLE MC Q
		private final function toggleMcQ(e : Number, qHeight : Number, qCloseHeight : Number):void
		{
			if (Question(mcH.getChildAt(e)).pWas)
			{
				Question(mcH.getChildAt(e)).pWas = false;
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcTr, { rotation: -90 , time: 0.3, transition: "easeoutquad" } );
				Question(mcH.getChildAt(e)).mcDropDown.visible = true;
				Question(mcH.getChildAt(e)).mcDropDown.alpha = 1;
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcDropDown, { alpha:1, height: qHeight, time: .3, transition: "easeoutquad", onUpdate: function ():void 
				{
					for (var i:int = e+1; i < qLength; ++i)
					{
						Question(mcH.getChildAt(i)).setY(Question(mcH.getChildAt(i - 1)), true, QUESTION_POS_Y, QUESTION_DROP_DOWN_PAD_TOP);
					}
					
					testScrollBar("UPDATE_SIZE");
				} } );
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcTr, { alpha: 0, time: 0.5, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(e)).mcTr.visible = false;
				} } );
				
				
				Question(mcH.getChildAt(e)).mcOk.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(e)).mcOk, { alpha: 1, time: 0.3, transition: "easeoutquad" } );
				
				Question(mcH.getChildAt(e)).mcDown.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(e)).mcDown, { alpha:1 , time: 0.5, transition: "easeoutquad" });
				
			}else 
			{
				Question(mcH.getChildAt(e)).pWas = true;
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcOk, { alpha:0 , time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(e)).mcOk.visible = false;
				} } );
				
				Question(mcH.getChildAt(e)).mcTr.visible = true;
				Tweener.addTween(Question(mcH.getChildAt(e)).mcTr, { alpha:1 , time: 0.3, transition: "easeoutquad" } );
				Tweener.addTween(Question(mcH.getChildAt(e)).mcTr, { rotation: 0, time: 0.5, transition: "easeoutquad" } );
				
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcDown, { alpha:0 , time: 0.5, transition: "easeoutquad", onComplete: function ():void 
				{
					Question(mcH.getChildAt(e)).mcDown.visible = false;
				} });
				
				Tweener.addTween(Question(mcH.getChildAt(e)).mcDropDown, { alpha:0, height: qCloseHeight, time: .3, transition: "easeoutquad", onUpdate: function ():void 
				{
					for (var i:int = e+1; i < qLength; ++i)
					{
						Question(mcH.getChildAt(i)).setY(Question(mcH.getChildAt(i - 1)), false, QUESTION_POS_Y, QUESTION_DROP_DOWN_PAD_TOP);
					}
					
					if (e == qLength-1 && Question(mcH.getChildAt(qLength-1)).mcDropDown.visible)
					{
						testScrollBar("UPDATE_SIZE", true);
					}else 
					{
						testScrollBar("UPDATE_SIZE");
					}
					
				}, onComplete: function ():void 
				{
					Question(mcH.getChildAt(e)).mcDropDown.visible = false;
				}});
				
				Question(mcH.getChildAt(e)).mcDropDown.height = qHeight;
			}
		}
		//} endregion
		
		//{ region CHECK RESULT
		private final function checkResult(pInd : uint, pGt : Boolean = false):void
		{
			if (pInd == qLength-1 && !pGt)
			{
				showResult();
			}
		}
		//} endregion
		
		//{ region SEND XML TO PHP
		private final function sendXMLtoPHP(pXML : XML):void
		{
			phpURL = new URLRequest(settings.phpPath);
			phpURL.method = URLRequestMethod.POST;
			//phpURL.contentType = "text/html";
			phpVar = new URLVariables();
			phpVar.xml_data = pXML;
			
			phpURL.data = phpVar;
			
			phpLoader = new URLLoader(phpURL);
			phpLoader.addEventListener(Event.COMPLETE, phpLoader_CompleteHandler, false, 0, true);
			phpLoader.addEventListener(IOErrorEvent.IO_ERROR, phpLoader_IoErrorHandler, false, 0, true);
			phpLoader.dataFormat = URLLoaderDataFormat.TEXT;
			phpLoader.load(phpURL);
		}
		//} endregion
		
		//{ region INTRO PAGE
		private final function introPage():void
		{
			if (settings.introPage) 
			{
				showFirstPage(true);
				
			}else 
			{
				mcStartPage_ClickHandler();
			}
		}
		//} endregion
		
		//{ region GENERATE ANSWERS
		private final function generateAnswers():void
		{
			//var answerString : String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <answers>\n\n";
			
			for (var i:int = 0; i < qLength; i++)
			{
				var mcAnswer : Question = new Question();
				//answerString += "\t<answer> \n";
				mcAnswer.mode("answer");
				
				//formatting the mcAnswer
				mcAnswer.mcNr.txt.htmlText = "<b>" + String(i + 1) + "." + "</b>";
				mcAnswer.mcTxt.txt.htmlText = dataXML.questions.question[i].questionText;
				//answerString += "\t\t<question>" + mcAnswer.mcTxt.txt.text + "</question>\n";
				
				mcAnswer.O.width = mcBody.mcMask.width;
				mcAnswer.O.x = ANSWER_O_POS_X;
				mcAnswer.O.y = ANSWER_O_POS_Y;
				
				mcAnswer.mcNr.x = ANSWER_NR_PAD_LEFT;
				mcAnswer.mcNr.y = ANSWER_NR_PAD_TOP;
				
				mcAnswer.mcTxt.x = Math.round(mcAnswer.mcNr.x + mcAnswer.mcNr.width + ANSWER_TXT_PAD_LEFT);
				mcAnswer.mcTxt.y = ANSWER_TXT_PAD_TOP;
				mcAnswer.mcTxt.txt.width = Math.round(mcAnswer.O.width - (mcAnswer.mcTxt.x + ANSWER_TXT_PAD_RIGHT));
				
				mcAnswer.O.height = Math.round(mcAnswer.mcTxt.height + 2 * ANSWER_TXT_PAD_TOP);
				
				mcAnswer.x = 0;
				mcAnswer.y = 0;
				
				mcH.addChildAt(mcAnswer, i);
				
				mcAnswer.mcDropDown.Bg.width = mcBody.mcMask.width;
				
				mcAnswer.mcDropDown.x = ANSWER_DROP_DOWN_PAD_LEFT;
				mcAnswer.mcDropDown.y = mcAnswer.O.height - ANSWER_DROP_DOWN_PAD_TOP;
				
				switch (dataXML.questions.question[i].questionType.toLowerCase())
				{
					case "input":
						var mcInputYourAnswer : Answer  = new Answer();
						
						mcInputYourAnswer.mcLbl.txt.styleSheet = cssStyle;
						mcInputYourAnswer.mcTxt.txt.styleSheet = cssStyle;
						
						mcInputYourAnswer.mcLbl.txt.htmlText = settings.yourAnswerLbl;
						
						if (String(arrayBulletResult[i]) != "")
						{
							mcInputYourAnswer.mcTxt.txt.htmlText = "<p class = 'details'>" + StringUtil.squeeze(arrayBulletResult[i]) + "</p>";
						}else 
						{
							mcInputYourAnswer.mcTxt.txt.htmlText = settings.answerAllwrongInput;
						}
						
						mcAnswer.mcDropDown.addChild(mcInputYourAnswer);
						
						var mcInputCorrectAnswer : Answer = new Answer();
						
						mcInputCorrectAnswer.mcLbl.txt.styleSheet = cssStyle;
						mcInputCorrectAnswer.mcTxt.txt.styleSheet = cssStyle;
						
						mcInputCorrectAnswer.mcLbl.txt.htmlText = settings.correctAnswerLbl;
						mcInputCorrectAnswer.mcTxt.txt.htmlText = "<p class = 'details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer)) + "</p>";
						
						mcAnswer.mcDropDown.addChild(mcInputCorrectAnswer);
						
						var mcInputScore : Answer = new Answer();
						
						mcInputScore.mcLbl.txt.styleSheet = cssStyle;
						mcInputScore.mcTxt.txt.styleSheet = cssStyle;
						
						mcInputScore.mcLbl.txt.htmlText = settings.scoreLbl;
						mcInputScore.mcTxt.txt.htmlText = "<p class = 'details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].score)) + "</p>";
						
						mcAnswer.mcDropDown.addChild(mcInputScore);
						
						arrangeAnswers(mcInputCorrectAnswer, mcInputYourAnswer, mcInputScore, mcAnswer.mcDropDown.Bg.width);
						
						//answerString += "\t\t<correctAnswer>" + mcInputCorrectAnswer.mcTxt.txt.text  + "</correctAnswer>\n" +
						//"\t\t<yourAnswer>" + mcInputYourAnswer.mcTxt.txt.text + "</yourAnswer>\n" + "\t\t<score>" + mcInputScore.mcTxt.txt.text + "</score>\n";
						
						mcAnswer.mcDropDown.Bg.height = Math.round(mcInputScore.y + mcInputScore.height + ANSWER_ANSW_POS_Y);
					break;
					
					default:
						var aLength : uint = dataXML.questions.question[i].answers.answer.length();
						var arrayCounter : uint = 0;
						var answerCounter : uint = 0;
						var noneAnswer : uint = 0;
						var uncheckedButtons : uint = 0;
						var mcCorrectAnswerAttrbF : Boolean = true;
						var mcYourAnswerCheckedF : Boolean = true;
						
						for (var j:int = 0; j < aLength; j++)
						{
							//with attributes
							if (dataXML.questions.question[i].answers.answer[j].@correct != undefined)
							{
								if (mcCorrectAnswerAttrbF)
								{
									mcCorrectAnswerAttrbF = false;
									var mcCorrectAnswerAttrb : Answer = new Answer();
									
									mcCorrectAnswerAttrb.mcTxt.txt.styleSheet = cssStyle;
									mcCorrectAnswerAttrb.mcLbl.txt.styleSheet = cssStyle;
									
									mcCorrectAnswerAttrb.mcLbl.txt.htmlText = settings.correctAnswerLbl;
									mcCorrectAnswerAttrb.mcTxt.txt.htmlText = "<p class ='details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j])) + "</p>";
									
									mcAnswer.mcDropDown.addChild(mcCorrectAnswerAttrb);
								}else 
								{
									mcCorrectAnswerAttrb.mcTxt.txt.htmlText += settings.answerSeparator + "<p class='details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j])) + "</p>";
								}
								answerCounter++;
								
							}else//without attributes
							{
								noneAnswer++;
								if (noneAnswer == aLength)
								{
									var mcCorrectAnswer : Answer = new Answer();
									
									mcCorrectAnswer.mcLbl.txt.styleSheet = cssStyle;
									mcCorrectAnswer.mcTxt.txt.styleSheet = cssStyle;
									
									mcCorrectAnswer.mcLbl.txt.htmlText = settings.correctAnswerLbl;
									mcCorrectAnswer.mcTxt.txt.htmlText = settings.allAreWrong;
									
									mcAnswer.mcDropDown.addChild(mcCorrectAnswer);
								}
							}
							
							//checked
							if (!arrayBulletResult[i][j])//checked buttons
							{
								if (mcYourAnswerCheckedF)
								{
									mcYourAnswerCheckedF = false;
									var mcYourAnswerChecked : Answer = new Answer();
									
									mcYourAnswerChecked.mcLbl.txt.styleSheet = cssStyle;
									mcYourAnswerChecked.mcTxt.txt.styleSheet = cssStyle;
									
									mcYourAnswerChecked.mcLbl.txt.htmlText = settings.yourAnswerLbl;
									mcYourAnswerChecked.mcTxt.txt.htmlText = "<p class='details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j])) + "</p>";
									
									mcAnswer.mcDropDown.addChild(mcYourAnswerChecked);
									
								}else 
								{
									mcYourAnswerChecked.mcTxt.txt.htmlText += settings.answerSeparator + "<p class='details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j])) + "</p>";
								}
								arrayCounter++;
							}
							
							//unchecked
							if (arrayBulletResult[i][j])//unchecked buttons
							{
								uncheckedButtons++;
							}
							
							if (uncheckedButtons == aLength)
							{
								var mcYourAnswer : Answer = new Answer();
								
								mcYourAnswer.mcLbl.txt.styleSheet = cssStyle;
								mcYourAnswer.mcTxt.txt.styleSheet = cssStyle;
								
								mcYourAnswer.mcLbl.txt.htmlText = settings.yourAnswerLbl;
								mcYourAnswer.mcTxt.txt.htmlText = settings.answerAllAreWrong;
								
								mcAnswer.mcDropDown.addChild(mcYourAnswer);
							}
						}
						
						var mcScore : Answer = new Answer();
						
						mcScore.mcLbl.txt.styleSheet = cssStyle;
						mcScore.mcTxt.txt.styleSheet = cssStyle;
						
						mcScore.mcLbl.txt.htmlText = settings.scoreLbl;
						mcScore.mcTxt.txt.htmlText = "<p class='details'>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].score)) + "</p>";
						mcAnswer.mcDropDown.addChild(mcScore);
						
						//generate and arrange the answers
						if (!mcCorrectAnswerAttrbF)
						{
							if (!mcYourAnswerCheckedF)
							{
								arrangeAnswers(mcCorrectAnswerAttrb, mcYourAnswerChecked, mcScore, mcAnswer.mcDropDown.Bg.width);
								//answerString += "\t\t<correctAnswer>" + mcCorrectAnswerAttrb.mcTxt.txt.text  + "</correctAnswer>\n" +
								//"\t\t<yourAnswer>" + mcYourAnswerChecked.mcTxt.txt.text + "</yourAnswer>\n" + "\t\t<score>" + mcScore.mcTxt.txt.text + "</score>\n";
							}else 
							{
								arrangeAnswers(mcCorrectAnswerAttrb, mcYourAnswer, mcScore, mcAnswer.mcDropDown.Bg.width);
								//answerString += "\t\t<correctAnswer>" + mcCorrectAnswerAttrb.mcTxt.txt.text  + "</correctAnswer>\n" +
								//"\t\t<yourAnswer>" + mcYourAnswer.mcTxt.txt.text + "</yourAnswer>\n" + "\t\t<score>" + mcScore.mcTxt.txt.text + "</score>\n";
							}
						}else 
						{
							if (!mcYourAnswerCheckedF) 
							{
								arrangeAnswers(mcCorrectAnswer, mcYourAnswerChecked, mcScore, mcAnswer.mcDropDown.Bg.width);
								//answerString += "\t\t<correctAnswer>" + mcCorrectAnswer.mcTxt.txt.text  + "</correctAnswer>\n" +
								//"\t\t<yourAnswer>" + mcYourAnswerChecked.mcTxt.txt.text + "</yourAnswer>\n" + "\t\t<score>" + mcScore.mcTxt.txt.text + "</score>\n";
							}else 
							{
								arrangeAnswers(mcCorrectAnswer, mcYourAnswer, mcScore, mcAnswer.mcDropDown.Bg.width);
								//answerString += "\t\t<correctAnswer>" + mcCorrectAnswer.mcTxt.txt.text  + "</correctAnswer>\n" +
								//"\t\t<yourAnswer>" + mcYourAnswer.mcTxt.txt.text + "</yourAnswer>\n" + "\t\t<score>" + mcScore.mcTxt.txt.text + "</score>\n";
							}
						}
						
						mcAnswer.mcDropDown.Bg.height = Math.round(mcScore.y + mcScore.height + ANSWER_ANSW_POS_Y);
					break;
				}
				
				//answerString += "\t</answer>\n\n";
				
				mcAnswer.mcDropDown.visible = true;
				mcAnswer.mcDropDown.alpha = 1;
				
				//set the X and Y for mcAnswer
				setAx = ANSWER_POS_X;
				
				if (i>=1)
				{
					setAy += Math.round(ANSWER_POS_Y + Question(mcH.getChildAt(i - 1)).height);
				}
				
				//show mcAnswer
				mcAnswer.visible = true;
				
				if (i < qLength-1)
				{
					Tweener.addTween(mcAnswer, { alpha:1, x: setAx, y: setAy, time: 0.5, transition: "easeoutquad" } );
				}else 
				{
					Tweener.addTween(mcAnswer, { alpha:1, x: setAx, y: setAy, time: 0.5, transition: "easeoutquad", onComplete: function ():void 
					{
						compAnswerHolderH = setAy + mcAnswer.height + ANSWER_POS_Y;
						
						testScrollBar("ANSWER");
					} } );
				}
			}
			
			//answerString += "</answers>";
			//var answerXML : XML = new XML(answerString);
			
			if (xmlTOphp && settings.sendDataToPhp)
			{
				xmlTOphp = false;
				//sendXMLtoPHP(answerXML);
				generateReport();
			}
		}
		//} endregion
		
		//{ region GENERATE REPORT
		private final function generateReport():void
		{
			var answerString : String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n <answers>\n\n";
			
			for (var i:int = 0; i < qLength; i++)
			{
				answerString += "\t<answer> \n";
				answerString += "\t\t<question>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].questionText)) + "</question>\n";
				
				switch (dataXML.questions.question[i].questionType.toLowerCase())
				{
					case "input":
						var mcInputYourAnswer : Answer  = new Answer();
						var yourAnswer : String = "";
						
						if (String(arrayBulletResult[i]) != "")
						{
							yourAnswer = StringUtil.stripHTML(StringUtil.squeeze(arrayBulletResult[i]));
						}else 
						{
							yourAnswer = StringUtil.stripHTML(StringUtil.squeeze(settings.answerAllwrongInput));
						}
						
						answerString += "\t\t<correctAnswer>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer))  + "</correctAnswer>\n" +
						"\t\t<yourAnswer>" + yourAnswer + "</yourAnswer>\n" + "\t\t<score>" + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].score)) + "</score>\n";
					break;
					
					default:
						var aLength : uint = dataXML.questions.question[i].answers.answer.length();
						var arrayCounter : uint = 0;
						var answerCounter : uint = 0;
						var noneAnswer : uint = 0;
						var uncheckedButtons : uint = 0;
						var mcCorrectAnswerAttrbF : Boolean = true;
						var mcYourAnswerCheckedF : Boolean = true;
						
						for (var j:int = 0; j < aLength; j++)
						{
							//with attributes
							if (dataXML.questions.question[i].answers.answer[j].@correct != undefined)
							{
								if (mcCorrectAnswerAttrbF)
								{
									mcCorrectAnswerAttrbF = false;
									var mcCorrectAnswerAttrb : String = StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j]));
								}else 
								{
									mcCorrectAnswerAttrb += StringUtil.stripHTML(settings.answerSeparator) + StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j]));
								}
								answerCounter++;
								
							}else//without attributes
							{
								noneAnswer++;
								if (noneAnswer == aLength)
								{
									var mcCorrectAnswer : String = StringUtil.stripHTML(settings.allAreWrong);
								}
							}
							
							//checked
							if (!arrayBulletResult[i][j])//checked buttons
							{
								if (mcYourAnswerCheckedF)
								{
									mcYourAnswerCheckedF = false;
									var mcYourAnswerChecked : String = StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j]));
								}else 
								{
									mcYourAnswerChecked += StringUtil.stripHTML(settings.answerSeparator) +  StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].answers.answer[j]));
								}
								arrayCounter++;
							}
							
							//unchecked
							if (arrayBulletResult[i][j])//unchecked buttons
							{
								uncheckedButtons++;
							}
							
							if (uncheckedButtons == aLength)
							{
								var mcYourAnswer : String = StringUtil.stripHTML(settings.answerAllAreWrong);
							}
						}
						
						var mcScore : String = StringUtil.stripHTML(StringUtil.squeeze(dataXML.questions.question[i].score));
						
						//generate and arrange the answers
						if (!mcCorrectAnswerAttrbF)
						{
							if (!mcYourAnswerCheckedF)
							{
								answerString += "\t\t<correctAnswer>" + mcCorrectAnswerAttrb + "</correctAnswer>\n" +
								"\t\t<yourAnswer>" + mcYourAnswerChecked + "</yourAnswer>\n" + "\t\t<score>" + mcScore + "</score>\n";
							}else 
							{
								answerString += "\t\t<correctAnswer>" + mcCorrectAnswerAttrb + "</correctAnswer>\n" +
								"\t\t<yourAnswer>" + mcYourAnswer + "</yourAnswer>\n" + "\t\t<score>" + mcScore + "</score>\n";
							}
						}else 
						{
							if (!mcYourAnswerCheckedF) 
							{
								answerString += "\t\t<correctAnswer>" + mcCorrectAnswer + "</correctAnswer>\n" +
								"\t\t<yourAnswer>" + mcYourAnswerChecked + "</yourAnswer>\n" + "\t\t<score>" + mcScore + "</score>\n";
							}else 
							{
								answerString += "\t\t<correctAnswer>" + mcCorrectAnswer + "</correctAnswer>\n" +
								"\t\t<yourAnswer>" + mcYourAnswer + "</yourAnswer>\n" + "\t\t<score>" + mcScore + "</score>\n";
							}
						}
					break;
				}
				
				answerString += "\t</answer>\n\n";
			}
			
			answerString += "</answers>";
			
			var answerXML : XML = new XML(answerString);
			sendXMLtoPHP(answerXML);
		}
		//} endregion
		
		//} endregion
	}
}