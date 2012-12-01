



class	func_titlewait_target_camera
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
	target_name		=	"camera_target_point"
	smooth_target 	= 0
	camera_id = 0
	
	function	OnUpdate(item)
	{
	}

	function	OnSetup(item)
	{

		
		ItemSetPosition(item,Vector(-8.053,4.644,-0.036))
		ItemSetRotation(item,Vector(Deg(28.242),Deg(90.488),0))

		SceneSetCurrentCamera(g_scene,ItemCastToCamera(item))	
	}

}
