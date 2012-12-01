/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/title_screen.nut
	Author: AndyGFX
*/

Include("Scripts/locale.nut")

/*!
	@short	func_title_screen
	@author	AndyGFX
*/
class	func_title_screen
{
	/*!
		@short	OnUpdate
		Called each frame.
	*/

	menu_buttons = "MAIN";

	project_instance = 0;
	cursor = 0;
	cursor_y=0;//[0,0,0]
	buttons_main = 0;
	buttons_play = 0;
	line_id = 0;
	menu_id = 0;
	visible_pos = 0;//Vector(-0.32,0,-0.363)
	hide_pos = 0;//Vector(-0.32,0,-5)	
	enable_keys = true
	
	InputKey = TKeyboard();
	
	constructor()
	{
		cursor_y=[0,0,0]
		visible_pos = Vector(-0.32,0,-0.363)
		hide_pos = Vector(-0.32,0,-5)
		InputKey = TKeyboard();
	}

	function	OnUpdate(scene)
	{
		if (this.enable_keys)
		{
			KeyboardUpdate() 
			
			if (ItemIsCommandListDone(this.cursor))
			{
				
				if (this.InputKey.IsDown(KeyDownArrow))
				{
					line_id++;
					if (this.line_id>2) { this.line_id = 2; }
					this.MoveCursor()
					g_sfx_menu_down.Play()
				}
		
				
				if (this.InputKey.IsDown(KeyUpArrow))
				{
					line_id--;
					if (this.line_id<0) { this.line_id = 0; }
					this.MoveCursor()
					g_sfx_menu_up.Play()
				}
				
				//if	(IsKeyUp(KeySpace)) 
				if (this.InputKey.IsUp(KeySpace))
				{	
					this.DoMenu()	
					g_sfx_menu_enter.Play()						
				}
			}
		}
	}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
	
		this.cursor = SceneFindItem(g_scene,"title_cursor")
		this.buttons_main = SceneFindItem(g_scene,"Buttons_Main")
		this.buttons_play = SceneFindItem(g_scene,"Buttons_Play")

		
		ItemSetPosition(this.buttons_main,this.visible_pos)
		ItemSetPosition(this.buttons_play,this.hide_pos)

		cursor_y[0] = Vector(-1.399,1.248,-0.369)
		cursor_y[1] = Vector(-1.399,0.772 ,-0.369)
		cursor_y[2] = Vector(-1.399,0.352 ,-0.369)
		
		ItemSetPosition(this.cursor,cursor_y[line_id])

		g_music_bkg.Create("Sounds/music/music_visiting.wav")		
		g_music_bkg.PlayMusic();
		
		local title_hud = TGameHud()
		title_hud.CreateLabel(locale.credit_short, 32, 0, 830, 1280, 120, TextAlignCenter)
		
		//UISetCommandList(SceneGetUI(g_scene) , "globalfade 0, 1; nop 1 ; globalfade 1.15, 0;")
		
	}
	
	
	function MoveCursor()
	{
		local cmd = cursor_y[line_id].x +"," + cursor_y[line_id].y + "," + cursor_y[line_id].z
		ItemSetCommandList(this.cursor, "toposition 0.25,"+cmd+";")
		
	}
	
	function DoMenu()
	{
		if (menu_buttons=="MAIN") { this.DoMainMenu(); return 0;}
		if (menu_buttons=="PLAY") { this.DoPlayMenu(); return 0;}
	}
	
	
	
	function DoMainMenu()
	{
		// [0] ----------------------------------------------------
		//     Jump to play menu
		//     ----------------------------------------------------
		
		if (this.line_id==0)
		{
			// jump to PLAY menu
			menu_buttons="PLAY";
			
			// hide MAIN
			local cmd = this.hide_pos.x + "," + this.hide_pos.y + "," + this.hide_pos.z
			ItemSetCommandList(this.buttons_main, "toposition 0.25,"+cmd+";")
			
			// show PLAY
			local cmd = this.visible_pos.x + "," + this.visible_pos.y + "," + this.visible_pos.z
			ItemSetCommandList(this.buttons_play, "toposition 0.25,"+cmd+";")	
			
			
			
		}
		
		// [1] ----------------------------------------------------
		//
		// 	   ----------------------------------------------------
		if (this.line_id==1)
		{
			g_game_command = "LOAD_TUTORIAL"
		}
		// [2] ----------------------------------------------------
		//
		//     ----------------------------------------------------
		if (this.line_id==2)
		{
			g_game_command = "EXIT_GAME"
			
		}
		
	}
	
	
	function DoPlayMenu()
	{
		
		// [0] ----------------------------------------------------
		//     Start new game
		//     ----------------------------------------------------
		if 	(this.line_id==0)
		{
		
			
			g_current_id = 0;
			/*
			ADD RESET SCENE DATA FILE !!!!
   			local data = TIO_metadata(); 
			if (data.Load("mr_cleaner.txt"))
			{
				data.SetValue("game_last_level_name",g_levels[g_level_name[g_current_id]].name)
				data.SetValue("game_last_level_id",g_current_id)				
				data.Save("mr_cleaner.txt")
			}
			*/
			g_game_command = "LOAD_SCENE"
		}
				
		// [1] ----------------------------------------------------
		//
		// 	   ----------------------------------------------------
		
		if 	(this.line_id==1)
		{
			
			this.enable_keys = false
			g_game_command = "SELECT_LEVEL"
			print(g_game_command)
		}
		
		// [2] ----------------------------------------------------
		//     jump BACK to main menu
		// 	   ----------------------------------------------------
		
		if (this.line_id==2)
		{
			// jump to MAIN menu
			menu_buttons="MAIN";
				
			// show MAIN
			
			local cmd = this.visible_pos.x + "," + this.visible_pos.y + "," + this.visible_pos.z
			ItemSetCommandList(this.buttons_main, "toposition 0.25,"+cmd+";")
			
			// hide PLAY
			local cmd = this.hide_pos.x + "," + this.hide_pos.y + "," + this.hide_pos.z
			ItemSetCommandList(this.buttons_play, "toposition 0.25,"+cmd+";")
		}
	}
	
	
}
