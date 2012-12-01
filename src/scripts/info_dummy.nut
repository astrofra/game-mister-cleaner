/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/info_dummy.nut
	Author: AndyGFX
*/

/*!
	@short	info_dummy
	@author	AndyGFX
*/
class	info_dummy
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetupDone(item)
	{
		ItemSetInvisible(item,true)
		 ItemActivate(item, false) 
	}
}
