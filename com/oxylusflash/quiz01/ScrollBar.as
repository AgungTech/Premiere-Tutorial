package com.oxylusflash.quiz01
{
	//{ region IMPORT CLASSES
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;
	//} endregion
	/**
	 * ...
	 * @author Ciprian Chichirita
	 */
	public class ScrollBar extends MovieClip
	{
		//{ region FIELDS
		public var mcTrack : MovieClip;
		public var mcBtn : MovieClip;
		
		public var mcBtnY : Number;
		public static const DRAG : String = "drag";
		
		private var _prop : Number;
		private var _perc : Number;
		private var dY : Number;
		private var doOutAnim : Boolean = true;
		private var imOver : Boolean = false;
		private var _scrollBarSignal : Signal;
		private var _scrollbarMinSize : Number = 0;
		private var _updateBtn : Boolean = false;
		private var _btnSize : Number = 0;
		//} endregion
		
		//{ region CONSTRUCTOR
		public function ScrollBar()
		{
			_scrollBarSignal = new Signal(String, Number);
			this.hitArea = mcTrack;
			this.buttonMode = true;
			
			this.visible = false;
			this.alpha = 0;
			
			mcBtn.O.visible = false;
			mcBtn.O.alpha = 0;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
		}
		//} endregion
		
		//{ region EVENT HANDLERS///////////////////////////////////////////
		
		//{ region MOUSE DOWN HANDLER
		private final function mouseDownHandler(e:MouseEvent):void 
		{
			doOutAnim = false;
			dY = mcBtn.hitTestPoint(stage.mouseX, stage.mouseY)? this.mouseY - mcBtn.y : Math.round(mcBtn.O.height / 2);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
			
			moveMcBtn();
		}
		//} endregion
		
		//{ region ROLL OVER HANDLER
		private final function rollOverHandler(e:MouseEvent):void 
		{
			imOver = true;
			
			mcBtn.O.visible = true;
			Tweener.addTween(mcBtn.O, { alpha:1, time: 0.3, transition: "easeoutquad" });
		}
		//} endregion
		
		//{ region ROLL OUT HANDLER
		private final function rollOutHandler(e:MouseEvent):void 
		{
			imOver = false;
			outAnim();
		}
		//} endregion
		
		//{ region STAGE MOUSE MOVE HANDLER
		private final function stage_mouseMoveHandler(e:MouseEvent):void 
		{
			doOutAnim = false;
			moveMcBtn();
		}
		//} endregion
		
		//{ region STAGE MOUSE UP HANDLER
		private final function stage_mouseUpHandler(e:MouseEvent):void 
		{
			doOutAnim = true;
			if (!imOver) 
			{
				outAnim();
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}
		//} endregion
		
		//} endregion
		
		//{ region METHODS/////////////////////////////////////////////////
		
		//{ region MOVE MC BTN
		private final function moveMcBtn():void
		{
			updateMcBtn(this.mouseY - dY);
		}
		//} endregion
		
		//{ region UPDATE MC BTN
		internal final function updateMcBtn(yPos : Number):void
		{
			yPos = Math.max(0, Math.min(mcTrack.height - mcBtn.O.height, yPos));
			
			if (mcBtnY != yPos) 
			{
				mcBtnY = yPos;
				
				mcBtn.y = mcBtnY;
				
				_perc = mcBtnY / (mcTrack.height - mcBtn.O.height);
				_scrollBarSignal.dispatch(DRAG, mcBtnY);
			}
		}
		//} endregion
		
		//{ region OUT ANIM
		private final function outAnim():void
		{
			if (doOutAnim) 
			{
				Tweener.addTween(mcBtn.O, { alpha:0, time: 0.3, transition: "easeoutquad", onComplete: function ():void 
				{
					mcBtn.O.visible = false;
				} });
			}
		}
		//} endregion
		
		//} endregion
		
		//{ region PROPERTIES
		public function get prop():Number { return _prop; }
		
		public function set prop(value:Number):void 
		{
			if (!_updateBtn)
			{
				_prop = value;
				mcBtn.O.height = mcBtn.N.height = Math.round(mcTrack.height * _prop);
				mcBtn.O.height = mcBtn.N.height = (_scrollbarMinSize < mcBtn.N.height)? Math.round(mcTrack.height * _prop) : _scrollbarMinSize;
				
				_perc = 0;
				mcBtn.y = 0;
			}else 
			{
				_prop = value;
				btnSize = Math.round(mcTrack.height * _prop);
				btnSize = (_scrollbarMinSize < btnSize)? Math.round(mcTrack.height * _prop) : _scrollbarMinSize;
				mcBtn.O.height = mcBtn.N.height = btnSize;
			}
		}
		
		public function get perc():Number { return _perc; }
		
		public function set perc(value:Number):void 
		{
			_perc = value;
		}
		
		public function get scrollBarSignal():Signal { return _scrollBarSignal; }
		
		public function get scrollbarMinSize():Number { return _scrollbarMinSize; }
		
		public function set scrollbarMinSize(value:Number):void 
		{
			_scrollbarMinSize = value;
		}
		
		internal function get updateBtn():Boolean { return _updateBtn; }
		
		internal function set updateBtn(value:Boolean):void 
		{
			_updateBtn = value;
		}
		
		internal function get btnSize():Number { return _btnSize; }
		
		internal function set btnSize(value:Number):void 
		{
			_btnSize = value;
		}
		//} endregion
	}
	
}