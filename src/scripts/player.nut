/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/player.nut
	Author: AndyGFX
*/

Include("Scripts/globals.nut") 

class	Player
{


	/*<
	<Script =
	  <Name = "player.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for player control and moving obstacles logic.">
	>
	<Parameter =
	  <finish_count_dst = <Name = "Moveable wall count"> <Description = "Set wall count to finish game"> <Type = "Int"> <Default = 0>>
	  <debug_level_f5 = <Name = "Test level"> <Description = "Execute level with [F5]"> <Type = "Bool"> <Default = False>>
	>
	>*/ 
	
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
	finish_count_src = 0
	finish_count_dst = 2
	debug_level_f5 = false
	port_enabled = false;
	port_pos = ""
	replay = false
	
	start_time = 0;

	score = 0; //TGameScore();
	HUD = 0; //TGameHud();
	game_state = "RESULT"
	
	InputKey = 0; //TKeyboard();
	
	// ------------------------------------------------------------------------------------
	// Constructor
	// ------------------------------------------------------------------------------------

	constructor()
	{
		if (this.debug_level_f5==false)
		{
			score = TGameScore();
			HUD = TGameHud();	
		}
		InputKey = TKeyboard();
	
		this.item_forward = Vector(0.0,0.0,1.0)
		
		if (replay==false)
		{
			RECORD.Initialize(g_current_id)
		}
		
		if (RECORD.Exist(g_current_id))
		{
			this.HUD.HUD_rec_icon.Show()	
		}
		else
		{
			this.HUD.HUD_rec_icon.Hide()	
		}
	}
	
	// ------------------------------------------------------------------------------------
	// OnUpdate()
	// - Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------
	function	OnUpdate(player)
	{
		
		if (this.replay == true)
		{
			this.OnUpdateByReplay(player)
		}
		else
		{
			this.OnUpdateByPlayer(player)	
		}
	}
	
	// ------------------------------------------------------------------------------------
	// Update by player control
	// - Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------

	function	OnUpdateByPlayer(player)
	{
		
		if (this.game_state=="PLAY")
		{
			g_score_time = SystemGetClock() - this.start_time
			
			if (this.debug_level_f5==false)
			{
				this.HUD.SetTimeInfo()
			}
			
			KeyboardUpdate() 
	
			// update pushed ITEM position
	
			if ((this.shift_enable==true) && (port_enabled==false))
			{			
				ItemGetScriptInstance(this.shift_item).SetPosition(this.shift_item,ItemGetPosition(player)+item_forward)
				
			}
	
			this.AreMoveCubeOnRightPlaces()
			
			if (ItemIsCommandListDone(player))
			{
				this.AreMoveCubeOnRightPlaces()
	
	
				// escape to menu
				if	(this.InputKey.IsUp(KeyEscape)) 
				{
						//g_game_command = "CLOSE_LEVEL"
						this.HUD.PAUSE.Show()
						this.game_state = "PAUSE"
				}
	
				// MOVE FORWARD				
				if (this.InputKey.IsDown(KeyUpArrow))
				{
					RECORD.AddMoveCommand("MOVE_FORWARD")
					if (this.debug_level_f5==false)
					{
						g_sfx_move.Play()
					}
					
					if (this.debug_level_f5==false)
					{
						this.HUD.SetTurnInfo(this.score.GetCount())
					}
					//this.score.PrintInfo();
					
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
								this.score.AddStep();
							}
						}
						else
						{
							this.shift_enable==false
							ItemSetCommandList(player, "offsetposition " + PSpeedMul(0.5) + ","+cmd+";")
							this.score.AddStep();
						}
					}	
				}			
				
				//this.shift_enable=false
				
				// ONLY FOR DENUG REPLAY
				if (this.InputKey.IsDown(KeyF9))
				{
					this.HUD.ShowResult()				
					this.HUD.MENU.Show();
					game_state = "RESULT"
				}
				
