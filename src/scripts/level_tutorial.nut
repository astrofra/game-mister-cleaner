/*
	File: C:/works/3d/games/svn_mr_cleaner/game_shiftbomber/Scripts/level_tutorial.nut
	Author: Astrofra
*/

Include("Scripts/locale.nut")
Include("Scripts/globals.nut")  

function	TutorialThreadWait(s)
{
	local	_timeout
	
	s = s / g_player_speed_multiplier

	_timeout = g_clock
				
	while ((g_clock - _timeout) < SecToTick(Sec(s)))
		suspend()
}

//-----------------------------
function	TutorialThread(scene)
{
	local	scene_script	= 0		//	Scene's script
	scene_script = SceneGetScriptInstance(scene)

	print("TutorialThread() started.")

	TutorialThreadWait(1.0)

	//	Basic Moves
	print("TutorialThread() Play Basic Move.")

	scene_script.FocusLightMoveToPosition(1)

	scene_script.TutorialSetText(locale.tut_0)
	scene_script.TutorialSpeech(0)

	TutorialThreadWait(7.0)

	scene_script.TutorialSetText(locale.tut_1)
	scene_script.TutorialSpeech(1)

	scene_script.PlayerRotateCCW()
	TutorialThreadWait(2.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(0)
	TutorialThreadWait(2.0)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()

	scene_script.TutorialSetText(locale.tut_2)
	scene_script.TutorialSpeech(2)

	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()

	TutorialThreadWait(2.0)

	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(0)
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(0)
	TutorialThreadWait(2.0)

	//	Reset player
	scene_script.FocusLightMoveToPosition(0)
	scene_script.PlayerFadeOut()
	TutorialThreadWait(2.0)
	scene_script.PlayerResetPosition()
	TutorialThreadWait(0.25)
	scene_script.PlayerFadeIn()
	TutorialThreadWait(2.0)

	//	Bomb Moves
	scene_script.FocusLightMoveToPosition(2)
	scene_script.TutorialSetText(locale.tut_3)
	scene_script.TutorialSpeech(3)

	print("TutorialThread() Play Bomb Move #1.")
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCCW()

	scene_script.TutorialSetText(locale.tut_4)

	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushBomb(0)
	TutorialThreadWait(2.0)
	scene_script.BombExplodes(0)
	scene_script.IceExplodes(0)
	TutorialThreadWait(2.0)

	print("TutorialThread() Play Bomb Move #2.")

	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.5)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(2.0)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushBomb(1)
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushBomb(1)
	TutorialThreadWait(2.0)
	scene_script.BombExplodes(1)
	scene_script.IceExplodes(1)
	scene_script.IceExplodes(2)
	TutorialThreadWait(2.0)

	//	Reset player
	scene_script.FocusLightMoveToPosition(0)
	scene_script.PlayerFadeOut()
	TutorialThreadWait(2.0)
	scene_script.PlayerResetPosition()
	TutorialThreadWait(0.25)
	scene_script.PlayerFadeIn()
	TutorialThreadWait(2.0)

	//	Elevator Moves
	print("TutorialThread() Play Elevator Move #1.")

	scene_script.FocusLightMoveToPosition(0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.LiftMoveUp()
	TutorialThreadWait(3.0)

	scene_script.FocusLightMoveToPosition(3)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)

	//	Teleporter Move 1

	print("TutorialThread() Play Teleporter Move.")
	scene_script.TutorialSetText(locale.tut_5)
	scene_script.TutorialSpeech(4)

	scene_script.FocusLightMoveToPosition(4)
	scene_script.PlayerFadeOut()
	TutorialThreadWait(2.0)
	scene_script.PlayerTeleportToPortal(0)
	scene_script.PlayerFadeIn()

	scene_script.TutorialSetText(locale.tut_6)

	TutorialThreadWait(2.0)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)

	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(3.0)

	//	Teleporter Move 2

	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)

	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)

	scene_script.PlayerFadeOut()
	TutorialThreadWait(2.0)
	scene_script.PlayerTeleportToPortal(1)
	scene_script.PlayerFadeIn()
	TutorialThreadWait(2.0)

	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)

	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)

	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)

	scene_script.PlayerMoveForward()

	scene_script.TutorialSetText(locale.tut_7)
	scene_script.TutorialSpeech(5)

	TutorialThreadWait(1.25)

	scene_script.LiftMoveDown()
	scene_script.CoreMoveDown(1)
	TutorialThreadWait(2.0)

	scene_script.TutorialSetText(locale.tut_8)

	TutorialThreadWait(1.0)

	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.25)

	scene_script.PlayerRotateCCW()
	TutorialThreadWait(1.25)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.25)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	TutorialThreadWait(1.0)
	scene_script.PlayerRotateCW()
	TutorialThreadWait(1.25)

	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.0)
	scene_script.PlayerMoveForward()
	scene_script.PlayerPushCore(1)
	TutorialThreadWait(1.0)

	scene_script.TutorialSetText(locale.tut_9)
	scene_script.TutorialSpeech(6)

	TutorialThreadWait(3.0)

	print("TutorialThread() ended.")
}

