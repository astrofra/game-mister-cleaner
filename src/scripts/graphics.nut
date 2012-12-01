/*
	File: C:/works/3d/games/svn_mr_cleaner/game_shiftbomber/Scripts/graphics.nut
	Author: Astrofra
*/

//			
function	ProbabilityOccurence(prob_amount)
{
	prob_amount = prob_amount.tofloat()
	if (Rand(0.0,100.0) <= prob_amount)
		return true
	
	return false
}

class 	PotOscillation
{
	pot_handler		=	0
	scene			=	0

	banking_angle	=	0.0
	
	function	OnSetup(item)
	{
		scene = ItemGetScene(item)
		pot_handler = ObjectGetItem(SceneAddObject(scene, "pot_handler"))
		ItemSetPosition(pot_handler, ItemGetPosition(item))
		ItemSetPosition(item, Vector(0,0,0))
		ItemSetParent(item, pot_handler)

		banking_angle = Rand(0, 90)
	}

	function	OnUpdate(item)
	{
		local	_bank = DegreeToRadian(5.0 * sin(banking_angle))
		ItemSetRotation(pot_handler, Vector(_bank, 0, 0))
		banking_angle += (g_dt_frame * 60.0 * 0.05)
	}
}

class 	BubbleEmitter
{
	bubble_list				= 0
	emit_timeout 			= 0.0
	scene 					= 0
	item_original_bubble	= 0
	shake_vector			= 0

	function	OnSetup(item)
	{
		bubble_list = []
		emit_timeout = g_clock + SecToTick(Sec(Rand(0.0,4.0)))
		scene = ItemGetScene(item)
		item_original_bubble = SceneFindItem(scene, "bubble")
		ItemSetPosition(item_original_bubble, Vector(0,-50000,0))
		shake_vector = Vector(0,0,0)
	}

	function	OnUpdate(item)
	{
		if (g_clock - emit_timeout > SecToTick(Sec(4.0 + Rand(0.0,4.0))))
		{
			bubble_list.append(EmitBubble(item))
			emit_timeout = g_clock
		}

		//	Update bubbles positions
		local	bubble, idx
		foreach(bubble in bubble_list)
		{
			ItemSetPosition(bubble, ItemGetPosition(bubble) + Vector(0, Mtr(1.0), 0).Scale(g_dt_frame) + shake_vector.Scale(1.0 * g_dt_frame))
			local	_s_v = Vector(Rand(-1,1),Rand(-0.05,0.15),Rand(-1,1)).Normalize()
			shake_vector = shake_vector.Lerp(0.9, _s_v)
			local	_scale
			_scale = RangeAdjust(ItemGetPosition(bubble).y, 0.0, 3.0, 0.05, 0.25)
			_scale = Clamp(_scale, 0.0, 0.25)
			ItemSetScale(bubble, Vector(_scale,_scale,_scale))
		}

		//	Delete bubbles
		foreach(idx, bubble in bubble_list)
			if (ItemGetPosition(bubble).y > Mtr(10.0))
			{
				SceneDeleteItem(scene, bubble)
				bubble_list.remove(idx)
				return
			}
	}

	function	EmitBubble(item)
	{
		print("BubbleEmitter::EmitBubble()")
		local	new_bubble = SceneDuplicateItem(scene, item_original_bubble)
		ItemSetPosition(new_bubble, ItemGetPosition(item))
		return new_bubble
	}
}

//	Less GPU intensive method.
class	RainDropsFx
{

	drop_list		=	0
	current_drop	=	0

	function OnSetup(item)
	{
		drop_list = []
		drop_list = ItemGetChildList(item)
		
		local	drop_item
		foreach(drop_item in drop_list)
		{
			ItemSetPosition(drop_item, Vector(0,-500000,0))
			ItemSetRotation(drop_item, Vector(0,Rand(0,360),0))
		}
		print("RainDropsFx::Setup() found " + drop_list.len() + " drops.")
	}
	
	function OnUpdate(item)
	{
		local drop_item

		foreach(drop_item in drop_list)
		{
			if (ProbabilityOccurence(50) && ItemIsCommandListDone(drop_item))
			{
				ItemSetPosition(drop_item, Vector(Mtr(Rand(-5.0,5.0)), Mtr(10.0), Mtr(Rand(-5.0,5.0))))
				ItemSetRotation(drop_item, Vector(0,Rand(0,360),0))
				ItemSetCommandList(drop_item, "offsetposition 0,0,0,0;offsetposition 0.1,0,-10.0,0;")
			}
		}
	}
}

