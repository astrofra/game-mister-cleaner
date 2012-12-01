/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/func_mover.nut
	Author: AndyGFX
*/

/*!
	@short	func_mover
	@author	AndyGFX
*/
class	func_mover
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	
	_item = 0;
	function	OnUpdate(item)
	{
		if (ItemIsCommandListDone(item))
		{
			this.Move()
		}	
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		this._item = item			
		this.Move()
	}
	
	function Move()
	{
		ItemSetCommandList(this._item, "offsetposition 1,0,0,-1;offsetposition 0,0,0,1;")
	}
}
