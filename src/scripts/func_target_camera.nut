



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
	target_name		=	"CameraLookAtPoint"
	smooth_target 	= 0
	camera_id 		= 0
	camera_target_id = 0      // 0 = fixed target camera , 1 = lookat target camera
	current_target = 0
	InputKey = TKeyboard();
	
	/*!
		<Parameter =
		<target_name = <Name="Target"> <Description = "Target item to follow."> <Type = "Item">>
	>
	*/
	
	constructor()
	{
		current_target = [0,0]	
	}
	
	function	OnUpdate(item)
	{
        smooth_target = current_target[camera_target_id].worldPosition()

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


		current_target[0] = SceneFindItem(g_scene, target_name)
		current_target[1] = SceneFindItem(g_scene, "Player")

		// set self as main camera of scene
		SceneSetCurrentCamera(g_scene,ItemCastToCamera(item))
		this.SwitchToPosition(item,this.camera_id)
	}



	function SwitchToPosition(item,id)
	{

		local camera_target_position =  ItemGetPosition(SceneFindItem(g_scene, "TargetCamera_"+id))
		local cmd = camera_target_position.x + "," + camera_target_position.y+","+camera_target_position.z
		ItemSetCommandList(item, "toposition 0.5,"+cmd+";")

	}
}
