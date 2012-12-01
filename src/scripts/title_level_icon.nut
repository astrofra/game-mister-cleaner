/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/title_level_icon.nut
	Author: AndyGFX
*/

/*!
	@short	title_level_icon
	@author	AndyGFX
*/
class	title_level_icon
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/

/*<
	<Script =
	  <Name = "title_level_icon.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for ext item properties.">
	>
	<Parameter =
	  <level_id = <Name = "Level ID"> <Description = "Level ID"> <Type = "Int"> <Default = 0>>
	  <level_done = <Name = "Is level finished"> <Description = "Level ID"> <Type = "Bool"> <Default = False>>
	>
	>*/  

	level_id = 0
	level_done = false

	_item = 0;
	function	OnUpdate(item)
	{}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		this._item = item
				
		ItemSetPhysicMode(item, PhysicModeStatic)
		local	_shape	= ItemAddCollisionShape(item)
		local	_size	= Vector(0,0,0),
		_pos	= Vector(0,0,0),
		_scale	= Vector(0,0,0)

		local	_mm = ItemGetMinMax(item)
		
		_scale = ItemGetScale(item)
		
		if ((_scale.x != 1.0) ||  (_scale.x != 1.0) || (_scale.x != 1.0))
		{
			print("BuiltinItemPhysicbox::OnSetup() : Warning, item '" + ItemGetName(item) + "' has a scale factor != 1.0. Physic result might be wrong.")
		}
		
		_size.x = _mm.max.x -  _mm.min.x
		_size.y = _mm.max.y -  _mm.min.y
		_size.z = _mm.max.z -  _mm.min.z

		_pos = (_mm.max).Lerp(0.5, _mm.min)

		ShapeSetBox(_shape, _size)
		ShapeSetPosition(_shape, _pos)

		ShapeSetMass(_shape, 1)
		ItemWake(item)
		
		this.level_done = g_levels[g_level_name[this.level_id]].done
		if (this.level_done)
		{
			ItemSetRotation(this._item,Vector(Deg(180),0,0))	
		}
		
	}
}
