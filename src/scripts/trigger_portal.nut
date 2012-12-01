/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/trigger_portal.nut
	Author: AndyGFX
*/

/*!
	@short	PortalTrigger_OUT
	@author	AndyGFX
*/
class	PortalTrigger_OUT
{
	/*<
	<Script =
	  <Name = "trigger_portal.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for jump betveen portals.">
	>
	<Parameter =
	  <target_name = <Name = "Target name"> <Description = "Target portal name for jump"> <Type = "String"> <Default = "noname">>
	>
	>*/ 

	target_name = "noname"
	classname = "trigger_portal"
	enable = false;

	// ------------------------------------------------------------------------------------
	// Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------

	function	OnUpdate(item)
	{}

	/*!
		@short	OnSetup
		
	*/
	// ------------------------------------------------------------------------------------
	// Called when the item is about to be setup.
	// ------------------------------------------------------------------------------------

	function	OnSetup(item)
	{
		
	}

	function	OnTrigger(item, trigger_item)
	{
    	
	}
}
