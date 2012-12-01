
/*!
	@short	bomb
	@author	AndyGFX
*/



class func_bomb
{

	pos = 0
	is_blocked = false
	chk_dir = 0
	cmd = ""
	item_name = "bomb"
	bwalls = 0; //[0,0,0,0]
	hide_bomb = false;
	enable = true;

	ui = 0;
	// ------------------------------------------------------------------------------------
	//  Constructor
	// ------------------------------------------------------------------------------------

	constructor()
	{
		bwalls = [0,0,0,0]
		this.pos = Vector(0,0,0)
		this.chk_dir = Vector(0,0,0)

	}
	// ------------------------------------------------------------------------------------
	// OnUpdate()
	// - Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------

	function OnUpdate(item)
	{
		this.pos = ItemGetPosition(item)
	}

	// ------------------------------------------------------------------------------------
	//  Set position
	// ------------------------------------------------------------------------------------

	function SetPosition(item,pos)
	{
		this.pos = pos
		
	}

	// ------------------------------------------------------------------------------------
	//  OnSetup()
	// ------------------------------------------------------------------------------------

	function OnSetup(item)
	{
		this.pos = ItemGetPosition(item)
		ItemSetName(item,this.item_name)
		enable = true;
	}



	// ------------------------------------------------------------------------------------
	//  Is wall behind me?
	// ------------------------------------------------------------------------------------
	function IsWallBehind(item,dir)
	{

		this.chk_dir = dir

		local contact = SceneCollisionRaytrace(g_scene, this.pos,this.chk_dir, -1, CollisionTraceAll, Mtr(1)); 
		
		if (contact.hit)
		{
			this.is_blocked = contact.hit 
			
		}
		else
		{
			this.is_blocked = false
		}

		return this.is_blocked
	}

	// ------------------------------------------------------------------------------------
	//  Explode Bomb
	// ------------------------------------------------------------------------------------
	function ExplodeStart(item)
	{		
		return this.LookAround(item)
	}
	
	// ------------------------------------------------------------------------------------
	//  Check things around
	// ------------------------------------------------------------------------------------
	function LookAround(item)
	{
		print("------------------- ["+ItemGetName(item)+"]\n")
		if (this.enable==true)
		{
			// +Z
			this.bwalls[0] = GetHitItem(ItemGetPosition(item),Vector(0.0,0.0,1.0),1,CollisionTraceAll);
			// -Z
			this.bwalls[1] = GetHitItem(ItemGetPosition(item),Vector(0.0,0.0,-1.0),1,CollisionTraceAll);
			// +X
			this.bwalls[2] = GetHitItem(ItemGetPosition(item),Vector(1.0,0.0,0.0),1,CollisionTraceAll);
			// -X
			this.bwalls[3] = GetHitItem(ItemGetPosition(item),Vector(-1.0,0.0,0.0),1,CollisionTraceAll);
	
			for(local i=0;i<4;i++)
			{
				if (this.bwalls[i].hit) 	
				{
					if (this.bwalls[i].item.name()=="breakable_wall")
					{
						ItemGetScriptInstance(this.bwalls[i].item).ExplodeItem();
						this.hide_bomb=true;
						this.enable = false;
					}
	
				}
			}
	
			if (this.hide_bomb)
			{
				g_sfx_action.Play()
				ItemIsInvisible(item)
				SceneDeleteItem(g_scene,item)
			}
		}
		return !this.hide_bomb
	}

}
