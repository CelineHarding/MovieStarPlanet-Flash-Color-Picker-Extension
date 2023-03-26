package
{
	import com.moviestarplanet.uploadutils.color.ColorSchemeUtils;
	import com.moviestarplanet.utils.ColorMap;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class ColorPickerInstance extends MovieClip
	{
		private var colorSwatch:MovieClip = null;
		private var clothItem:MovieClip = null;
		private var defaultColors:*;
		private var stage2:Stage = null;
		private var cp_name:String = "";
		private var cpi:ColorPickerInterface = null;
		private var scale2:Number = 1;
		
		public function ColorPickerInstance(stage:Stage, color_swatch:MovieClip, cloth_item:MovieClip, scale:Number, default_colors:*): void
		{
			colorSwatch = color_swatch;
			clothItem = cloth_item;
			defaultColors = default_colors;
			stage2 = stage;
			cp_name = generateRandomString(20);
			scale2 = scale;
			
			colorSwatch.buttonMode = true;
			colorSwatch.addEventListener(MouseEvent.CLICK, onColorSwatchClick);
			
			setColorsOnStageColorSwatch(getDefaultColorsString());
		}
		
		private function onColorSwatchClick(e:MouseEvent) {
			if(cpi == null) {
				cpi = new ColorPickerInterface(stage2, clothItem, colorSwatch, defaultColors);
				cpi.scaleX = scale2;
				cpi.scaleY = scale2;
				var cx:Number = clothItem.x;
				var cy:Number = clothItem.y;
				
				cpi.x = cx + 150;
				cpi.y = cy + -300;
				
				if(cpi.x < 0) {
					cpi.x = cpi.x*(-1);
				}
				if((cpi.x + cpi.width) > stage2.stageWidth) {
					while((cpi.x + cpi.width) > stage2.stageWidth) {
						cpi.x -= 5;
					}
				}
				
				if(cpi.y < 0) {
					cpi.y = cpi.y*(-1);
				}
				if((cpi.y + cpi.height) > stage2.stageHeight) {
					while((cpi.y + cpi.height) > stage2.stageHeight) {
						cpi.y -= 5;
					}
					cpi.y -= 50;
				}
			}
			stage2.addChild(cpi);
		}
		
		private function generateRandomString(strlen:Number):String{
			var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			var num_chars:Number = chars.length - 1;
			var randomChar:String = "";
			
			for (var i:Number = 0; i < strlen; i++){
				randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
			}
			return randomChar;
		}
		
		private function setColorsOnStageColorSwatch(param1:String) {
			var arr:Array = param1.split(",");
			var count:int = 1;
			var m:MovieClip = colorSwatch.getChildByName("_ctotal" + count.toString()) as MovieClip;
			
			colorSwatch._ctotal1.visible = false;
			colorSwatch._ctotal2.visible = false;
			colorSwatch._ctotal3.visible = false;
			colorSwatch._ctotal4.visible = false;
			colorSwatch._ctotal5.visible = false;
			
			var m:MovieClip = colorSwatch.getChildByName("_ctotal" + (arr.length).toString()) as MovieClip;
			m.visible = true;
			
			for each(var el:String in arr) {
				var mcolor:ColorTransform=new ColorTransform();
				mcolor.color = uint(el);
				
				var transformObj:MovieClip = m.getChildByName("color" + count.toString()) as MovieClip;
				
				transformObj.transform.colorTransform = mcolor;
				count++;
			}
		}
		
		private function getDefaultColorsString() {
			if(typeof(defaultColors) == "string") {
				return defaultColors;
			} else if(typeof(defaultColors) == "object") {
				return  ColorSchemeUtils.getColorStringFromColorScheme(ColorMap.GetColorsFromColorSchemeString(ColorSchemeUtils.colorSchemeToString(defaultColors)));
			} else {
				throw new Error("param3 has to be of type \"string\" or \"object\"");
			}
		}
	}
}