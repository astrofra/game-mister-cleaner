// game score globals


g_level_name <- array(49)

g_levels <- {}

g_file <- TIO_metadata()

g_RESET <- 0;

for(local i=0;i<49;i++)
{
	g_level_name[i]="level_"+i
	g_levels.rawset("level_"+i,{})
}


function ResetLevels()
{
	if (g_RESET==0)
	{
		g_file.Load("mr_cleaner.txt")
	}
	
	g_file.CreateRoot("Levels")
	
	
	for(local i=0;i<49;i++)
	{
		local child = g_file.CreateChild(g_level_name[i])
		g_file.AddChildValue(child,"name","<noname>")
		g_file.AddChildValue(child,"filename","scenes/"+g_level_name[i]+".nms")
		g_file.AddChildValue(child,"iconname","textures/levels/"+g_level_name[i]+".png")
		g_file.AddChildValue(child,"world_id","1")
		g_file.AddChildValue(child,"stage_id","1")
		g_file.AddChildValue(child,"g_score_time",0)
		g_file.AddChildValue(child,"g_score_steps",0)
		g_file.AddChildValue(child,"g_score_turn_left",0)
		g_file.AddChildValue(child,"g_score_turn_right",0)
		g_file.AddChildValue(child,"g_score_turn_back",0)
		g_file.AddChildValue(child,"sfx_turn","Sounds/sfx/robot_movement_1.wav|Sounds/sfx/robot_movement_9.wav|Sounds/sfx/robot_movement_6.wav")
		g_file.AddChildValue(child,"sfx_move","Sounds/sfx/robot_movement_1.wav|Sounds/sfx/robot_movement_9.wav|Sounds/sfx/robot_movement_6.wav")
		g_file.AddChildValue(child,"sfx_use","Sounds/sfx/sci_fi_computer_console_tone_2.wav")
		g_file.AddChildValue(child,"sfx_teleport_in","Sounds/sfx/sfx_teleport.wav")
		g_file.AddChildValue(child,"sfx_teleport_out","Sounds/sfx/sfx_teleport.wav")
		g_file.AddChildValue(child,"sfx_move_object","sfx_5.wav")
		g_file.AddChildValue(child,"sfx_lift_up","Sounds/sfx/sfx_lift_up.wav")
		g_file.AddChildValue(child,"sfx_lift_down","Sounds/sfx/sfx_lift_up.wav")
		g_file.AddChildValue(child,"sfx_switch","Sounds/sfx/gui_up_down.wav")
		g_file.AddChildValue(child,"sfx_move_blocked","sfx_9.wav")
		g_file.AddChildValue(child,"sfx_action","Sounds/sfx/sfx_explosion.wav")
		g_file.AddChildValue(child,"sfx_reaction","sfx_11.wav")
		g_file.AddChildValue(child,"sfx_var1","sfx_12.wav")
		g_file.AddChildValue(child,"sfx_var2","sfx_13.wav")
		g_file.AddChildValue(child,"sfx_var3","sfx_14.wav")
		g_file.AddChildValue(child,"sfx_var4","sfx_15.wav")
		g_file.AddChildValue(child,"sfx_var5","sfx_16.wav")
		g_file.AddChildValue(child,"music_bkg","Sounds/music/music_native_mistery.ogg")
		g_file.AddChildValue(child,"done",false)
		
		
	}
	
	g_file.Save("mr_cleaner.txt.reset")
}

if (g_RESET==1)
{
	ResetLevels()
}

function LoadLevels()
{
	
	g_file.Load("mr_cleaner.txt")	

	for (local i=0;i<49;i++)
	{
		
		g_levels[g_level_name[i]] =
		{
			name 				= g_file.GetValue("Levels:"+g_level_name[i]+":name")
			filename 			= g_file.GetValue("Levels:"+g_level_name[i]+":filename")
			iconname 			= g_file.GetValue("Levels:"+g_level_name[i]+":iconname")
			world_id 			= g_file.GetValue("Levels:"+g_level_name[i]+":world_id")
			stage_id 			= g_file.GetValue("Levels:"+g_level_name[i]+":stage_id")
			g_score_time 		= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_time")
			g_score_steps 		= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_steps")
			g_score_turn_left 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_left")
			g_score_turn_right 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_right")
			g_score_turn_back 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_back")
			done 				= g_file.GetValue("Levels:"+g_level_name[i]+":done")
			
			// Load sound definition
			sfx_turn			= g_file.GetValue("Levels:"+g_level_name[i]+":sfx_turn")						
			sfx_move          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_move")                  
			sfx_use           = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_use")                   
			sfx_teleport_in   = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_teleport_in")
			sfx_teleport_out  = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_teleport_out")
			sfx_move_object   = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_move_object")           
			sfx_lift_up       = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_lift_up")
			sfx_lift_down     = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_lift_down")
			sfx_switch        = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_switch")
			sfx_move_blocked  = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_move_blocked")
			sfx_action        = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_action")
			sfx_reaction      = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_reaction")
			sfx_var1          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_var1")
			sfx_var2          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_var2")
			sfx_var3          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_var3")
			sfx_var4          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_var4")
			sfx_var5          = g_file.GetValue("Levels:"+g_level_name[i]+":sfx_var5")
			music_bkg         = g_file.GetValue("Levels:"+g_level_name[i]+":music_bkg")
		}
	}	
	
	
	
}

function GetLevelInfo()
{
	local i = g_current_id
	g_score_time 		= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_time")
	g_score_steps 		= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_steps")
	g_score_turn_left 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_left")
	g_score_turn_right 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_right")
	g_score_turn_back 	= g_file.GetValue("Levels:"+g_level_name[i]+":g_score_turn_back") 	
	
}

function SaveLevels()
{
	g_file.Save("mr_cleaner.txt")
	print("SAVE result")
}

function UpdateScore()
{
	local i = g_current_id
	g_file.SetChildValue("Levels:",g_level_name[i],"g_score_time",g_score_time)
	g_file.SetChildValue("Levels:",g_level_name[i],"g_score_steps",g_score_steps)
	g_file.SetChildValue("Levels:",g_level_name[i],"g_score_turn_left",g_score_turn_left)
	g_file.SetChildValue("Levels:",g_level_name[i],"g_score_turn_right",g_score_turn_right)
	g_file.SetChildValue("Levels:",g_level_name[i],"g_score_turn_back",g_score_turn_back)
	g_file.SetChildValue("Levels:",g_level_name[i],"done",true)
	
	SaveLevels()
}

//LoadLevels()