				// TURN BACKWARD
				if (this.InputKey.IsDown(KeyDownArrow))
				{
					RECORD.AddMoveCommand("MOVE_BACKWARD")
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnBack();
					ItemSetCommandList(player, "torotation "+ PSpeedMul(move_duration) +",0,"+this.angle_y+","+move_step_size+";")
				
				}
				
				// TURN LEFT
				if (this.InputKey.IsDown(KeyLeftArrow))
				{
					RECORD.AddMoveCommand("TURN_LEFT")
					
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnLeft();
					ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
				}
	
				// TURN RIGHT
				if (this.InputKey.IsDown(KeyRightArrow))
				{
					RECORD.AddMoveCommand("TURN_RIGHT")
					
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnRight()
					ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
				}
				
				// EXPLODE BOMB
				if (this.InputKey.IsDown(KeySpace))
				{
					RECORD.AddMoveCommand("USE")
					this.TryIgnitionBomb(player)				
				}
	
				// PORTAL TRANSFER
				if (port_enabled)
				{
					ItemSetCommandList(player,"toalpha " + PSpeedMul(0.5) + ",0.0; toposition 0, "+this.port_pos+" ; toalpha " + PSpeedMul(0.5) + ",1.0; ");
					port_enabled = false;
				}
			}
		}
		
		if (this.game_state=="PAUSE_OFF")
		{
			
			this.HUD.PAUSE.Hide()
			this.game_state="PLAY"
			
		}
		
		if (this.game_state=="PAUSE")
		{
			this.HUD.PAUSE.OnUpdate()
			
			if	(this.InputKey.IsUp(KeyEscape))
			{
				this.HUD.PAUSE.Hide()
				this.game_state="PLAY"
			}
		}
		
		if (this.game_state=="RESULT")
		{
			if (this.debug_level_f5==false)
			{
				this.HUD.MENU.OnUpdate()
			}
			
			if	(this.InputKey.IsUp(KeyEscape))
			{				
				g_game_command = "SELECT_LEVEL"
			}
			
		}
	}

	// ------------------------------------------------------------------------------------
	// Update by replay control
	// - Called during the scene update, each frame.
	// ------------------------------------------------------------------------------------

	function	OnUpdateByReplay(player)
	{
		local cmd = ""
		
		if (this.game_state=="PLAY")
		{
			
			if (this.debug_level_f5==false)
			{
				this.HUD.ShowLevelTime()
			}
			
			KeyboardUpdate() 
	
			// update pushed ITEM position
	
			if ((this.shift_enable==true) && (port_enabled==false))
			{			
				ItemGetScriptInstance(this.shift_item).SetPosition(this.shift_item,ItemGetPosition(player)+item_forward)
				
			}
	
			this.AreMoveCubeOnRightPlaces()
			
			if (ItemIsCommandListDone(player))
			{
				
				//if	(this.InputKey.IsUp(KeyF1)) 
				//{
				//   cmd = RECORD.GetNextCommand(g_current_id)
				//}
				
				if (port_enabled == false)
				{
					cmd = RECORD.GetNextCommand(g_current_id)
					print("REPLAY: "+cmd)
				}
				
				
				
				this.AreMoveCubeOnRightPlaces()
	
	
				// escape to menu
				if	(this.InputKey.IsUp(KeyEscape)) 
				{
						//g_game_command = "CLOSE_LEVEL"
						this.HUD.PAUSE.Show()
						this.game_state = "PAUSE"
				}
	
				// MOVE FORWARD				
				if (cmd=="MOVE_FORWARD")
				{
										
					if (this.debug_level_f5==false)
					{
						g_sfx_move.Play()
						
					}
					//this.score.PrintInfo();
					
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
				
				//this.shift_enable=false
				
				// TURN BACKWARD
				if (cmd=="MOVE_BACKWARD")
				{
					
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnBack();
					ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+","+move_step_size+";")
				
				}
				
				// TURN LEFT
				if (cmd=="TURN_LEFT")
				{
					
					
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnLeft();
					ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
				}
	
				// TURN RIGHT
				if (cmd=="TURN_RIGHT")
				{
					
					
					if (this.debug_level_f5==false)
					{
						g_sfx_turn.Play()
					}
					this.TurnRight()
					ItemSetCommandList(player, "torotation " + PSpeedMul(move_duration) + ",0,"+this.angle_y+",0;")
				}
				
				// EXPLODE BOMB
				if (cmd=="USE")
				{
					
					this.TryIgnitionBomb(player)				
				}
	
				// PORTAL TRANSFER
				if (port_enabled)
				{
					ItemSetCommandList(player,"toalpha " + PSpeedMul(0.5) + ",0.0; toposition 0, "+this.port_pos+" ; toalpha 0.5,1.0; ");
					port_enabled = false;
				}
			}
		}
		
		if (this.game_state=="PAUSE_OFF")
		{
			
			this.HUD.PAUSE.Hide()
			this.game_state="PLAY"
			
		}
		
		if (this.game_state=="PAUSE")
		{
			this.HUD.PAUSE.OnUpdate()
			
			if	(this.InputKey.IsUp(KeyEscape))
			{
				this.HUD.PAUSE.Hide()
				this.game_state="PLAY"
			}
		}
		
		if (this.game_state=="RESULT")
		{
			if (this.debug_level_f5==false)
			{
				this.HUD.MENU.OnUpdate()
			}
			
			if	(this.InputKey.IsUp(KeyEscape))
			{				
				g_game_command = "SELECT_LEVEL"
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
		
		if (this.replay == false)
		{
			
			this.score.Reset()
			
			if (this.debug_level_f5==false)
			{
				this.HUD.Initialize()	
			}
			
			this.start_time = SystemGetClock();
		}
		
		this.game_state="PLAY"
		
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
		if (this.replay == false)
		{
			this.score.AddTurnRight();
			if (this.debug_level_f5==false)
			{
				this.HUD.SetTurnInfo(this.score.GetCount())
			}
		}
		
		this.shift_enable==false
		this.angle_y = this.angle_y + 90;
	}

	// ------------------------------------------------------------------------------------
	// turn player LEFT
	// ------------------------------------------------------------------------------------

	function TurnLeft()
	{
		if (this.replay == false)
		{
			this.score.AddTurnLeft();
		
			if (this.debug_level_f5==false)
			{
				this.HUD.SetTurnInfo(this.score.GetCount())
			}
		}
		
		this.shift_enable==false
		this.angle_y = this.angle_y - 90;
	}

	// ------------------------------------------------------------------------------------
	// turn player BACKWARD
	// ------------------------------------------------------------------------------------

	function TurnBack()
	{
		if (this.replay == false)
		{
			
			this.score.AddTurnBackward();
		
			if (this.debug_level_f5==false)
			{
				this.HUD.SetTurnInfo(this.score.GetCount())
			}
		}
		this.shift_enable==false
		this.angle_y = this.angle_y - 180;
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

			// ignore 			
			// check source cube
			if (item_name=="portal_place")
			{
				res = false
			}

			if (item_name=="moveable_wall")
			{
				this.shift_enable = true
				this.shift_item = contact.item
				res = false
				this.shift_name = item_name
			}
			
			// check bomb
			if (item_name=="bomb")
			{
				this.shift_enable = true
				this.shift_item = contact.item
				res = false
				this.shift_name = item_name
			}

		}

		return res
	}

	// ------------------------------------------------------------------------------------
	// Check if all cubes on places
	// ------------------------------------------------------------------------------------
	function AreMoveCubeOnRightPlaces()
	{
		local item_list = SceneGetItemList(g_scene)	
		
		this.finish_count_src = 0
		
		foreach (item in item_list) 
		{
			local name =ItemGetName(item)
			
			if (name=="moveable_wall")
			{
				
				local state = ItemGetScriptInstance(item).is_on_target
				local schecked = ItemGetScriptInstance(item).was_schecked

				if ((state==true) && (schecked==false))
				{
					//ItemGetScriptInstance(item).was_schecked = true
					this.finish_count_src++
				}
				
			}
			
		}

		if (this.debug_level_f5==false)
		{
			HUD.SetGoalInfo(this.finish_count_src,this.finish_count_dst)
		}

		if (this.debug_level_f5==false)
		{
			if (this.finish_count_src == this.finish_count_dst)
			{
	
				print("LEVEL DONE")
				this.level_done = true;
				
				if (this.replay == false)
				{
					UpdateScore()			
					this.RECORD.Save(g_current_id)
				}
				else
				{
					GetLevelInfo()
				}
				
				this.HUD.ShowResult()
				
				this.HUD.MENU.Show();
				
				
				
				this.game_state = "RESULT"
				
				// change to show score and switch back to select level
				//g_game_command = "SELECT_LEVEL"
			}
		}
			
	}
	// ------------------------------------------------------------------------------------
	// Try ignition bomb
	// ------------------------------------------------------------------------------------
	
	function TryIgnitionBomb(player)
	{
		local contact = GetHitItem(player.position(),ItemGetMatrix(player).GetFront(),1,CollisionTraceAll);
		if (contact.hit)
		{
			local name =contact.item.name();
			print(name)
			if (name=="bomb")
			{
				this.shift_enable = ItemGetScriptInstance(contact.item).ExplodeStart(contact.item)
				
			}
		}	
	}
	

	// ------------------------------------------------------------------------------------
	// On Enter trigger
	// ------------------------------------------------------------------------------------
	function	OnEnterTrigger(item, trigger_item)
	{
		print("OnEnterTrigger:")
    	print("Item " + ItemGetName(item) + " is in the trigger " + ItemGetName(trigger_item))

		

		if (ItemGetScriptInstance(trigger_item).classname=="trigger_portal")
		{
			local target_portal_name = ItemGetScriptInstance(trigger_item).target_name

			local target_position = SceneFindItem(g_scene,target_portal_name).position()
			this.port_pos = target_position.x+","+target_position.y+","+target_position.z			
			this.port_enabled = true;
			if (this.debug_level_f5==false)
			{
				g_sfx_teleport_in.Play()
			}
			
		}


		if (ItemGetScriptInstance(trigger_item).classname=="trigger_switch_up")
		{
			local target_switch_name =  ItemGetScriptInstance(trigger_item).target_name
			
			print("Switch UP: "+target_switch_name)

			local switch_item = SceneFindItem(g_scene,target_switch_name)
			local onBoardItem = ItemGetScriptInstance(switch_item).CheckLiftBoard()
			
			if (this.debug_level_f5==false)
			{
				g_sfx_switch.Play()
			}
			
			if (onBoardItem!=null)
			{
				if (ItemGetScriptInstance(switch_item).GetState()=="down")
				{
					ItemGetScriptInstance(onBoardItem).MoveUp()
				}
			}


			
			ItemGetScriptInstance(switch_item).MoveUp()

		}

		if (ItemGetScriptInstance(trigger_item).classname=="trigger_switch_down")
		{

			local target_switch_name =  ItemGetScriptInstance(trigger_item).target_name
			
			print("Switch DOWN: "+target_switch_name)

			local switch_item = SceneFindItem(g_scene,target_switch_name)
			local onBoardItem = ItemGetScriptInstance(switch_item).CheckLiftBoard()
			
			if (this.debug_level_f5==false)
			{
				g_sfx_switch.Play()
			}
			
			if (onBoardItem!=null)
			{
				
				if (ItemGetScriptInstance(switch_item).GetState()=="up")
				{
					ItemGetScriptInstance(onBoardItem).MoveDown()
				}
			}	


			ItemGetScriptInstance(switch_item).MoveDown()

		}

	} 


}
