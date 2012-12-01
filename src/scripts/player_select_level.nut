/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/player_select_level.nut
	Author: AndyGFX
*/

Include("Scripts/globals.nut") 

class	player_select_level
{


	is_obstacle = false
	level_done = false;
	angle_y = 0;
	item_forward = 0
	move_step_size = 1.0
	move_duration = 0.5
	shift_item = null;
	shift_enable = false
	shift_name = "noname"	
	item_name = "Player"
	
	port_enabled = false;
	port_pos = ""

	stay_on_level_ID = 0;
	old_level_ID = -1
	icon_scene = 0
	
	InputKey = 0; // TKeyboard();

	// ------------------------------------------------------------------------------------
	// Constructor
	// ------------------------------------------------------------------------------------

	constructor()
	{
		InputKey = TKeyboard();
		this.item_forward = Vector(0.0,0.0,1.0)
	}
	
	// ------------------------------------------------------------------------------------
	// OnUpdate()
	// - Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------

	function	OnUpdate(player)
	{

		KeyboardUpdate() 

		// update pushed ITEM position

		if ((this.shift_enable==true) && (port_enabled==false))
		{			
			ItemGetScriptInstance(this.shift_item).SetPosition(this.shift_item,ItemGetPosition(player)+item_forward)
			
		}

		if (ItemIsCommandListDone(player))
		{
			
			this.GetLevelInfo(player)

			// escape to menu			
			if (this.InputKey.IsUp(KeyEscape))
			{
					g_game_command = "CLOSE_LEVEL"
			}
			
			if (this.InputKey.IsDown(KeySpace))
			{
				g_current_id = this.stay_on_level_ID
				g_game_command = "LOAD_LEVEL"
				g_sfx_menu_use.Play()
			}

			// MOVE FORWARD			
			if (this.InputKey.IsDown(KeyUpArrow))
			{
				g_sfx_menu_move.Play()
				
				// generate command for forwar (Axis Z) movement
				local cmd = this.SetMoveDirection(player)

				// is wall behind player?
				if (!IsObstacleBehind(player))
				{
					

					if ((this.shift_enable==true) && (port_enabled==false))
					{				
						local bWall = ItemGetScriptInstance(this.shift_item).IsWallBehind(this.shift_item,this.item_forward)	

						if (!bWall)
						{
							this.shift_enable==false		
							ItemSetCommandList(player, "offsetposition " + PSpeedMul(0.5) + ","+cmd+";")
							ItemSetCommandList(this.shift_item, "offsetposition " + PSpeedMul(0.5) + ","+cmd+";")
						}
					}
					else
					{
						this.shift_enable==false
						ItemSetCommandList(player, "offsetposition " + PSpeedMul(0.5) + ","+cmd+";")
					}
				}	
			}			
			
			// TURN BACKWARD
			if (this.InputKey.IsDown(KeyDownArrow))
			{
				this.TurnBack();
				ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+","+move_step_size+";")
			
			}
			
			// TURN LEFT
			if (this.InputKey.IsDown(KeyLeftArrow))
			{
				this.TurnLeft();
				ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
			}

			// TURN RIGHT
			if (this.InputKey.IsDown(KeyRightArrow))
			{
				this.TurnRight()
				ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
			}
			
			
		}

	}

	// ------------------------------------------------------------------------------------
	// OnSetup()
	// - Called when the item is about to be setup.
	// ------------------------------------------------------------------------------------

	function	OnSetup(item)
	{
		ItemSetName(item,this.item_name)	
		this.icon_scene = title_screen_level_preview()
		//UISetCommandList(SceneGetUI(g_scene) , "globalfade 0, 1; nop 1 ; globalfade 1.15, 0;")
	}  

	// ------------------------------------------------------------------------------------
	// Set move direction from transformation matrix
	// ------------------------------------------------------------------------------------

	function SetMoveDirection(item)
	{
		//local item_matrix = ItemGetMatrix(item);
		item_forward = ItemGetMatrix(item).GetFront();//item_matrix.GetRow(2);
		local dir = (item_forward.x+","+item_forward.y+","+item_forward.z);
		return dir;
	}

	// ------------------------------------------------------------------------------------
	// turn player RIGHT
	// ------------------------------------------------------------------------------------

	function TurnRight()
	{
		g_sfx_menu_turn.Play()
		this.shift_enable==false
		this.angle_y = this.angle_y + 90;
	}

	// ------------------------------------------------------------------------------------
	// turn player LEFT
	// ------------------------------------------------------------------------------------

	function TurnLeft()
	{
		g_sfx_menu_turn.Play()
		this.shift_enable==false
		this.angle_y = this.angle_y - 90;
	}

	// ------------------------------------------------------------------------------------
	// turn player BACKWARD
	// ------------------------------------------------------------------------------------

	function TurnBack()
	{
		this.shift_enable==false
		this.angle_y = this.angle_y - 180;
		g_sfx_menu_turn.Play()
	}

	// ------------------------------------------------------------------------------------
	// return true when exist obstacle behind player
	// ------------------------------------------------------------------------------------

	function IsObstacleBehind(player)
	{
		local item_pos = ItemGetPosition(player)
		local item_matrix = ItemGetMatrix(player);
		local v_forward = item_matrix.GetRow(2);
		local item_dir = clone(v_forward)
		local res = false


		//item_dir.y =  + 0.5
		local contact = SceneCollisionRaytrace(g_scene, item_pos+Vector(0,0.5,0),item_dir, -1, CollisionTraceAll, Mtr(1)); 
		this.shift_enable = false

		if (contact.hit)
		{
				
				res = contact.hit 
			local item_name = ItemGetName(contact.item)

		

		}

		return res
	}

	function GetLevelInfo(player)
	{
		local item_pos = ItemGetPosition(player)
		local item_matrix = ItemGetMatrix(player);
		local v_forward = item_matrix.GetRow(2);
		local item_dir = Vector(0,-1,0)
		local res = false


		//item_dir.y =  + 0.5
		local contact = SceneCollisionRaytrace(g_scene, item_pos+Vector(0,0.5,0),item_dir, -1, CollisionTraceAll, Mtr(1)); 
		
		if (contact.hit)
		{
			this.stay_on_level_ID = ItemGetScriptInstance(contact.item).level_id
			
			if (old_level_ID!=this.stay_on_level_ID)
			{
				// update level infos
				print("Level ID: "+this.stay_on_level_ID)
				old_level_ID=this.stay_on_level_ID
				this.icon_scene.SetImage(this.stay_on_level_ID)
				
			}
		}
		
	}

}
