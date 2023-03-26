package
{
	import com.colorpicker.Constants;
	import com.colorpicker.SwatchDetailsHolder;
	import com.colorpicker.Utilities;
	import com.moviestarplanet.uploadutils.color.ColorSchemeUtils;
	import com.moviestarplanet.utils.ColorMap;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class ColorPickerInterface extends MovieClip
	{
		private var stage2:Stage = null;
		private var defaultColorsString:String = null;
		private var defaultColorsObject:Object = null;
		private var stageColorSwatch:MovieClip = null;
		private var isDefaultColorObject:Boolean;
		private var movieclip:MovieClip = null;
		private var currentPallet:String = "";
		//private var currentPalletItemBorder:Array = ["", 0, 0, ""];
		private var colorDetailsHolder:Array = new Array();
		private var swatchIndex:int = 0;
		public function ColorPickerInterface(param1:Stage, param2:MovieClip, param3:MovieClip, param4:*):void
		{
			stage2 = param1;
			movieclip = param2;
			stageColorSwatch = param3;
			if(typeof(param4) == "string") {
				defaultColorsString = param4;
				isDefaultColorObject = false;
			} else if(typeof(param4) == "object") {
				defaultColorsString = ColorSchemeUtils.getColorStringFromColorScheme(ColorMap.GetColorsFromColorSchemeString(ColorSchemeUtils.colorSchemeToString(param4)));
					
				defaultColorsObject = param4;
				isDefaultColorObject = true;
			} else {
				throw new Error("param3 has to be of type \"string\" or \"object\"");
			}
			
			setColorDetailsOnHolder();
			initColorSwatches();
			setOtherColorPallet("red");
			setTabColors();
			setColorsOnStageColorSwatch(defaultColorsString);
			
			this._btnOk.addEventListener(MouseEvent.CLICK, onOkButton);
			this._downRowSwatchedReset._btnReset.addEventListener(MouseEvent.CLICK, onResetButton);
		}
		
		private function setColorDetailsOnHolder() {
			var arr:Array = defaultColorsString.split(",");
			var count:int = 1;
			for each(var el:String in arr) {
				var sdh:SwatchDetailsHolder = new SwatchDetailsHolder(uint(el), 0, 0, 0, "", this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + count));
				colorDetailsHolder.push(sdh);
				count++;
			}
		}
		
		private function setOtherColorPallet(param1:String):void {
			//param1 = color pallet name
			var arr:Array = null;
			if(param1 == "red") {
				arr = Constants.colors_red;
			} else if(param1 == "yellow") {
				arr = Constants.colors_yellow;
			} else if(param1 == "green") {
				arr = Constants.colors_green;
			} else if(param1 == "blue") {
				arr = Constants.colors_blue;
			} else if(param1 == "pink") {
				arr = Constants.colors_pink;
			} else if(param1 == "brown") {
				arr = Constants.colors_brown;
			}
			drawSquares(arr);
			
			currentPallet = param1;

			if(this._colors.getChildByName("_selectedColorBorder") != null) {
				this._colors.removeChild(this._colors.getChildByName("_selectedColorBorder"));
			}
			
			if(colorDetailsHolder[swatchIndex-1].pallet == param1 && currentPallet == param1) {
				var square:MovieClip = new MovieClip();
				square.graphics.lineStyle(4, 0xFFFFFF, 1.0);
				square.graphics.beginFill(0x000000, 0);
				square.graphics.drawRect(colorDetailsHolder[swatchIndex-1].border_x, colorDetailsHolder[swatchIndex-1].border_y, 44.5, 44.65);
				square.graphics.endFill();
				square.name = "_selectedColorBorder";
				this._colors.addChild(square);
			}
			if(colorDetailsHolder[swatchIndex-1].pallet == param1) {
				
			}
			
			var total:int = Math.ceil(arr.length / 6);
			this._downRowSwatchedReset.y = (total*44.65)+36.5;
		}
		
		private function setTabColors():void {
			var count:int = 1;
			for each(var el:String in Constants.colors_tabs) {
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = uint(el);
				this._swatches.getChildByName("_tab"+count).transform.colorTransform = colorTransform;
				this._swatches.getChildByName("_tab"+count).addEventListener(MouseEvent.CLICK, tabClicked);
				count++;
			}
		}
		
		private function colorItemClicked(t:ColorPickerInterface, count_x:int, count_y:int, ccode:String): Function {
			return function(e:MouseEvent):void {
				if(t._colors.getChildByName("_selectedColorBorder") != null) {
					t._colors.removeChild(t._colors.getChildByName("_selectedColorBorder"));
				}
				colorDetailsHolder[swatchIndex-1].pallet = currentPallet;
				colorDetailsHolder[swatchIndex-1].border_x = count_x;
				colorDetailsHolder[swatchIndex-1].border_y = count_y;
				var square:MovieClip = new MovieClip();
				square.graphics.lineStyle(4, 0xFFFFFF, 1.0);
				square.graphics.beginFill(0x000000, 0);
				square.graphics.drawRect(count_x, count_y, 44.5, 44.65);
				square.graphics.endFill();
				square.name = "_selectedColorBorder";
				t._colors.addChild(square);

				colorDetailsHolder[swatchIndex-1].selected_color = uint(ccode);
				
				setColorOnColorSlot(colorDetailsHolder[swatchIndex-1]);
			};
		}
		
		private function setColorOnColorSlot(param1:SwatchDetailsHolder):void {
			var mcolor:ColorTransform=new ColorTransform();
			mcolor.color = param1.selected_color;
			var s:MovieClip = param1.swatch;
			s.transform.colorTransform = mcolor;
		}
		
		private function tabClicked(e:MouseEvent):void {
			var s:String = "";
			if(e.currentTarget.name == "_tab1") {
				s = "red";
			} else if(e.currentTarget.name == "_tab2") {
				s = "yellow";
			} else if(e.currentTarget.name == "_tab3") {
				s = "green";
			} else if(e.currentTarget.name == "_tab4") {
				s = "blue";
			} else if(e.currentTarget.name == "_tab5") {
				s = "pink";
			} else if(e.currentTarget.name == "_tab6") {
				s = "brown";
			}
			if(s != "") {
				this.setOtherColorPallet(s);
			}
		}
		
		private function drawSquares(param1:Array) {
			var count_while:int = 1;
			while(this._colors.getChildByName("c" + count_while.toString()) != null) {
				this._colors.removeChild(this._colors.getChildByName("c" + count_while.toString()));
				count_while++;
			}
			
			var count_x:int = 0;
			var count_y:int = 0;
			var count:int = 1;
			for each(var el:String in param1) {
				
				var square:MovieClip = new MovieClip(); 
				square.graphics.beginFill(uint(el), 1); 
				square.graphics.drawRect(count_x, count_y, 44.5, 44.65);
				square.name = "c" + count.toString();

				square.addEventListener(MouseEvent.CLICK, colorItemClicked(this, count_x, count_y, el));
				
				square.buttonMode = true;
				this._colors.addChild(square);
				
				count_x += 44.5;
				var isWhole:Boolean = count % 6 == 0;
				if(isWhole == true) {
					count_x = 0;
					count_y += 44.65;
				}
				count++;
			}
		}
		
		private function initColorSwatches():void {
			var count:int = 1;
			var arr:Array = defaultColorsString.split(",");
			
			swatchIndex = 1;
			for each(var el:String in arr) {
				this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + count.toString()).addEventListener(MouseEvent.CLICK, changeColorSwatch);
				this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + count.toString()).buttonMode = true;
				
				var mcolor:ColorTransform=new ColorTransform();
				mcolor.color = uint(el);
				this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + count.toString()).transform.colorTransform=mcolor;
				count++;
			}
			var total:int = arr.length;
			var i:int = 5;
			while(i != total) {
				if(this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + i.toString()) != null) {
					this._downRowSwatchedReset._slots.removeChild(this._downRowSwatchedReset._slots.getChildByName("_colorSlot" + i.toString()));
				}
				i--;
			}
			
		}
		
		private function changeColorSwatch(e:MouseEvent):void {
			if(this._colors.getChildByName("_selectedColorBorder") != null) {
				this._colors.removeChild(this._colors.getChildByName("_selectedColorBorder"));
			}
			
			swatchIndex = int(Utilities.replace(e.currentTarget.name, "_colorSlot", ""));
			
			this._downRowSwatchedReset._slots._slotSelectedBorder.x = 45*(swatchIndex-1);
			
			if(colorDetailsHolder[swatchIndex-1].pallet != "" && colorDetailsHolder[swatchIndex-1].pallet == currentPallet) {
				var square:MovieClip = new MovieClip();
				square.graphics.lineStyle(4, 0xFFFFFF, 1.0);
				square.graphics.beginFill(0x000000, 0);
				square.graphics.drawRect(colorDetailsHolder[swatchIndex-1].border_x, colorDetailsHolder[swatchIndex-1].border_y, 44.5, 44.65);
				square.graphics.endFill();
				square.name = "_selectedColorBorder";
				this._colors.addChild(square);
			}
		}
		
		private function onOkButton(e:MouseEvent) {
			var res_string = "";
			var count = 0;
			for each(var el:SwatchDetailsHolder in colorDetailsHolder) {
				var col:uint;
				if(el.selected_color) {
					col = el.selected_color;
				} else {
					col = el.default_color;
				}
				
				if(count == 0) {
					res_string += "0x" + col.toString(16);
				} else {
					res_string += "," + "0x" + col.toString(16);
				}
				count++;
			}
			
			if(res_string != "") {
				if(defaultColorsObject != null) {
					ColorMap.SetColorsOnMovieClip(movieclip, 0, res_string, defaultColorsObject);
				} else {
					ColorMap.SetColorsOnMovieClip(movieclip, 0, res_string);
				}
				setColorsOnStageColorSwatch(res_string);
			}
			stage2.removeChild(this);
		}
		
		private function onResetButton(e:MouseEvent) {
			if(defaultColorsObject != null) {
				ColorMap.SetColorsOnMovieClip(movieclip, 0, defaultColorsString, defaultColorsObject);
			} else {
				ColorMap.SetColorsOnMovieClip(movieclip, 0, defaultColorsString);
			}
			setColorsOnStageColorSwatch(defaultColorsString);
			this.initColorSwatches();
			colorDetailsHolder = new Array();
			this.setColorDetailsOnHolder();
			if(this._colors.getChildByName("_selectedColorBorder") != null) {
				this._colors.removeChild(this._colors.getChildByName("_selectedColorBorder"));
			}
		}
		
		public function setColorsOnStageColorSwatch(param1:String) {
			var arr:Array = param1.split(",");
			var count:int = 1;
			var m:MovieClip = stageColorSwatch.getChildByName("_ctotal" + count.toString()) as MovieClip;
			
			stageColorSwatch._ctotal1.visible = false;
			stageColorSwatch._ctotal2.visible = false;
			stageColorSwatch._ctotal3.visible = false;
			stageColorSwatch._ctotal4.visible = false;
			stageColorSwatch._ctotal5.visible = false;
			
			var m:MovieClip = stageColorSwatch.getChildByName("_ctotal" + (arr.length).toString()) as MovieClip;
			m.visible = true;
			
			for each(var el:String in arr) {
				var mcolor:ColorTransform=new ColorTransform();
				mcolor.color = uint(el);
				
				var transformObj:MovieClip = m.getChildByName("color" + count.toString()) as MovieClip;
				
				transformObj.transform.colorTransform = mcolor;
				count++;
			}
		}
	}
}