package com.colorpicker
{
	public class Utilities
	{
		public function Utilities()
		{
		}
		
		public static function replace(str:String, search:String, replacement:String):String {
			var a:int = search.length;
			var b:int = replacement.length;
			var o:int = 0;
			var i:int;
			while( ( i = str.indexOf( search, o ) ) != -1 ) {
				str = str.substr( 0, i ) + replacement + str.substr( i + a );
				o = i + b;
			}
			return str;
		}
		
		public static function createColorMapFromColorString(param1:String):Object {
			var arr:Array = param1.split(",");
			var obj:Object = null;
			if(arr.length == 1) {
				obj = {"defaultcolor":{
					"label":"Color:",
					"color":arr[0]
				}};
			} else if(arr.length == 2) {
				obj = {
					"defaultcolor":{
						"label":"Denim",
						"color":arr[0]
					},
					"colors":[{
						"label":"Leather",
						"color":arr[1],
						"instances":["color2"]
					}]
				};
			} else if(arr.length == 3) {
				obj = {
					"defaultcolor":{
						"label":"Denim",
						"color":arr[0]
					},
					"colors":[{
						"label":"Leather",
						"color":arr[1],
						"instances":["color2"]
					},{
						"label":"Leather",
						"color":arr[2],
						"instances":["color3"]
					}]
				};
			} else if(arr.length == 4) {
				obj = {
					"defaultcolor":{
						"label":"Denim",
						"color":arr[0]
					},
					"colors":[{
						"label":"Leather",
						"color":arr[1],
						"instances":["color2"]
					},{
						"label":"Leather",
						"color":arr[2],
						"instances":["color3"]
					},{
						"label":"Leather",
						"color":arr[3],
						"instances":["color4"]
					}]
				};
			} else if(arr.length == 5) {
				obj = {
					"defaultcolor":{
						"label":"Denim",
						"color":arr[0]
					},
					"colors":[{
						"label":"Leather",
						"color":arr[1],
						"instances":["color2"]
					},{
						"label":"Leather",
						"color":arr[2],
						"instances":["color3"]
					},{
						"label":"Leather",
						"color":arr[3],
						"instances":["color4"]
					},{
						"label":"Leather",
						"color":arr[4],
						"instances":["color5"]
					}]
				};
			}
			return obj;
		}
		
		public static function createColorMapFromColorStringUsingObject(param1:String, param2:Object):Object {
			var arr:Array = param1.split(",");
			if(param2.hasOwnProperty("defaultcolor")) {
				param2.defaultcolor.color = arr[0]
			}
			if(param2.hasOwnProperty("colors")) {
				var count_colors:int = 1;
				var count_param:int = 0;
				for each(var el:Object in param2.colors) {
					if(param2.hasOwnProperty("color")) {
						param2.colors[count_param].color = arr[count_colors];
						count_colors++;
						count_param++;
					}
				}
			}
			return param2;
		}
	}
}