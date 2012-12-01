/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/trigger_switch_down.nut
	Author: AndyGFX
*/

/*!
	@short	trigger_switch_down
	@author	AndyGFX
*/
class	trigger_switch_down
{

	/*<
	<Script =
	  <Name = "trigger_switch_down.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for jump betveen portals.">
	>
	<Parameter =
	  <target_name = <Name = "Target name"> <Description = "Target lift name to change state"> <Type = "String"> <Default = "noname">>
	>
	>*/ 

	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/

	classname = "trigger_switch_down"
	target_name = "noname"

	function	OnUpdate(item)
	{}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{}
}
