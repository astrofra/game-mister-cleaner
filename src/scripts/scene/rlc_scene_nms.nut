/*
	File: E:/_3D_Engines/GameStart/Projects/AGFX_game_RLC/scripts/scene/rlc_scene_nms.nut
	Author: AndyGFX
*/
Include("scripts/scene/rlc_commands.nut");

/*!
	@short	rlc_scene_nms
	@author	AndyGFX
*/
class	rlc_scene_nms
{
	/*!
		@short	OnUpdate
		Called each frame.
	*/
	
	
	
	function	OnUpdate(scene)
	{}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
		debug("SCENE: OnSetup()")
	}
	


	function OnSetupDone(scene)
	{

		debug("SCENE: OnSetupDone()")
		local player_item = SceneFindItem(scene,"Player")
		ItemGetScriptInstance(player_item).Enable()
	
	
	}
	
} 