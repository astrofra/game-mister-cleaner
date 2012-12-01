

/*!
	@short	func_moveable_wall
	@author	AndyGFX
*/
class	func_moveable_wall
{
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	_item 				= 0
	pos 				= 0
	is_blocked 			= false
	chk_dir 			= 0
	cmd 				= ""
	is_on_target 		= false;
	was_schecked 		= false;
	item_name 			= "moveable_wall"

	glowing_light		=	0
	glowing_angle		=	0.0
	glowing_intensity	=	1.0
	glowing_material	=	0

	light_original_color	=	0
	light_target_color		=	0
	light_color				=	0
	

	// ------------------------------------------------------------------------------------
	//
	// ------------------------------------------------------------------------------------
	function	OnUpdate(item)
	{
		if (glowing_light != 0)
		{
			glowing_angle += (DegreeToRadian(2.5) * g_dt_frame * 60.0)
			local	light_intensity
			light_intensity = RangeAdjust(sin(glowing_angle), -1.0, 1.0, 0.0, 1.0)
			light_intensity = Pow(light_intensity , 8.0)
			//light_intensity = Max(light_intensity, 0.125 * Pow(RangeAdjust(sin(glowing_angle * 2.0), -1.0, 1.0, 0.0, 1.0), 16.0))
			light_intensity = Clamp(RangeAdjust(light_intensity, 0.0, 0.8, 0.0, 1.0), 0.0, 1.0)
			light_intensity = light_intensity * glowing_intensity
			light_intensity = ((light_intensity * 100).tointeger().tofloat()) * 0.01

			if (is_on_target)
				light_target_color	=	Vector(0.0,0.75,0.95,1.0) // Cyan // Vector(0.4,0.8,0.0,1.0)	//	Green
			else
				light_target_color	=	light_original_color	//	Red

			light_color = Lerp(0.1, light_color, light_target_color)

			LightSetDiffuseIntensity(glowing_light, light_intensity)
			LightSetSpecularIntensity(glowing_light, light_intensity)
			LightSetDiffuseColor(glowing_light, light_color)
			LightSetSpecularColor(glowing_light, light_color.Scale(0.5))
			MaterialSetDiffuse(glowing_material, light_color)
		}
	}

	// ------------------------------------------------------------------------------------
	//
	// ------------------------------------------------------------------------------------
	function SetPosition(item,pos)
	{
		this.pos = pos
		
	}
	
	// ------------------------------------------------------------------------------------
	//
	// ------------------------------------------------------------------------------------	
	function	OnSetup(item)
	{
		this.pos = ItemGetPosition(item)
		ItemSetName(item,this.item_name)
		this._item = item

		glowing_light = ItemGetChild(item, "nuclear_core_light")

		if (!ObjectIsValid(glowing_light))
			glowing_light = 0
		else
		{
			glowing_light = ItemCastToLight(glowing_light)
			glowing_intensity = LightGetDiffuseIntensity(glowing_light)
		}

		glowing_angle = DegreeToRadian(Rand(0.0, 180.0))
		glowing_material = GeometryGetMaterialFromIndex(ItemGetGeometry(item), 1)
		light_original_color = MaterialGetDiffuse(glowing_material)
		light_color = light_original_color
		light_target_color = light_original_color		
	}

	// ------------------------------------------------------------------------------------
	//
	// ------------------------------------------------------------------------------------
	constructor()
	{
		this.pos = Vector(0,0,0)
		this.chk_dir = Vector(0,0,0)
	}


	// ------------------------------------------------------------------------------------
	//
	// ------------------------------------------------------------------------------------
	function IsWallBehind(item,dir)
	{

		this.chk_dir = dir
		local contact = SceneCollisionRaytrace(g_scene, this.pos+Vector(0,0.5,0),this.chk_dir, -1, CollisionTraceAll, Mtr(1)); 
		
		if (contact.hit)
		{
			this.is_blocked = contact.hit 
			
		}
		else
		{
			this.is_blocked = false
		}


		if (is_on_target)
		{
			//this.is_blocked = true
		}

		return this.is_blocked
	}

	// ------------------------------------------------------------------------------------
	// Check target position - on target place
	// ------------------------------------------------------------------------------------
	function OnEnterTrigger(item, trigger_item)
	{
		local targte_name = ItemGetName(trigger_item)
		
		print(targte_name)

		if(targte_name=="target_position_trigger")
		{
			is_on_target = true;
			print("SOURCE CUBE is on PLACE")
		}

	}


	// ------------------------------------------------------------------------------------
	// Check target position - remove from target place
	// ------------------------------------------------------------------------------------
	function OnExitTrigger(item, trigger_item)
	{
		local targte_name = ItemGetName(trigger_item)
		

		if(targte_name=="target_position_trigger")
		{
			is_on_target = false;
		}

	}

	// ------------------------------------------------------------------------------------
	// Move up with Lift
	// ------------------------------------------------------------------------------------
	function MoveUp()
	{
		print("WALL : Move UP")
		if (ItemIsCommandListDone(this._item))
		{
				ItemSetCommandList(this._item, "offsetposition 0.5,0,1,0;")

		}

	}

	// ------------------------------------------------------------------------------------
	// Move down with Lift
	// ------------------------------------------------------------------------------------
	function MoveDown()
	{
		print("WALL : Move DOWN")
		if (ItemIsCommandListDone(this._item))
		{
			ItemSetCommandList(this._item, "offsetposition 0.5,0,-1,0;")
		}

	}

}