//	Use this with the spherical Fx.
//	Not recommended as it seems to drain the GPU
class RainFx
{
	rot = 0.0
	
	function OnSetup(item)
	{
		print("RainFx setup")
		rot = 0.0
	}
	
	function OnUpdate(item)
	{
		rot += Deg(25.12545 * 60.0 * g_raw_dt_frame)
		ItemSetRotation(item, Vector(rot,0,0))
	}
}

class 	ChainApplyCyclicForce
{
	angle				=	0
	wind_dir			=	0

	function	OnSetup(item)
	{
		wind_dir = Vector(Rand(-1.0, 1.0), Rand(-1.0, 1.0) * 0.2, Rand(-1.0, 1.0)).Normalize()
	}

	function	OnUpdate(item)
	{
		local	_s = sin(angle) * ItemGetMass(item)
		ItemApplyLinearForce(item, wind_dir.Scale(_s))
		angle += (g_dt_frame * 60.0 * DegreeToRadian(0.5))
	}

}

/*!
	@short	PotLampAnimation
	@author	Astrofra
*/

class 	PotLampAnimation
{
	
	item_handler		=	0
	banking_angle		=	0.0

	item_pot_handler	=	0

	function	OnSetup(item)
	{
		item_handler = item
		item_pot_handler = ItemGetChild(item_handler, "pot_handler")
		banking_angle = Rand(0.0, 180.0)
	}

	function	OnUpdate(item)
	{

		local	_bank = DegreeToRadian(5.0 * sin(banking_angle))
		ItemSetRotation(item_handler, Vector(_bank, 0, 0))
		banking_angle += (g_dt_frame * 60.0 * 0.05)

		local	_scale	=	(1.0 + sin(banking_angle)) * (1.0 + cos(banking_angle * 2.0)) / 5.0
		ItemSetScale(item_handler, Vector(1, 1.0 + _scale, 1))
		ItemSetScale(item_pot_handler, Vector(1, 1.0 / (1.0 + _scale), 1))
	}
}

/*!
	@short	GameBlockSlightRotation
	@author	Astrofra
*/

class	GameBlockSlightRotation
{
	function	OnSetup(item)
	{
		local	item_rotation
		item_rotation = ItemGetRotation(item)
		
		//	Rotate the block 90 degrees around the Y axis (or 180, or 270...)
		item_rotation.y += DegreeToRadian(90.0 * Irand(0,4))
		
		//	On some of the blocks, adds a slight rotation on the Y axis.
		local	_sgn = ProbabilityOccurence(50.0)?1.0:-1.0
		if (ProbabilityOccurence(80.0))
			item_rotation.y += DegreeToRadian(Rand(0.5,1.5) * _sgn)
		if (ProbabilityOccurence(30.0))
			item_rotation.y += DegreeToRadian(Rand(1.0,2.0) * _sgn)
		if (ProbabilityOccurence(5.0))
			item_rotation.y += DegreeToRadian(Rand(1.0,2.0) * _sgn)

		ItemSetRotation(item, item_rotation)
	}
}

class	TitleWheelRotation
{

	angle				=	0

	function	OnUpdate(item)
	{
		ItemSetRotation(item, Vector(DegreeToRadian(angle), DegreeToRadian(90.0), 0))
		angle += (g_dt_frame * 60.0 * -0.5)
	}
}

class	SteamWheelRotation
{

	angle				=	0

	function	OnUpdate(item)
	{
		ItemSetRotation(item, Vector(0, 0, DegreeToRadian(angle)))
		angle += (g_dt_frame * 60.0 * 2.0)
	}
}

/*!
	@short	TreeOscillation
	@author	Astrofra
*/

class	TreeOscillation
{

	initial_scale		=	0
	angle				=	0

	function	OnUpdate(item)
	{
		local	x,y,z,m
		m = 0.005 * (1.0 + sin(DegreeToRadian(angle * 0.35)))
		x = 1.25 * ((1.0 + sin(DegreeToRadian(angle * 0.95 + 45.0))) * (0.01 + m))
		y = 1.25 * ((1.0 + sin(DegreeToRadian(angle * 2.5))) * 0.00125)
		z = 1.25 * ((1.0 + sin(DegreeToRadian(angle * 1.05 + 90.0))) * (0.01 + m))
		ItemSetScale(item, initial_scale + Vector(x, y, z))

		angle += (g_dt_frame * 60.0 * 1.5)
	}

