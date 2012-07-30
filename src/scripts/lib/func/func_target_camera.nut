



class	func_target_camera
{
	
	/*<
	<Script =
	  <Name = "func_target_camera">
	  <Author = "AndyGFX">
	  <Description = "Func Target Camera">
	>
	<Parameter =
	  <target_name = <Name = "Target item name"> <Description = "target point for TargetCamera"> <Type = "String"> <Default = "noname">>
	>
	>*/

	target 			= 0
	target_name		=	"Player"
	smooth_target 	= 0
	camera_id 		= 0
	/*!
		<Parameter =
		<target_name = <Name="Target"> <Description = "Target item to follow."> <Type = "Item">>
	>
	*/
	function	OnUpdate(item)
	{
        smooth_target = target.worldPosition()

		ItemSetTarget(item, smooth_target)


		KeyboardUpdate()

		if (ItemIsCommandListDone(item))
		{
			if	(KeyboardSeekFunction(DeviceKeyPress, KeyLCtrl) && KeyboardSeekFunction(DeviceKeyPress, KeyLeftArrow))  
			{
				this.camera_id--
				if (this.camera_id<0) this.camera_id=3
				this.SwitchToPosition(item,this.camera_id)
			}
			if	(KeyboardSeekFunction(DeviceKeyPress, KeyLCtrl) && KeyboardSeekFunction(DeviceKeyPress, KeyRightArrow))  
			{
				this.camera_id++
				if (this.camera_id>3) this.camera_id=0

				this.SwitchToPosition(item,this.camera_id)
			}

		}
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{

		
	if	((target = SceneFindItem(g_scene, target_name)).isNull())
			throw("Target item '" + target_name + "' not found")

		smooth_target = target.worldPosition()

		// set self as main camera of scene
		SceneSetCurrentCamera(g_scene,ItemCastToCamera(item))
		this.SwitchToPosition(item,this.camera_id)
	}



	function SwitchToPosition(item,id)
	{
		local new_cam_pos = SceneFindItem(g_scene, "TargetCamera_"+id)
		local camera_target_position =  ItemGetPosition(new_cam_pos)
		local cmd = camera_target_position.x + "," + camera_target_position.y+","+camera_target_position.z
		ItemSetCommandList(item, "toposition 0.5,"+cmd+";")

	}
}
