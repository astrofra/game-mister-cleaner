/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/breakable_wall.nut
	Author: AndyGFX
*/

/*!
	@short	func_breakable_wall
	@author	AndyGFX
*/
class	func_breakable_wall
{

	/*<
	<Script =
	  <Name = "func_breakable_wall.nut">
	  <Author = "AndyGFX">
	  <Description = "Breakable wall (with item bomb)">
	>
	<Parameter =
	  <item_name = <Name = "Classname"> <Description = "Classname of entity"> <Type = "String"> <Default = "breakable_wall">>
	>
	>*/

	item_name = "breakable_wall"
	_item = 0
	
	// ------------------------------------------------------------------------------------
	//	@short	OnUpdate
	//	Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------
	function	OnUpdate(item)
	{
		if (ItemIsCommandListDone(item))
		{ 
			ItemIsInvisible(item)
			
		}
	}


	// ------------------------------------------------------------------------------------
	//	@short	OnSetup
	//	Called when the item is about to be setup.
	// ------------------------------------------------------------------------------------
	function	OnSetup(item)
	{
		ItemSetName(item,this.item_name)
		this._item = item
	}

	function ExplodeItem()
	{
		g_sfx_reaction.Play()
		ItemSetCommandList(this._item,"offsetposition 0.5,0,-2,0;");

	} 
}
