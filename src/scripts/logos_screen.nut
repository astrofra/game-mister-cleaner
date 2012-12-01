/*
	File: E:/_3D_Engines/GameStart_B7/Projects/AGFX_Game_ShiftBomber/Scripts/logos_screen.nut
	Author: AndyGFX
*/

Include("Scripts/locale.nut") 

/*!
	@short	scenes_logos_scene
	@author	AndyGFX
*/
class	func_logos_scene
{

	project_instance = 0;
	InputKey = TKeyboard();
	txt_key	 = 0
	intro_duration	=	Sec(1.5)
	intro_timer		=	0
	
	constructor()
	{

		InputKey = TKeyboard();
		this.CreateInfoText()
	}

	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
	
		if ((this.InputKey.IsUp(KeySpace)) || (g_clock - intro_timer > SecToTick(Sec(intro_duration))))
		{	
			print("EXIT from LOGOS SCREEN")
			g_game_command = "INTRO"
		}	
		
	}

	/*!
		@short	OnSetupDone
		Called when the scene is about to be setup.
	*/
	function	OnSetupDone(scene)
	{
		intro_timer = g_clock
	}
	
	function CreateInfoText()
	{
		this.txt_key = THUD_Text()
		this.txt_key.Create("HEMIHEAD")
		this.txt_key.SetFontColor(255,255,255,255)
		this.txt_key.SetFontSize(32)
		this.txt_key.SetText(locale.press_to_skip)
		this.txt_key.SetPosition(32,32)
	}
}
