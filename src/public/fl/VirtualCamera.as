package fl {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import privatePkg.___Camera___;
	public class VirtualCamera
	{
		static var virtualCameraDict:Dictionary = new Dictionary();
		var virtualCamera:___Camera___;
		var dispRoot:MovieClip;
		public function VirtualCamera(container:DisplayObject)
		{
			// constructor code

			if(container is MovieClip)
				dispRoot = MovieClip(container);
			else
			{
				dispRoot = null;
				virtualCamera = null;
				return;
			}
			
			if(dispRoot.getChildByName("___camera___instance") == null)
			{
				virtualCamera = new ___Camera___(container.stage.stageWidth, container.stage.stageHeight);
				var mat:Matrix = new Matrix();
				mat.identity();
				mat.tx = dispRoot.stage.stageWidth/2;
				mat.ty = dispRoot.stage.stageHeight/2;
				virtualCamera.transform.matrix = mat;
				virtualCamera.name = "___camera___instance";
				
				dispRoot.addChild(virtualCamera);
				virtualCamera.init();
			}
			else
				virtualCamera = ___Camera___(dispRoot.getChildByName("___camera___instance"));
				
			container.addEventListener(Event.REMOVED_FROM_STAGE, containerRemoved);
			virtualCamera.addEventListener(Event.REMOVED_FROM_STAGE, cameraRemovedFromStage);
		}
		
		public function getCameraAsMovieClip():MovieClip
		{
			return virtualCamera;
		}
		
		public function moveBy(tx: Number, ty: Number, tz: Number = 0): void
		{
			if(virtualCamera != null)
				virtualCamera.moveBy(tx, ty, tz);
		}

		public function setPosition(posX: Number, posY: Number, posZ: Number = 0): void
		{
			if(virtualCamera != null)
				virtualCamera.setPosition(posX, posY, posZ);
		}

		public function getPosition(): Object
		{
			if(virtualCamera != null)
				return virtualCamera.getPosition();
			else
				return null;
		}

		public function resetPosition(): void
		{
			if(virtualCamera != null)
				virtualCamera.resetPosition();
		}

		public function zoomBy(zoom: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.zoomBy(zoom);
		}

		public function setZoom(zoom: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.setZoom(zoom);
		}

		public function getZoom(): Number
		{
			if(virtualCamera != null)
				return virtualCamera.getZoom();
			return 1;
		}

		public function resetZoom(): void
		{
			if(virtualCamera != null)
				virtualCamera.resetZoom();
		}

		public function rotateBy(angle: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.rotateBy(angle);
		}

		public function setRotation(angle: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.setRotation(angle);
		}

		public function getRotation(): Number
		{
			if(virtualCamera != null)
				return virtualCamera.getRotation();
			else
				return 0;
		}

		public function resetRotation(): void
		{
			if(virtualCamera != null)
				virtualCamera.resetRotation();
		}

		public function setTint(tintColor: uint, tintPercent: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.setTint(tintColor, tintPercent);
		}

		public function setTintRGB(red: Number, green: Number, blue: Number, tintPercent: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.setTintRGB(red,green, blue, tintPercent);
		}
		
		public function getTint(): Object
		{
			if(virtualCamera != null)
				return virtualCamera.getTint();
			else
				return null;
		}

		public function getTintRGB(): Object
		{
			if(virtualCamera != null)
				return virtualCamera.getTintRGB();
			else
				return null;
		}

		public function resetTint()
		{
			if(virtualCamera != null)
				virtualCamera.resetTint();
		}

		public function setColorFilter(brightness: Number, contrast: Number, saturation: Number, hue: Number): void
		{
			if(virtualCamera != null)
				virtualCamera.setColorFilter(brightness, contrast, saturation, hue);
		}

		public function resetColorFilter()
		{
			if(virtualCamera != null)
				virtualCamera.resetColorFilter();
		}

		public function reset()
		{
			if(virtualCamera != null)
				virtualCamera.reset();
		}

		public function setZDepth(zDepth: Number): void
		{
			if(virtualCamera != null)		
				virtualCamera.setZDepth(zDepth);
		}
		
		public function resetZDepth(): void
		{
			if(virtualCamera != null)		
				virtualCamera.resetZDepth();
		}

		public function getZDepth(): Number
		{
			if(virtualCamera != null)
				return virtualCamera.getZDepth();
			else
				return 0;
		}
		
		public function pinCameraToObject(object:DisplayObject, offsetX:Number = 0, offsetY:Number = 0, offsetZ:Number = 0)
		{
			if(virtualCamera != null)
				virtualCamera.pinCameraToObject(object, offsetX, offsetY, offsetZ);
		}
		
		public function setPinOffset(offsetX:Number, offsetY:Number, offsetZ:Number)
		{
			if(virtualCamera != null)
				virtualCamera.setPinOffset(offsetX, offsetY, offsetZ);
		}
		
		public function unpinCamera()
		{
			if(virtualCamera != null)
				virtualCamera.unpinCamera();
		}
		
		public function setCameraMask(maskObj:DisplayObject)
		{
			if(virtualCamera != null)
				virtualCamera.setCameraMask(maskObj);
		}
		
		public function removeCameraMask()
		{
			if(virtualCamera != null)
				virtualCamera.removeCameraMask();
		}
		
		public static function getCamera(container:DisplayObject):VirtualCamera
		{
			if(virtualCameraDict[container] == undefined || virtualCameraDict[container] == null)
				virtualCameraDict[container] = new VirtualCamera(container);
			return virtualCameraDict[container];
		}
		
		public static function getCameraAsMovieClip(container:DisplayObject):MovieClip
		{
			var camera = getCamera(container);
			if(camera != undefined && camera != null)
				return camera.virtualCamera;
			return undefined;
		}
		
		private function containerRemoved(e:Event)
		{
			removeVirtualCamera(DisplayObject(e.target));
		}
		
		private static function removeVirtualCamera(container:DisplayObject)
		{
			if(virtualCameraDict[container] != undefined && virtualCameraDict[container] != null)
				virtualCameraDict[container] = undefined;
		}
		
		private function cameraRemovedFromStage(e:Event)
		{
			virtualCameraDict[MovieClip(e.target).parent] = undefined;
			getCamera(MovieClip(e.target).parent);
		}
	}
}