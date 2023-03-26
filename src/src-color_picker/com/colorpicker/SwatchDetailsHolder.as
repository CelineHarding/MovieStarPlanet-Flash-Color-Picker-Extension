package com.colorpicker
{
	import flash.display.MovieClip;
	
	public class SwatchDetailsHolder
	{
		public var default_color:uint;
		public var selected_color:uint;
		public var border_x:int;
		public var border_y:int;
		public var pallet:String;
		public var swatch:MovieClip;
		
		public function SwatchDetailsHolder(default_color2:uint, selected_color2:uint, border_x2:int, border_y2:int, pallet2:String, swatch2:MovieClip)
		{
			default_color = default_color2;
			selected_color = selected_color2;
			border_x = border_x2;
			border_y = border_y2;
			pallet = pallet2;
			swatch = swatch2;
		}
	}
}