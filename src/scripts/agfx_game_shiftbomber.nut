/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/agfx_game_shiftbomber.nut
	Author: Author
*/

Include("Scripts/lib/Helpers.nut")
Include("Scripts/lib/TKeyboard.nut")
Include("Scripts/lib/TSoundFX.nut")
Include("Scripts/lib/TMusic.nut")
Include("Scripts/lib/TIO_metadata.nut")
Include("Scripts/lib/TGUI_Window.nut")
Include("Scripts/lib/TGUI_Gamemenu.nut")
Include("Scripts/lib/TGUI_GameMenuItem.nut")
Include("Scripts/lib/THUD_Sprite.nut")
Include("Scripts/lib/THUD_Text.nut")
Include("Scripts/agfx_game_score.nut")
Include("Scripts/agfx_game_hud.nut")
Include("Scripts/mrcleaner_sounds.nut")
Include("Scripts/mrcleaner_levels.nut")
Include("Scripts/mrcleaner_recorder.nut")
Include("Scripts/title_screen_level_preview.nut")



g_current_id 		<- 0 ;
g_game_command 		<- "LOGO"
g_game_wait 		<- "ENABLE"
g_max_level_count 	<- 49
RECORD 				<- TMoveRecorder()

/*!
	@short	AGFX_Game_ShiftBomber
	@author	Author
*/
class	AGFX_Game_ShiftBomber
{
	/*!
		@short	OnUpdate
		Called each frame.
	*/
	current_scene = 0
	wait_scene = 0;
	_project = 0;
	layer_scene = 0;
	layer_wait = 0;	
	
	function	OnUpdate(project)
	{

		if (g_game_command=="LOGO") { LoadLogoScene() }
		if (g_game_command=="INTRO") { LoadIntroScene() }
		if (g_game_command=="START") { LoadTitleScene() }
		if (g_game_command=="LOAD_TUTORIAL") { LoadTutorial() }
		if (g_game_command=="LOAD_SCENE") { LoadScene() }
		if (g_game_command=="EXIT_GAME") { CloseGame() }
		if (g_game_command=="CLOSE_LEVEL") { CloseLevel() }
		if (g_game_command=="SELECT_LEVEL") { SelectLevel() }
		if (g_game_command=="LOAD_LEVEL") { LoadLevel() }
		if (g_game_command=="REPEAT_LEVEL") { RepeatLevel() }
		if (g_game_command=="NEXT_LEVEL") { NextLevel() }
		if (g_game_command=="REPLAY_LEVEL") { ReplayLevel() }
		
		if (g_game_wait=="ENABLE") {ShowWaitScene()}
		if (g_game_wait=="DISABLE") {HideWaitScene()}
				
	}

	/*!
		@short	OnRenderScene
		Called before rendering a scene layer.
	*/
	function	OnRenderScene(project, scene, layer)
	{

	

	}

	/*!
		@short	OnSetup
		Called when the project is about to be setup.
	*/
	function	OnSetup(project)
	{
		print("OnSetup(project)")
		this._project = project
		
		// load soundFX for MENU
		LoadMenuSounds()
	}
	
	function LoadTitleScene()
	{
		ProjectUnloadScene(_project,this.current_scene)
		this.current_scene = ProjectInstantiateScene(_project, "scenes/title_screen.nms")		
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)
		
		
		//this.wait_scene = ProjectInstantiateScene(_project, "scenes/wait_scene.nms")
		//this.layer_wait = ProjectAddLayer(_project, this.wait_scene, -3.5)
		
		ProjectSceneGetScriptInstanceFromClass(this.current_scene, "func_title_screen").project_instance = _project	
		
