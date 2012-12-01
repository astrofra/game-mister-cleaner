Include("Scripts/locale.nut") 

class TGameHud
{
	
	ui = 0;
	HUD_level_name = 0;
	HUD_level_places = 0;
	HUD_level_turns = 0;
	HUD_level_time = 0;
	HUD_level_result = 0;
	HUD_rec_icon = 0;
	
	turn_count = 0;
	old_turn_count = 0;
	screen_width = 0;
	screen_height = 0;
	old_count_src = 0;
	old_count_dst = 0;
	font = 0;

	current_time_string = 0;

	MENU = 0;
	PAUSE = 0;
	enable = true;
	
	constructor()
	{
		local screen_size = RendererGetViewport(g_render)
	
		this.screen_width = screen_size[2]
		this.screen_height = screen_size[3]
		this.current_time_string = "";
		
		this.ui = SceneGetUI(g_scene)
		UILoadFont("fonts/HEMIHEAD.TTF")
		UILoadFont("fonts/Lifeline.ttf") 
		//this.font = RendererLoadWriterFont(g_render,"HEMIHEAD","fonts/HEMIHEAD.TTF")
		
		
		this.HUD_rec_icon = THUD_Sprite();
		this.HUD_rec_icon.Create("textures/gui/record_icon.png")
		this.HUD_rec_icon.SetPivot(0,0)
		this.HUD_rec_icon.SetPosition(0,0)
		this.HUD_rec_icon.Hide()
	}

	function CreateWindow(pos_x, pos_y, pivot_x, pivot_y, width, height)
	{
		
		// Create UI window.
		local window = UIAddWindow(this.ui, -1, 0, 0, width, height)

		// Center window pivot.		
		WindowSetPivot(window, pivot_x,pivot_y)
		// set window position
		WindowSetPosition(window,pos_x,pos_y)	
		
		return window
	}
	

	function	CreateLabel(text, size, pos_x, pos_y,w,h,align,text_color = Vector(0,0,0,255))
	{
		local window = CreateWindow(pos_x,pos_y,0,0,w,h)
		
		// Create UI text widget to base window.
		local	widget = UIAddStaticTextWidget(this.ui, -1, text, "HEMIHEAD")
		WindowSetBaseWidget(window, widget)

		// Set text attributes.
		TextSetSize(widget, size)
		TextSetColor(widget, text_color.x, text_color.y, text_color.z, text_color.w)
		TextSetAlignment(widget, align)

		// Return window.
		return [window,widget]
	}	
	
	
	function Initialize()
	{
		if (this.enable)
		{
			//UISetCommandList(ui, "globalfade 0, 1; nop 3; globalfade 1.15, 0;")
			// Create the background.
			local		background_window = UIAddBitmapWindow(ui, -1, "textures/hud/hud_background_top.tga", 0, 0, 1024, 256)
			WindowSetPivot(background_window, 512, 128)
			WindowSetPosition(background_window, 1280/2.0, -96.0)
			WindowSetOpacity(background_window, 0.45)			
			WindowSetScale(background_window, 2.0, 2.0)

			local	_x = 48.0
			local txt = locale.hud_name + ": "+g_levels[g_level_name[g_current_id]].name + "       " + locale.hud_world + ": " + g_levels[g_level_name[g_current_id]].world_id + " " + locale.hud_stage + ": " + g_levels[g_level_name[g_current_id]].stage_id
			this.HUD_level_name = CreateLabel(txt, 32, 256 - 32 + _x, 4, 800,80,TextAlignLeft,Vector(255,255,255,255)) 	
			
			//WindowSetRotation(HUD_level_name[0],Deg(90))
			
			this.HUD_level_places = CreateLabel("0/0", 64, 256-32 + _x, 64, 800,80,TextAlignLeft,Vector(255,255,255,255)) 	
	
			// Create the world icon.
			local		life_icon_window = UIAddBitmapWindow(ui, -1, "textures/hud/icon_mwall.png", 0 + 256 * 0.45 + _x, 0, 256, 256)
			WindowSetScale(life_icon_window, 0.5, 0.5)
			
			// Create the turns icon.
			local		turn_icon_window = UIAddBitmapWindow(ui, -1, "textures/hud/icon_turns.png", 1024 - 256 * 0.5 + _x, 0, 256, 256)
			WindowSetScale(turn_icon_window, 0.5, 0.5)		
			
			// Create Time info
			this.HUD_level_time = CreateLabel(locale.hud_time + ": 00:00", 64, 256 + _x, 64, 800,80,TextAlignCenter,Vector(255,255,255,255)) 	
			this.HUD_level_turns = CreateLabel("0", 64, 1024 + _x, 64, 800,80,TextAlignLeft,Vector(255,255,255,255)) 
			
			this.CreateMenu()
			this.CreatePauseMenu()
			
		}
	}


