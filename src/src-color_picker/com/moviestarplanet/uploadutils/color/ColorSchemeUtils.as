package com.moviestarplanet.uploadutils.color
{
   public class ColorSchemeUtils
   {
       
      
      public function ColorSchemeUtils()
      {
         super();
      }
      
      public static function colorSchemeToString(param1:Object) : String
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         if(param1.defaultcolor)
         {
            _loc2_.push("defaultcolor=defaultcolor," + param1.defaultcolor.color + "," + param1.defaultcolor.label);
         }
         if(Boolean(param1.colors) && param1.colors.length > 0)
         {
            _loc3_ = new Array();
            for each(_loc4_ in param1.colors)
            {
               _loc3_.push(_loc4_.instances[0] + "," + _loc4_.color + "," + _loc4_.label);
            }
            _loc2_.push("colors=" + _loc3_.join(":"));
         }
         if(param1.nocolor)
         {
            _loc2_.push("nocolor=" + (param1.nocolor as Array).join(":"));
         }
         return _loc2_.join(";");
      }
	  
	  public static function getColorStringFromColorScheme(param1: Array): String {
		  var colors: Array = param1;
		  
		  if (colors.length != 0) {
			  if (colors.length > 5) {
				  return "null";
			  } else {
				  return colors.join(",");
			  }
		  } else {
			  return "null";
		  }
	  }
   }
}
