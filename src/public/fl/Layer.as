package fl
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import fl.VirtualCamera;
	import privatePkg.___LayerProp___
	
	public class Layer
	{
		private static const MIN_Z = -5000;
		private static const MAX_Z = 10000;
		public function Layer()
		{

		}
		
		public static function getLayerZDepth(timeline: DisplayObject, layerName: String):Number
		{
			if( !timeline is MovieClip)
				return 0;
			var timelineContainer = MovieClip(timeline);
			if(layerName == "Camera" || layerName == "___camera___instance")
			{
				layerName = "___camera___instance";
				var cameraObj = timelineContainer.getChildByName(layerName);
				if(cameraObj)
					return cameraObj.z;
				return 0;
			}
			
			//if(!timelineContainer.___layerDepthEnabled___)
				//return 0;
				
			var layerContainer = timelineContainer.getChildByName(layerName);
			if (layerContainer != undefined && layerContainer != null)
			{
				var layerPropContainer = timelineContainer.getChildByName(layerName + "_prop_");
				if (layerPropContainer != undefined && layerPropContainer != null)
					return layerPropContainer.z;
			}
			return 0;
		}
		
		public static function setLayerZDepth(timeline: DisplayObject, layerName: String, zDepth : Number)
		{
			if(zDepth < MIN_Z)
				zDepth = MIN_Z;
			else if(zDepth > MAX_Z)
				zDepth = MAX_Z;
				
			if( !timeline is MovieClip)
				return;
			var timelineContainer = MovieClip(timeline);
			if(layerName == "Camera" || layerName == "___camera___instance")
			{
				layerName = "___camera___instance";
				var cameraObj = timelineContainer.getChildByName(layerName);
				if(cameraObj)
					cameraObj.z = zDepth;
				return;
			}
			
			//if(!timelineContainer.___layerDepthEnabled___)
				//return;
				
			var layerContainer = timelineContainer.getChildByName(layerName); 
			if (layerContainer != undefined && layerContainer != null)
			{
				var layerPropContainer = timelineContainer.getChildByName(___propertyContainerName___(layerName)); 
				if (layerPropContainer != undefined && layerPropContainer != null)
				{
					layerPropContainer.z = zDepth;
				}
			}
		}
		
		public static function removeLayer(timeline:DisplayObject, layerName:String)
		{
			if( !timeline is MovieClip)
				return;
			var timelineContainer = MovieClip(timeline);
			if(layerName == "Camera")
			{
				layerName = "___camera___instance";
				var cameraObj = timelineContainer.getChildByName(layerName);
				if(cameraObj)
					timelineContainer.removeChild(cameraObj);
				return;
			}
			
			//if(!timelineContainer.___layerDepthEnabled___)
				//return;
				
			var layerContainer = timelineContainer.getChildByName(layerName);
			if (layerContainer != undefined && layerContainer != null)
			{
				var layerPropContainer = timelineContainer.getChildByName(___propertyContainerName___(layerName));
				if (layerPropContainer != undefined && layerPropContainer != null)
				{
					timelineContainer.removeChild(layerContainer);
					timelineContainer.removeChild(layerPropContainer);
				}
			}
		}
		
		static function ___propertyContainerName___(layerName:String) : String
		{
			return layerName + "_prop_";
		}
		
		static function ___findHighestLayerIndex___(timeline:MovieClip) : Number
		{
			var maxIndex = 0;
			for (var i = 0; i<timeline.numChildren; i++)
			{
				var child = timeline.getChildAt(i);
				if (child['containerType'] != undefined && child['containerType'] == 1)
				{
					if (child['layerIndex'] != undefined && child['layerIndex'] > maxIndex)
						maxIndex = child['layerIndex'];
				}
			}
			return maxIndex;
		}
		
		public static function addNewLayer(timeline:DisplayObject, layerName:String, zDepth : Number = 0, attachedToCamera : Boolean = false) : MovieClip
		{
			if(zDepth < MIN_Z)
				zDepth = MIN_Z;
			else if(zDepth > MAX_Z)
				zDepth = MAX_Z;
			
			if( !timeline is MovieClip)
				return null;
			var timelineContainer = MovieClip(timeline);
			if(layerName == "Camera")
			{
				layerName = "___camera___instance";
				var cameraObj = timelineContainer.getChildByName(layerName);
				if(cameraObj)
					timelineContainer.removeChild(cameraObj);
				return null;
			}
			
			//if(!timelineContainer.___layerDepthEnabled___)
				//return null;
				
			var layerType = 2;
			var layer : MovieClip = MovieClip(timelineContainer.getChildByName(layerName));
			if (layer != null)
				return layer;
			layer = new MovieClip();
			layer.name = layerName;
			layer['containerType'] = layerType; // layer object
			timelineContainer.addChildAt(layer, 0);
			if(layerType > 0)
			{
				var layerProp : ___LayerProp___ = new ___LayerProp___();
				layerProp.name = ___propertyContainerName___(layerName);
				layerProp.z = zDepth;
				layerProp['containerType'] = 1; // property container
				layerProp['isAttachedToCamera'] = attachedToCamera;
				layerProp['layerIndex'] = ___findHighestLayerIndex___(timelineContainer) + 1;
				layerProp['layerDepth'] = 0;
				timelineContainer.addChildAt(layerProp, 1);
				layerProp.init();
			}
			
			return layer;
		}

		public static function layersPublishedAsMovieClips(timeline:DisplayObject):Boolean
		{
			if( !timeline is MovieClip)
				return false;
			var timelineContainer = MovieClip(timeline);

			for (var i = 0; i<timelineContainer.numChildren; i++)
			{
				var child = timelineContainer.getChildAt(i);
				if (child is MovieClip && child['containerType'] != undefined)
					return true;
			}
			return false;
		}
	}
}