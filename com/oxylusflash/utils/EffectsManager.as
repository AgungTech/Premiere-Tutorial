//=============================================================================
//
//  EFFECTS MANAGER CLASS (AS3)
//  Copyright(c)2009 www.OXYLUSFlash.com
//  Author: Adrian Bota, adrian@oxylus.ro
//  Last update: 11/01/09 (mm/dd/yy)
//
//  Methods:
//      reset() - resets the DisplayObject to its original appeareance
//
//  Properties:
//      blur        - (Number) blur amount; affects both blurX and blurY
//      blurQuality - (Number) blur quality
//      blurX       - (Number) blurX amount
//      blurY       - (Number) blurY amount
//      colorFill   - (uint) fills the DisplayObject with a solid color
//                    if this is set, you CANNOT use saturation and brightness
//      brightness  - (Number) values between [-1, 1], 0 - original
//      saturation  - (Number) values between [0, 2], 1 - original
//
//  Usage:
//      import com.oxylusflash.utils.EffectsManager;
//      var em:EffectsManager = new EffectsManager(target_mc);
//      em.saturation = 0.5;
//      em.brightness = 1;
//      em.blurX      = 16;
//      ...
//
//=============================================================================

package com.oxylusflash.utils 
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.ColorTransform;
    
    public class EffectsManager 
	{
        // PRIVATE VARS
        private var blurFilter:BlurFilter;
        private var saturationFilter:ColorMatrixFilter;
        private var brightnessFilter:ColorMatrixFilter;
        
        private var _blurX:Number       = 0;
        private var _blurY:Number       = 0;
        private var _blurQuality:Number = 3;
        private var _saturation:Number  = 1;
        private var _brightness:Number  = 0;
        private var _colorFill:uint     = 0;
        
        private var colorFillFlag:Boolean;
        private var filtersFlag:Boolean;
        
        private var _target:DisplayObject;
        
        // CONSTRUCTOR
        /* Set the target DisplayObject on which the effects will be applied. */
        public function EffectsManager(target:DisplayObject = null):void {
            if (target) this.target = target;
        }
        
        // PUBLIC METHODS
        /* Reset target DisplayObject to its original appearence. */
        public function reset():void {
            this.blur       = 0;
            this.saturation = 1;
            this.brightness = 0;
            _colorFill      = 0;
            _target.transform.colorTransform = new ColorTransform();
        }
        
        // PROPERTIES
        /* Target DisplayObject on which the effects will be applied. */
        public function get target():DisplayObject {
            return _target;
        }
        public function set target(value:DisplayObject):void {
            _target         = value;
            _target.filters = [];
            _target.addEventListener(Event.REMOVED_FROM_STAGE, clearTargetRef, false, 0, true);
            
            if (colorFillFlag) applyColorFill();
            if (filtersFlag)   applyFilters();            
        }
        /* DisplayObject blur amount. Affects both blurX and blurY values. */
        public function get blur():Number {
            return Math.max(_blurX, _blurY);
        }
        public function set blur(value:Number):void {
            _blurX = value;
            _blurY = value;
            updateBlur();
        }
        /* Display object blurX. */
        public function get blurX():Number {
            return _blurX;
        }
        public function set blurX(value:Number):void {
            _blurX = value;
            updateBlur();
        }
        /* Display object blurY. */
        public function get blurY():Number {
            return _blurY;
        }
        public function set blurY(value:Number):void {
            _blurY = value;
            updateBlur();
        }
        /* Display object blur quality. */
        public function get blurQuality():Number {
            return _blurQuality;
        }
        public function set blurQuality(value:Number):void {
            _blurQuality = value;
            updateBlur();
        }
        /* Saturation values are between [0, 2], 1 is for the original saturation. */
        public function get saturation():Number {
            return _saturation;
        }
        public function set saturation(value:Number):void {
            _saturation = value;
            updateSaturation();
        }
        /* Brightness values are between [-1, 1], 0 is for the original brightness. */
        public function get brightness():Number {
            return _brightness;
        }
        public function set brightness(value:Number):void {
            _brightness = value;
            updateBrightness();
        }
        /* Fills the DisplayObject with the given color. 
         * You cannot use saturation and brightness if you set the colorFill property. */
        public function get colorFill():uint {
            return _colorFill;
        }
        
        // PRIVATE METHODS
        public function set colorFill(value:uint):void {
            _colorFill = value;
            applyColorFill();
        }       
        private function updateBlur():void {
            if (_blurX == 0 && _blurY == 0) {
                if (blurFilter)
                    blurFilter = null;
            } else {
                if (!blurFilter) {
                    blurFilter = new BlurFilter(_blurX, _blurY, _blurQuality); 
                } else {
                    blurFilter.blurX   = _blurX;
                    blurFilter.blurY   = _blurY;
                    blurFilter.quality = _blurQuality;
                }
            }
            
            applyFilters();
        }
        private function updateSaturation():void {
            if (_saturation == 1) {
                if (saturationFilter)
                    saturationFilter = null;
            } else {
                var s:Number     = _saturation;
                var a:Number     = (1 - s) * 0.3086;
                var b:Number     = (1 - s) * 0.6094;
                var c:Number     = (1 - s) * 0.0820;                
                var matrix:Array = [a + s, b, c, 0, 0, a, b + s, c, 0, 0, a, b, c + s, 0, 0, 0, 0, 0, 1, 0];
                
                if (!saturationFilter) {
                    saturationFilter = new ColorMatrixFilter(matrix);
                } else {
                    saturationFilter.matrix = matrix;
                }
            }
            
            applyFilters();
        }
        private function updateBrightness():void {
            if (_brightness == 0) {
                if (brightnessFilter)
                    brightnessFilter = null;
            } else {
                var b:Number     = Math.round(_brightness * 127.5);
                var matrix:Array = [1, 0, 0, 0, b, 0, 1, 0, 0, b, 0, 0, 1, 0, b, 0, 0, 0, 1, 0];
                
                if (!brightnessFilter) {
                    brightnessFilter = new ColorMatrixFilter(matrix);
                } else {
                    brightnessFilter.matrix = matrix;
                }
            }
            
            applyFilters();
        }        
        private function applyFilters():void {
            if (_target) {            
                var filters:Array  = [];
                if (blurFilter)       filters.push(blurFilter);
                if (saturationFilter) filters.push(saturationFilter);
                if (brightnessFilter) filters.push(brightnessFilter);
                
                _target.filters = filters;
                filtersFlag = true;
            }
        }
        private function applyColorFill():void 
        {
            if (_target) {
                var ct:ColorTransform = _target.transform.colorTransform;
                ct.color = _colorFill;
                _target.transform.colorTransform = ct;
                colorFillFlag = true;
            }
        }        
        private function clearTargetRef(event:Event):void {
            _target = null;
        }
    }
}