	function SetGoalInfo(on_place,sum_places)
	{
		if (this.enable)
		{
			local txt = on_place+"/"+sum_places
			if ((this.old_count_src!=on_place) || (this.old_count_dst!=sum_places))
			{
				TextSetText(this.HUD_level_places[1],txt)
			}
			this.old_count_src = on_place
			this.old_count_dst = sum_places

		}
	}
	
	function SetTimeInfo()
	{
		if (this.enable)
		{
			local	new_time_string = format(locale.hud_time + ": %d s", g_score_time.tointeger()/10000)
			if	(new_time_string != current_time_string)
			{
				current_time_string = new_time_string
				TextSetText(this.HUD_level_time[1], new_time_string) 
			
			}
		}
	}
	
	function ShowLevelTime()
	{
		if (this.enable)
		{
			local	new_time_string = format(locale.hud_time + ": %d s", g_score_time.tointeger()/10000)
			
			TextSetText(this.HUD_level_time[1], new_time_string) 
			TextSetText(this.HUD_level_turns[1],g_score_steps.tostring())
		}
	}
	
	function SetTurnInfo(t_count)
	{
		if (this.enable)
		{
			local txt = ""+t_count
			
			if (this.turn_count!=t_count)
			{
				TextSetText(this.HUD_level_turns[1],txt)
			}
			this.old_turn_count = t_count
			
		}
	}
	
	
	function ShowResult()
	{
		if (this.enable)
		{
			local x = 400
			local y = 300
			
			this.HUD_level_result = THUD_Sprite();
			this.HUD_level_result.Create("textures/hud/HUD_result.png")
			this.HUD_level_result.SetPivot(0,0)
			this.HUD_level_result.SetPosition(x,y)
			
			// level name
			local l = 50
			
			local txt_level = THUD_Text()
			txt_level.Create("HEMIHEAD")
			txt_level.SetFontSize(32)
			txt_level.SetText(g_levels[g_level_name[g_current_id]].name)
			txt_level.SetPosition(x+256,y+154+l*0)
			
			// FORWARD STEP COUNT
			local txt_forward = THUD_Text()
			txt_forward.Create("HEMIHEAD")
			txt_forward.SetFontSize(32)
			txt_forward.SetText(g_score_steps.tostring())
			txt_forward.SetPosition(x+256,y+154+l*1)
			
			// TURN LEFT COUNT
			local txt_left = THUD_Text()
			txt_left.Create("HEMIHEAD")
			txt_left.SetFontSize(32)
			txt_left.SetText(g_score_turn_left.tostring())
			txt_left.SetPosition(x+256,y+154+l*2)
			
			// TURN RIGHT COUNT
			local txt_right = THUD_Text()
			txt_right.Create("HEMIHEAD")
			txt_right.SetFontSize(32)
			txt_right.SetText(g_score_turn_right.tostring())
			txt_right.SetPosition(x+256,y+154+l*3)
			
			// TURN BACK COUNT
			local txt_back = THUD_Text()
			txt_back.Create("HEMIHEAD")
			txt_back.SetFontSize(32)
			txt_back.SetText(g_score_turn_back.tostring())
			txt_back.SetPosition(x+256,y+154+l*4)
			
			// TURN TIME COUNT
			local txt_time = THUD_Text()
			txt_time.Create("HEMIHEAD")
			txt_time.SetFontSize(32)
			local tm = g_score_time/10000
			txt_time.SetText(tm.tostring()+"s")
			txt_time.SetPosition(x+256,y+154+l*5)
			
			
			
		}
		
	}
	