		this.SetWaitDelay(1)
		g_game_command = "WAIT"	
	}
	
	function LoadIntroScene()
	{
		ProjectUnloadScene(_project,this.current_scene)
		
		this.current_scene = ProjectInstantiateScene(_project, "scenes/level_game_introduction.nms")		
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)
		
		
		//this.wait_scene = ProjectInstantiateScene(_project, "scenes/wait_scene.nms")
		//this.layer_wait = ProjectAddLayer(_project, this.wait_scene, -3.5)
		
		ProjectSceneGetScriptInstanceFromClass(this.current_scene, "GameIntroduction").project_instance = _project	
		
		this.SetWaitDelay(1)
		g_game_command = "WAIT"	
	}
	
	function LoadLogoScene()
	{
		//ProjectUnloadScene(_project,this.current_scene)
		
		this.current_scene = ProjectInstantiateScene(_project, "scenes/logos_scene.nms")		
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)
		
		
		//this.wait_scene = ProjectInstantiateScene(_project, "scenes/wait_scene.nms")
		//this.layer_wait = ProjectAddLayer(_project, this.wait_scene, -3.5)
		
		ProjectSceneGetScriptInstanceFromClass(this.current_scene, "func_logos_scene").project_instance = _project	
		
		this.SetWaitDelay(1)
		g_game_command = "WAIT"	
	}
	
	function SetWaitDelay(tt)
	{
		//ProjectSceneGetScriptInstanceFromClass(this.wait_scene, "scenes_wait_scene_nms").SetDelay(tt)
	}
	
	function InitWaitScreen()
	{
		
	}
	
	function ShowWaitScene()
	{	
		//ProjectSceneGetScriptInstanceFromClass(this.wait_scene, "scenes_wait_scene_nms").Reset()			
		//ProjectSceneActivate(_project,this.wait_scene,true)
		g_game_wait = ""
	}
	
	function HideWaitScene()
	{
		//ProjectSceneActivate(_project,this.wait_scene,false)
		g_game_wait = ""
	}
	
	function LoadScene()
	{
		LoadLevels()
		this.LoadLevel()
		ItemGetScriptInstance(SceneFindItem(g_scene, "Player")).replay = false
	}
	
	function LoadLevel()
	{
		
		this.SetWaitDelay(3)		
		g_game_wait = "ENABLE"
		
		ProjectUnloadScene(_project,this.current_scene)

		// load level sound FX for current loaded scene
		ReloadSounds(g_current_id)
				
		this.current_scene = ProjectInstantiateScene(_project, g_levels[g_level_name[g_current_id]].filename)
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)

		g_game_command = "WAIT"	
	}

	function CloseLevel()
	{
		this.SetWaitDelay(2)
		
		g_game_wait = "ENABLE"
		g_music_bkg.StopMusic()
		ProjectUnloadScene(_project,this.current_scene)
		g_game_command = "START"	
		
	}

	function CloseGame()
	{
		g_sfx_menu_escape.Play()
		ProjectEnd(this._project)
	}
	
	function SelectLevel()
	{
		this.SetWaitDelay(1)
		
		g_game_wait = "ENABLE"
		LoadLevels()
		ProjectUnloadScene(_project,this.current_scene)
		this.current_scene =  ProjectInstantiateScene(_project, "scenes/title_select_level.nms")
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)
		g_game_command = "WAIT"	
		
	}
	
	function RepeatLevel()
	{
		this.SetWaitDelay(1)
		
		g_game_wait = "ENABLE"		
		ProjectUnloadScene(_project,this.current_scene)		
		LoadLevel()
		g_game_command = "WAIT"	
		print("REPEAT LEVEL "+g_current_id)
	}
	
	function NextLevel()
	{
		if (g_current_id<=49)
		{
			
			this.SetWaitDelay(1)
			g_current_id++
			print("NEXT LEVEL "+g_current_id)
			g_game_wait = "ENABLE"
			ProjectUnloadScene(_project,this.current_scene)
			LoadLevel()		
			g_game_command = "WAIT"	
		}
	}
	
	function ReplayLevel()
	{
		this.SetWaitDelay(1)
		
		g_game_wait = "ENABLE"		
		ProjectUnloadScene(_project,this.current_scene)		
		LoadLevel()
		g_game_command = "WAIT"	
		print("REPLAY LEVEL "+g_current_id)
		RECORD.Load(g_current_id)
		GetLevelInfo()
		ItemGetScriptInstance(SceneFindItem(g_scene, "Player")).replay = true
	}
	
	function LoadTutorial()
	{
		ProjectUnloadScene(_project,this.current_scene)
		this.current_scene = ProjectInstantiateScene(_project, "scenes/level_tutorial.nms")		
		this.layer_scene = ProjectAddLayer(_project, this.current_scene, 0.5)
		
		
		//this.wait_scene = ProjectInstantiateScene(_project, "scenes/wait_scene.nms")
		//this.layer_wait = ProjectAddLayer(_project, this.wait_scene, -3.5)
		
		ProjectSceneGetScriptInstanceFromClass(this.current_scene, "LevelTutorial").project_instance = _project	
		
		this.SetWaitDelay(1)
		g_game_command = "WAIT"	
	}
}
