/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/wait_scene.nms.nut
	Author: AndyGFX
*/

/*!
	@short	scenes_wait_scene_nms
	@author	AndyGFX
*/
class	scenes_wait_scene_nms
{
	/*!
		@short	OnUpdate
		Called each frame.
	*/

	time = 2;
	current_time = 0;

	function	OnUpdate(scene)
	{		
		if (SystemGetClock()-this.current_time>(this.time*10000))
		{
			g_game_wait="DISABLE"				
		}
	}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
		
		this.Reset()
		
	}
	
	function SetDelay(t)
	{
		this.time = t	
		
	}
	function Reset()
	{
		this.current_time = SystemGetClock()
	}
}