/*!
	@short	LevelTutorial
	@author	Astrofra
*/
class	LevelTutorial
{
	turorial_thread		=	0
	project_instance 	=	0
	current_scene		=	0
	player_item			=	0
	focus_light_item	=	0
	focus_pos			=	0
	tut_text_window		=	0
	tut_text_widget		=	0

	sfx_speech			=	0

	MENU = 0;
	game_state = "TUTORIAL"
	
	InputKey = 0;
	
	constructor()
	{
		MENU = TGameHud();	
		InputKey = TKeyboard();
		game_state = "TUTORIAL"
		tut_text_window = TGUI_Window();
		sfx_speech = []
	}
	
	function	PlayerResetPosition()
	{
		ItemSetPosition(player_item, Vector(0,0,0))
		ItemSetRotation(player_item, Vector(0,0,0))
	}

	function	PlayerTeleportToPortal(n)
	{		ItemSetPosition(player_item, ItemGetPosition(SceneFindItem(current_scene, "portal_out_" + n.tostring())))	}

	function	PlayerPushCore(n)
	{
		local	_core_item, _fwd
		_core_item = SceneFindItem(current_scene, "core_item_" + n.tostring())
		_fwd = ItemGetRotationMatrix(player_item).GetRow(2).Normalize()
		ItemSetCommandList(_core_item, "offsetposition " + PSpeedMul(1.0) + "," + _fwd.x.tostring() + ",0," + _fwd.z.tostring() + ";") 
		print("LevelTutorial::PlayerPushesCore()")
	}

	function	PlayerPushBomb(n)
	{
		local	_bomb_item, _fwd
		_bomb_item = SceneFindItem(current_scene, "bomb_item_" + n.tostring())
		_fwd = ItemGetRotationMatrix(player_item).GetRow(2).Normalize()
		ItemSetCommandList(_bomb_item, "offsetposition " + PSpeedMul(1.0) + "," + _fwd.x.tostring() + ",0," + _fwd.z.tostring() + ";") 
		print("LevelTutorial::PlayerPushBomb()")
	}

	function	LiftMoveUp()
	{
		local	_lift_item
		_lift_item = SceneFindItem(current_scene, "lift_item")
		ItemSetCommandList(_lift_item, "offsetposition " + PSpeedMul(2.0) + ", 0, 1, 0;")
	}

	function	LiftMoveDown()
	{
		local	_lift_item
		_lift_item = SceneFindItem(current_scene, "lift_item")
		ItemSetCommandList(_lift_item, "offsetposition " + PSpeedMul(2.0) + ", 0, -1, 0;")
	}

	function	CoreMoveDown(n)
	{
		local	_core_item
		_core_item = SceneFindItem(current_scene, "core_item_" + n.tostring())
		ItemSetCommandList(_core_item, "offsetposition " + PSpeedMul(2.0) + ", 0, -1, 0;")
	}

	function	IceExplodes(n)
	{
		local	_ice_item
		_ice_item = SceneFindItem(current_scene, "ice_item_" + n.tostring())
		ItemSetCommandList(_ice_item, "toalpha 0.0,1.0;offsetposition 0.1,0,-0.5,0;offsetposition 0.9,0,-1.0,0+toalpha 0.75,0.0+toscale 0.9,1.25,1,1.25;")
		print("LevelTutorial::IceExplodes()")
	}

	function	BombExplodes(n)
	{
		local	_bomb_item
		_bomb_item = SceneFindItem(current_scene, "bomb_item_" + n.tostring())
		ItemSetCommandList(_bomb_item, "toalpha 0.0,1.0;toalpha " + PSpeedMul(1.0) + ",0.0;offsetposition 0,0,-2,0;")
		print("LevelTutorial::BombExplodes()")
	}

	function	PlayerMoveForward()
	{
		local	_fwd
		_fwd = ItemGetRotationMatrix(player_item).GetRow(2).Normalize()
		ItemSetCommandList(player_item, "offsetposition " + PSpeedMul(1.0) + "," + _fwd.x.tostring() + ",0," + _fwd.z.tostring() + ";") 
		print("LevelTutorial::PlayerMoveForward()")
	}

	function	PlayerRotateCCW()
	{
		local	_rot_y
		_rot_y = RadianToDegree(ItemGetRotation(player_item).y) -90.0
		ItemSetCommandList(player_item, "torotation " + PSpeedMul(1.0) + ",0," + _rot_y.tostring() + ",0;")
		print("LevelTutorial::PlayerRotateLeft() angle = " + _rot_y)	
	}

