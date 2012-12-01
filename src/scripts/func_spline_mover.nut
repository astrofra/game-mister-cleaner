/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/func_spline_mover.nut
	Author: AndyGFX
*/
Include("Scripts/lib/TSpline.nut")
/*!
	@short	func_spline_mover
	@author	AndyGFX
*/
class	func_spline_mover
{

	/*<
	<Script =
	  <Name = "player.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for player control and moving obstacles logic.">
	>
	<Parameter =
	  <spline_start_name = <Name = "Start point name"> <Description = "Set item name as start point"> <Type = "String"> <Default = "none">>
	  <spline_start_cp_name = <Name = "Start control point name"> <Description = "Set item name as start control point"> <Type = "String"> <Default = "none">>
	  <spline_start_mag = <Name = "Start control point magn."> <Description = "Set start control point magn."> <Type = "Float"> <Default = 1.0>>
	  <spline_end_name = <Name = "End point name"> <Description = "Set item name as end point"> <Type = "String"> <Default = "none">>
	  <spline_end_cp_name = <Name = "End control point name"> <Description = "Set item name as end control point"> <Type = "String"> <Default = "none">>
	  <spline_end_mag = <Name = "End control point magn."> <Description = "Set end control point magn."> <Type = "Float"> <Default = 1.0>>
	  <spline_increment = <Name = "Move speed"> <Description = "Set speed"> <Type = "Float"> <Default = 1.0>>
	>
	>*/ 

	spline_start_name = "none"
	spline_start_mag = 1.0;
	spline_start_cp_name = "none"
	
	spline_end_name = "none"	
	spline_end_cp_name = "none"
	spline_end_mag = 1.0;
	
	spline_increment = 1.0;

	

	spline = TSpline()
	
	time = 0;
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		this.time = this.time + this.spline_increment;
		if(time>100) {time=0.0}
		
		local pos = this.spline.Interpolate(this.time/100.0)
		ItemSetPosition(item,pos)
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		local _i_sp = SceneFindItem(g_scene,this.spline_start_name)
		local _i_csp = SceneFindItem(g_scene,this.spline_start_cp_name)
		local _i_ep = SceneFindItem(g_scene,this.spline_end_name)
		local _i_cep = SceneFindItem(g_scene,this.spline_end_cp_name)
		
		local cp0 = Vector(0,0,0)
		cp0 = _i_csp.position()-_i_sp.position()
		//cp0.Normalize()

		local cp1 = Vector(0,0,0)
		cp1 = _i_cep.position()-_i_ep.position()
		//cp1.Normalize()
		
		this.spline.CreateSpline(_i_sp.position(),cp0,_i_ep.position(),cp1,SPLINE_XYZ,this.spline_start_mag,this.spline_end_mag)
		
	}
}
