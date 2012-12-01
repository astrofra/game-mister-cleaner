/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/func_light_fade.nut
	Author: AndyGFX
*/

/*!
	@short	func_light_fade
	@author	AndyGFX
*/
class	func_light_fade
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	_item = 0;
	do_fade = ""

	function	OnUpdate(item)
	{
		if (this.do_fade=="IN")
		{
			this.FadeIn()	
		}	
		
		if (this.do_fade=="OUT")
		{
			this.FadeOut()	
		}	
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		this._item = ItemCastToLight(item)
		this.FadeOut()
	}
	
	
	// to dark
	function FadeOut()
	{
		local lc = Vector(0,0,0)
		LightSetDiffuseColor(this._item,lc)	
	}
	
	// to light
	function FadeIn()
	{
		local lc = Vector(1,1,1)
		LightSetDiffuseColor(this._item,lc)	
	}
	
	// set fade mode
	function Fade(mode)
	{
		this.do_fade=mode
	}
}