	function CreateMenu()
	{
		
		this.MENU = TGUI_GameMenu();
		
		local size = UIGetInternalResolution(SceneGetUI(g_scene));
		
		this.MENU.AddMenuItem(locale.menu_quit,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",true,"HEMIHEAD",32,locale.menu_quit_hint)
		this.MENU.AddMenuItem(locale.menu_restart,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_restart_hint)
		this.MENU.AddMenuItem(locale.menu_replay,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_replay_hint)
		this.MENU.AddMenuItem(locale.menu_next,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_next_hint)
				
		
		
		//this.MENU.SetPosition((size.x/2)-(1.35*128),size.y-128);
		this.MENU.SetPosition((size.x/2)-(1.85*128),size.y-128);
		this.MENU.SetKeys(KeyLeftArrow,KeyRightArrow,KeySpace)
		this.MENU.SetItemOffset(128,0)
		this.MENU.SetCaptionOffset(16,64+16);
				
		this.MENU.OnEnter = this.ExecuteMenuButton
		
		this.MENU.Hide()
		
	}
	
	function ExecuteMenuButton(id,m)
	{
		

		// MENU
		if (id==0)
		{			
			//RECORD.Save(g_current_id)
			print("Button #"+id+" pressed");
			g_game_command = "SELECT_LEVEL"
		}
		
		// REPEAT
		if (id == 1)
		{
			//RECORD.Save(g_current_id)
			print("Button #"+id+" pressed");
			g_game_command = "REPEAT_LEVEL"
		}
		
		// REPLAY
		if (id == 2)
		{			
			print("Button #"+id+" pressed");
			g_game_command = "REPLAY_LEVEL"
		}
		
		// NEXT
		if (id == 3)
		{
			//RECORD.Save(g_current_id)
			print("Button #"+id+" pressed");
			g_game_command = "NEXT_LEVEL"
			
		}
		
	} 
	
	
	
	function CreatePauseMenu()
	{
		
		this.PAUSE = TGUI_GameMenu();
		
		this.PAUSE.AddMenuItem(locale.menu_quit,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",true,"HEMIHEAD",32,locale.menu_quit_hint)
		this.PAUSE.AddMenuItem(locale.menu_restart,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_restart_hint)
		this.PAUSE.AddMenuItem(locale.menu_replay,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_replay_hint)
		this.PAUSE.AddMenuItem(locale.menu_resume,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_resume_hint)
				
		local size = UIGetInternalResolution(SceneGetUI(g_scene));
		
		this.PAUSE.SetPosition((size.x/2)-(1.85*128),size.y-128);
		this.PAUSE.SetKeys(KeyLeftArrow,KeyRightArrow,KeySpace)
		this.PAUSE.SetItemOffset(128,0)
		this.PAUSE.SetCaptionOffset(16,64+16);
				
		this.PAUSE.OnEnter = this.ExecutePauseMenuButton
		
		this.PAUSE.Hide()
		
	}
	
	function ExecutePauseMenuButton(id,m)
	{
		

		// MENU
		if (id==0)
		{
			
			print("Button #"+id+" pressed");
			g_game_command = "CLOSE_LEVEL"
		}
		
		// REPEAT
		if (id == 1)
		{
			RECORD.Clear()
			print("Button #"+id+" pressed");
			g_game_command = "REPEAT_LEVEL"
		}
		
		// Replay
		if (id == 2)
		{
			if (RECORD.Exist(g_current_id))
			{
				g_game_command = "REPLAY_LEVEL"
			}
			
		}
		
		// RESUME
		if (id == 3)
		{
			ItemGetScriptInstance(SceneFindItem(g_scene, "Player")).game_state = "PAUSE_OFF"
			
		}
		
	} 
	
	
}
