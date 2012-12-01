
/*!
	@short	info_target_wall
	@author	AndyGFX
*/
class	info_target_wall
{
	item_wall_target			=	0
	material_wall_target		=	0
	
	color_target				=	0
	color_block					=	0

	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/

	classname = "target_position_trigger"

	function	OnUpdate(item)
	{
		MaterialSetSelfIllum(material_wall_target, color_block)
		color_block = color_block.Lerp(0.5, color_target)
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		ItemSetName(item,classname)	

		item_wall_target = ItemGetParent(item)
		material_wall_target = GeometryGetMaterialFromIndex(ItemGetGeometry(item_wall_target), 0)
		color_target = Vector(0,0,0)
		color_block = Vector(0.0,0.0,0.0)
	}

	function	OnItemExit(trigger_item, item)
	{
		if (ItemGetName(item) == "moveable_wall")
			color_target = Vector(0,0,0)
	}

	function	OnItemEnter(trigger_item, item)
	{
		if (ItemGetName(item) == "moveable_wall")
			color_target = Vector(1,1,1)
	}

/*
	function	OnTrigger(item, trigger_item)
	{
    	print("Item " + ItemGetName(item) + " is in the trigger " + ItemGetName(trigger_item))
	}
*/
}
