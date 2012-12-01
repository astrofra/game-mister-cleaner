



class	func_title_target_camera
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
	/*!
		<Parameter =
		<target_name = <Name="Target"> <Description = "Target item to follow."> <Type = "Item">>
	>
	*/
	function	OnUpdate(item)
	{
	}

	function	OnSetup(item)
	{

		
		ItemSetPosition(item,Vector(-2.424,2.554,-6.205))
		ItemSetRotation(item,Vector(Deg(12.254),Deg(24.752),0))

		SceneSetCurrentCamera(g_scene,ItemCastToCamera(item))	
	}

}
