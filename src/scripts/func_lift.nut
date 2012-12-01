/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/func_lift.nut
	Author: AndyGFX
*/

/*!
	@short	func_lift
	@author	AndyGFX
*/
class	func_lift
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/

	classname = "func_lift"
	state = "down";
	_item = 0

	function	OnUpdate(item)
	{

	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		this._item = item
	}

	function MoveUp()
	{
		print(this.state)
		
		if (ItemIsCommandListDone(this._item))
		{
			
			
			if (this.state=="down")
			{
				g_sfx_lift_up.Play()
				ItemSetCommandList(this._item, "offsetposition 0.5,0,1,0;")
				this.state="up"
			}
		}

	}

	function MoveDown()
	{
		print(this.state)
		if (ItemIsCommandListDone(this._item))
		{
			
			
			if (this.state=="up")
			{
				g_sfx_lift_down.Play()
				ItemSetCommandList(this._item, "offsetposition 0.5,0,-1,0;")
				this.state="down"
			}
		}

	}

	function CheckLiftBoard()
	{
		local pos = this._item.position()
		local contact = SceneCollisionRaytrace(g_scene, pos+Vector(0,1.3,0),Vector(0,-1,0), -1, CollisionTraceAll, Mtr(1)); 
		
		
		if (contact.hit) 
		{
			print("OnBoard is: "+contact.item.name()+"["+pos.x + ","+ pos.y + "," + pos.z+"]")
			return contact.item
		}

		return null
	}
	
	
	function GetState()
	{		
		return this.state	
	}
}
