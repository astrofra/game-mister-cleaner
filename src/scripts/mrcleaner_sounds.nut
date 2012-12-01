
g_sfx_turn			<- TSoundFX();
g_sfx_move          <- TSoundFX();
g_sfx_use           <- TSoundFX();
g_sfx_teleport_in   <- TSoundFX();
g_sfx_teleport_out  <- TSoundFX();
g_sfx_move_object   <- TSoundFX();
g_sfx_lift_up       <- TSoundFX();
g_sfx_lift_down     <- TSoundFX();
g_sfx_switch        <- TSoundFX();
g_sfx_move_blocked  <- TSoundFX();
g_sfx_action        <- TSoundFX();
g_sfx_reaction      <- TSoundFX();
g_sfx_var1          <- TSoundFX();
g_sfx_var2          <- TSoundFX();
g_sfx_var3          <- TSoundFX();
g_sfx_var4          <- TSoundFX();
g_sfx_var5          <- TSoundFX();
g_music_bkg         <- TMusic();

g_sfx_menu_up		<- TSoundFX();
g_sfx_menu_down		<- TSoundFX();
g_sfx_menu_enter	<- TSoundFX();
g_sfx_menu_escape	<- TSoundFX();

g_sfx_menu_move 	<- TSoundFX()
g_sfx_menu_turn 	<- TSoundFX()
g_sfx_menu_use 	<- TSoundFX()

function LoadMenuSounds()
{

	g_sfx_menu_up.Create("Sounds/sfx/gui_up_down.wav")
	g_sfx_menu_down.Create("Sounds/sfx/gui_up_down.wav")
	g_sfx_menu_enter.Create("Sounds/sfx/gui_validate.wav")
	g_sfx_menu_escape.Create("Sounds/sfx/gui_validate.wav")

	g_sfx_menu_move.Create("Sounds/sfx/robot_movement_1.wav")
	g_sfx_menu_turn.Create("Sounds/sfx/robot_movement_1.wav")
	g_sfx_menu_use.Create("Sounds/sfx/gui_validate.wav")
	
}

function ReloadSounds(id)
{
	
	
	g_sfx_turn.Create( 			g_levels[g_level_name[id]].sfx_turn)			 
	g_sfx_move.Create( 			g_levels[g_level_name[id]].sfx_move)           
	g_sfx_use.Create( 			g_levels[g_level_name[id]].sfx_use)            
	g_sfx_teleport_in.Create( 	g_levels[g_level_name[id]].sfx_teleport_in)    
	g_sfx_teleport_out.Create( 	g_levels[g_level_name[id]].sfx_teleport_out)   
	g_sfx_move_object.Create( 	g_levels[g_level_name[id]].sfx_move_object)    
	g_sfx_lift_up.Create( 		g_levels[g_level_name[id]].sfx_lift_up)        
	g_sfx_lift_down.Create( 	g_levels[g_level_name[id]].sfx_lift_down)      
	g_sfx_switch.Create( 		g_levels[g_level_name[id]].sfx_switch)         
	g_sfx_move_blocked.Create( 	g_levels[g_level_name[id]].sfx_move_blocked)   
	g_sfx_action.Create( 		g_levels[g_level_name[id]].sfx_action)         
	g_sfx_reaction.Create( 		g_levels[g_level_name[id]].sfx_reaction)       
	g_sfx_var1.Create( 			g_levels[g_level_name[id]].sfx_var1)           
	g_sfx_var2.Create( 			g_levels[g_level_name[id]].sfx_var2)           
	g_sfx_var3.Create( 			g_levels[g_level_name[id]].sfx_var3)           
	g_sfx_var4.Create( 			g_levels[g_level_name[id]].sfx_var4)           
	g_sfx_var5.Create( 			g_levels[g_level_name[id]].sfx_var5)           
	
	g_music_bkg.Create( 		g_levels[g_level_name[id]].music_bkg)		
	g_music_bkg.PlayMusic();
}