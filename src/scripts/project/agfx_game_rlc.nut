/*
	File: E:/_3D_Engines/GameStart/Projects/AGFX_game_RLC/scripts/project/agfx_game_rlc.nut
	Author: AndyGFX
*/


Include("scripts/lib/aOO.nut");



/*!
	@short	AGFX_game_RLC
	@author	AndyGFX
*/
class	AGFX_game_RLC
{
	/*!
		@short	OnUpdate
		Called each frame.
	*/
	
	current_scene 	= 0;
	layer_scene 	= 0;
	
	constructor()
	{
		this.current_scene 	= null;
		this.layer_scene 	= 0;	
	}
	
	function	OnUpdate(project)
	{

	}

	
	function	OnRenderScene(project, scene, layer)
	{}

	
	function	OnSetup(project)
	{
		this.current_scene = ProjectInstantiateScene(project, "scene/rlc_scene.nms")		
		debug("   ... assign to layer")
		this.layer_scene = ProjectAddLayer(project, this.current_scene, 0.5) 

		InitializeCommands()
		
	}

	function OnSetupDone(project)
	{
		debug("PROJECT: OnSetupDone()")

	}
	

}


	