	function	PlayerRotateCW()
	{
		local	_rot_y
		_rot_y = RadianToDegree(ItemGetRotation(player_item).y) + 90.0
		ItemSetCommandList(player_item, "torotation " + PSpeedMul(1.0) + ",0," + _rot_y.tostring() + ",0;")
		print("LevelTutorial::PlayerRotateLeft() angle = " + _rot_y)	
	}

	function	PlayerFadeIn()
	{		ItemSetCommandList(player_item, "toalpha " + PSpeedMul(1.0) + ",1.0;nop 0.0;toalpha 0.0,1.0;")	}

	function	PlayerFadeOut()
	{		ItemSetCommandList(player_item, "toalpha " + PSpeedMul(1.0) + ",0.0;nop 0.0;toalpha 0.0,0.0;")	}


	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
		UpdateFocusLightPosition()

		if (game_state == "TUTORIAL")
		{
			HandleTutorialThread()
			
			if	(this.InputKey.IsUp(KeyEscape)) 
			{
					//g_game_command = "CLOSE_LEVEL"
					this.MENU.Show()
					this.game_state = "TUTORIAL_MENU"
			}
		}
		
		if (game_state == "TUTORIAL_MENU_OFF")
		{
			this.MENU.Hide()
			this.game_state="TUTORIAL"
		}
		
		if (game_state == "TUTORIAL_MENU")
		{
			this.MENU.OnUpdate()
			
			if	(this.InputKey.IsUp(KeyEscape))
			{
				this.MENU.Hide()
				this.game_state="TUTORIAL"
			}
		}
		
	}

	function	FocusLightMoveToPosition(n)
	{
		focus_pos = GetFocusPosition(n)
	}

	function	GetFocusPosition(n)
	{
		return ItemGetPosition(SceneFindItem(current_scene, "focus_" + n.tostring()))
	}

	function	UpdateFocusLightPosition()
	{
		local	p = ItemGetPosition(focus_light_item)
		p = p.Lerp(0.95, focus_pos)
		ItemSetPosition(focus_light_item, p)
	}

	function	OnSetup(scene)
	{
		current_scene = scene
		player_item = SceneFindItem(current_scene, "player_item")
		focus_light_item = SceneFindItem(current_scene, "focus_light")
		focus_pos = Vector(0,0,0) //GetFocusPosition(0)

		//	UI
		tut_text_window.CreateWindow("", 1024,300) //SetPosition()
		WindowSetPivot(tut_text_window.window, 512, 150)
		tut_text_window.SetPosition(1280 / 2 + 300, 1024 / 2 + 300)
		WindowSetOpacity(tut_text_window.window, 0.75)
		WindowSetScale(tut_text_window.window, 0.75, 0.75)
		tut_text_widget = UIAddStaticTextWidget(tut_text_window.ui, -1, " ", "HEMIHEAD")
		WindowSetBaseWidget(tut_text_window.window, tut_text_widget)
		TextSetSize(tut_text_widget, 64)
		TextSetColor(tut_text_widget, 255, 255, 255, 255)
		TextSetAlignment(tut_text_widget, TextAlignCenter)

		//	Speech
		for(local n = 0; n < 7;n++)
			sfx_speech.append(EngineLoadSound(g_engine, "Sounds/sfx/sfx_speech_tut_" + n.tostring() + ".wav"))
	}

	function	TutorialSpeech(n)
	{
		local chan = MixerSoundStart(EngineGetMixer(g_engine), sfx_speech[n])
		MixerChannelSetGain(EngineGetMixer(g_engine), chan, 0.75)
	}

	function	TutorialSetText(str)
	{
		TextSetText(tut_text_widget, str)
	}
	/*!
		@short	OnSetupDone
		Called when the scene is about to be setup.
	*/
	function	OnSetupDone(scene)
	{
		StartTutorialThread()
		this.CreateMenu()
	}

	function	StartTutorialThread()
	{
		turorial_thread = newthread(TutorialThread)
		turorial_thread.call(current_scene)
	}

	//-------------------------------
	function	HandleTutorialThread()
	//-------------------------------
	{
		if (turorial_thread == 0)
			return

		if (turorial_thread.getstatus() == "suspended")
			turorial_thread.wakeup()
		else
			turorial_thread = 0
	}
	
	function CreateMenu()
	{
		
		this.MENU = TGUI_GameMenu();
		
		local size = UIGetInternalResolution(SceneGetUI(g_scene));
		
		this.MENU.AddMenuItem(locale.menu_quit,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",true,"HEMIHEAD",32,locale.menu_quit_hint)
		this.MENU.AddMenuItem(locale.menu_restart_tutorial,"textures/gui/button_n.png","textures/gui/button_cursor_s.png",false,"HEMIHEAD",32,locale.menu_restart_tuto_hint)
		
		
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
			g_game_command = "CLOSE_LEVEL"
		}
		
		// REPEAT
		if (id == 1)
		{			
			g_game_command = "LOAD_TUTORIAL"
		}
		
	} 
}