	function	OnSetup(item)
	{
		initial_scale = ItemGetScale(item)
		angle += Rand(-90.0,90.0)
	}
}

/*!
	@short	GrassOscillation
	@author	Astrofra
*/

class	GrassOscillation
{

	initial_scale		=	0
	angle				=	0

	function	OnUpdate(item)
	{
		local	x,y,z,m
		m = 0.005 * (1.0 + sin(DegreeToRadian(angle * 0.35)))
		x = 0.125 * ((1.0 + sin(DegreeToRadian(angle * 0.95 + 45.0))) * (0.01 + m))
		y = 2.0 * ((1.0 + sin(DegreeToRadian(angle * 2.5))) * 0.0125)
		z = 0.125 * ((1.0 + sin(DegreeToRadian(angle * 1.05 + 90.0))) * (0.01 + m))
		ItemSetScale(item, initial_scale + Vector(x, y, z))

		angle += (g_dt_frame * 60.0 * 1.5)
	}

	function	OnSetup(item)
	{
		initial_scale = ItemGetScale(item)
		angle += Rand(-90.0,90.0)
	}
}

class	SteamRodOscillation
{

	initial_position	=	0
	angle				=	0

	function	OnUpdate(item)
	{
		local	y
		y = Mtr(1.25) * ((1.0 + sin(DegreeToRadian(angle))) * 0.5)
		ItemSetPosition(item, initial_position + Vector(0, y, 0))

		angle += (g_dt_frame * 60.0 * 2.0)
	}

	function	OnSetup(item)
	{
		initial_position = ItemGetPosition(item)
	}
}

/*!
	@short	ParticleLayerOscillation
	@author	Astrofra
*/
class	ParticleLayerOscillation
{

	initial_rotation		=	0
	angle					=	0
	rand_factor				=	1.0

	function	OnUpdate(item)
	{
		
		local	new_rotation, item_alpha
		new_rotation = clone(initial_rotation)

		new_rotation.y += DegreeToRadian(25.0 * sin(DegreeToRadian((angle * rand_factor * 0.517654) + (initial_rotation.y * 0.5))))
		ItemSetRotation(item, new_rotation)

		//item_alpha = (1.0 + sin(DegreeToRadian((angle * rand_factor * 2.512765) + (initial_rotation.y * 0.5)))) * 0.5
		//ItemSetAlpha(item, item_alpha)

		angle += (g_dt_frame * 60.0 * 0.15)
	}

	function	OnSetup(item)
	{
		initial_rotation = ItemGetRotation(item)
		rand_factor = Rand(0.5,1.5)
		if (Rand(0.0,100.0) > 50.0)
			rand_factor *= -1.0
	}
}

/*!
	@short	LightHandlerOscillation
	@author	Astrofra
*/
class	LightHandlerOscillation
{

	light_rotation		=	0
	light_position		=	0
	angle				=	0.0

	texture_table		=	0
	texture_index		=	0
	prev_index			=	-1

	function	CreateCausticFrameFilename(idx)
	{
		local	fname
		fname = "graphics/sequence/caustics/frame_" + idx.tostring() + ".jpg"
		//print("LightHandlerOscillation::CreateCausticFrameFilename() : fname = " + fname)
		return fname
	}

	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		texture_index = Mod((g_clock / 1000.0 * 1.25).tointeger(), 11)

		if (prev_index != texture_index)
		{
			try	{
				LightSetProjectionTexture(ItemCastToLight(item), CreateCausticFrameFilename(texture_index))
			}
			catch(e)	{}
			CreateCausticFrameFilename(texture_index)
		}

		prev_index = texture_index

		light_rotation.z = DegreeToRadian(2.0 * sin(DegreeToRadian(angle * 0.5)))
		light_rotation.x = DegreeToRadian(0.125 * sin(DegreeToRadian(angle + 45.0)))
		ItemSetRotation(item, light_rotation)

		light_position.z = Mtr(1.0 * sin(DegreeToRadian((angle * 0.75) - 45.0)))
		ItemSetPosition(item, light_position)

		angle += (g_dt_frame * 60.0)
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		light_rotation = Vector(0,0,0)
		light_position = Vector(0,0,0)
		texture_table = array(11,0)
		texture_index = 0
		prev_index = -1
	}
}
