/*
	File: E:/_3D_Engines/GameStart/Projects/AGFX_game_RLC/scripts/scene/RLC_Player.nut
	Author: AndyGFX
*/

/*!
	@short	RLC_Player
	@author	AndyGFX
*/


class	RLC_Player extends TEntity
{
	/*<
	<Script =
	  <Name = "RLC_Player.nut">
	  <Author = "AndyGFX">
	  <Description = "Script for player control.">
	>
	<Parameter =
	  <classname = <Name = "Entity classname"> <Description = "Set entity classname"> <Type = "String"> <Default = "none">>
	>
	>*/  
	
	KeyInput 	= 0
	
	PRG 		= 0
	PRG_LIST 	= 0;
	PRG_MENU  	= 0;
	PRG_HINT	= 0;
	
	script_filename =0

	game_command = 0		
	enable = 0;
	enable_script = 0;
	
	constructor()
	{
		
		base.constructor()
		
		this.KeyInput 	= TKeyboard()
	
		this.PRG 		= TScript();
		this.PRG_LIST 	= 0;
		this.PRG_MENU  	= 0;
		this.PRG_HINT	= 0;
		
		this.script_filename =""
	
		this.game_command = ""		
		this.enable = false;
		this.enable_script = false;
	} 

	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		
		if (ItemIsCommandListDone(item)) 
		{
					
			if (this.game_command=="EXIT")
			{
			}
				
			if (this.game_command=="RESET")
			{
				this._RESET_SCENE_()
			}
		}
		if (this.enable)
		{
			if (this.KeyInput.IsUp(KeyEscape))
			{
								
				this.PRG_MENU.Show();
				this.PRG.Stop();
				this.enable_script = false;
					
				
				
			}
			
			
			if (this.enable_script)
			{
				// when cmd is done
				if (ItemIsCommandListDone(item)) 
				{
					
					if (this.game_command=="EXIT")
					{
					}
					
					if (this.game_command=="RESET")
					{
						this._RESET_SCENE_()
					}
					
					// and trace is enabled
					if (this.PRG.trace)
					{
					
						// and Key is released
						if (this.KeyInput.IsUp(KeySpace))
						{
							// DO execute
							if (this.PRG.state == __SCRIPT_LOAD__)
							{
								this.PRG.Execute();	
							}
							
							// DO trace manualy
							if (this.PRG.state == __SCRIPT_RUN__)
							{
								this.PRG.Next();	
							}
							
						}
					}
					else
					{
						// execute self
						if (this.PRG.state == __SCRIPT_LOAD__)
						{
							this.PRG.Execute();	
						}
							
						// trace self
						if (this.PRG.state == __SCRIPT_RUN__)
						{
							this.PRG.Next();	
						}
					}
					
				}
			}

			this.PRG_MENU.OnUpdate();
			this.PRG_LIST.Update();

		} 
			
			

	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{	
		debug("RLC_Player: OnSetup()")
		base.OnSetup(item)	
			
		
	}
	
	function	OnPreSetup(item)
	{
		debug("RLC_Player: OnPreSetup()")
	}

	function OnSetupDone(item)
	{	
		debug("RLC_Player: OnSetupDone()")	
		
				
	}
	
	function Enable()
	{
		debug("RLC_Player: Enable");
		this.CreateScriptList();
		this.CreateMenu()
		this.CreateHint()
		this.enable = true;	
	}
	
	function Disable()
	{
		this.enable = true;	
	}
	
	function CreateHint()
	{
		this.PRG_HINT = THUD_Text()
		this.PRG_HINT.Create("HEMIHEAD")
		this.PRG_HINT.SetFontSize(32)
		this.PRG_HINT.SetPosition(0,32); 
		this.PRG_HINT.SetFontColor(255,255,255,255)
		this.PRG_HINT.SetText("Load script file")
	}
	
	
	function CreateScriptList()
	{
		debug("RLC_Player: Create FILE listbox");
		
		this.PRG_LIST = TGUI_Filelistbox();
		this.PRG_LIST.Create("scripts\\user\\","*.nut")	
		this.PRG_LIST.SetPosition(400,300)		
		this.PRG_LIST.OnEnter = this.ExecuteDirList
		this.PRG_LIST.Hide(); 

		
	}
	
	function CreateMenu()
	{
		debug("RLC_Player: Create GAME MENU");
		
		this.PRG_MENU = TGUI_GameMenu();
		this.PRG_MENU.AddMenuItem("Load","textures/gui/button_n.png","textures/gui/button_cursor.png",true,"HEMIHEAD",32) 
		this.PRG_MENU.AddMenuItem("Run","textures/gui/button_n.png","textures/gui/button_cursor.png",false,"HEMIHEAD",32)
		this.PRG_MENU.AddMenuItem("Trace","textures/gui/button_n.png","textures/gui/button_cursor.png",false,"HEMIHEAD",32)
		this.PRG_MENU.AddMenuItem("Reset","textures/gui/button_n.png","textures/gui/button_cursor.png",false,"HEMIHEAD",32)
		this.PRG_MENU.AddMenuItem("Exit","textures/gui/button_n.png","textures/gui/button_cursor.png",false,"HEMIHEAD",32)
		
		
		local size = UIGetInternalResolution(SceneGetUI(g_scene));
		this.PRG_MENU.SetPosition((size.x/2)-(2.5*128),size.y-128);
		this.PRG_MENU.SetKeys(KeyLeftArrow,KeyRightArrow,KeySpace)
		this.PRG_MENU.SetItemOffset(128,0)
		this.PRG_MENU.SetCaptionOffset(16,64+16);
				
		this.PRG_MENU.OnEnter = this.ExecuteMenuButton
		this.PRG_MENU.Show();
		
	}
	
	function ResetCommandsList()
	{
		ItemResetCommandList(this._item)	
		
	}
	
	function ExecuteDirList(selected_file_name)
	{
		print(selected_file_name)
		local self = ItemGetScriptInstance(SceneFindItem(g_scene,"Player"))
		self.PRG_LIST.Hide();
		self.PRG_MENU.Show();	
		//self.script_filename = "scripts/user/RecursiveWalk.nut"	
		self.script_filename = "scripts/user/"+selected_file_name
		self.PRG_HINT.SetText("Script: ["+self.script_filename+"] loaded");
		
	}
	
	function ExecuteMenuButton(id)
	{
		
		local self = ItemGetScriptInstance(SceneFindItem(g_scene,"Player"))
		
		// LOAD
		if (id==0)
		{
			self.PRG_LIST.Show();
			self.PRG_MENU.Hide();
			self.enable_script = true
		}
		
		//RUN
		if (id == 1)
		{
			if (self.enable_script)
			{
				self.PRG.Load(self.script_filename,false);			
				self.PRG.trace = false
				self.PRG.Execute();
				self.PRG_MENU.Hide();
				self.enable_script = true
				self.PRG_HINT.SetText("Press [ESCAPE] to stop")
			}
			else
			{
				self.PRG_HINT.SetText("Load script file first !!!")
			}
		}
		
		//TRACE
		if (id == 2)
		{
			if (self.enable_script)
			{
				self.PRG.Load(self.script_filename,true);
				self.PRG.trace = true
				self.PRG_MENU.Hide();
				self.enable_script = true
				self.PRG_HINT.SetText("Press [SPACE] to next script step / Press [ESCAPE] to stop.")
			}
			else
			{
				self.PRG_HINT.SetText("Load script file first !!!")
			}
			
		}
		
		// Reset
		if (id == 3)
		{
			
			debug("RLC_Player: Call RESET Scene")
			self.game_command = "RESET"
		}
		
		// EXIT
		if (id == 4)
		{
			debug("RLC_Player: Call Exit ptogram")
			self.game_command="EXIT"
		}
	}
	
	
	
	function _RESET_SCENE_()
	{
		debug("RLC_Player: RESET Scene")
		ItemResetCommandList(this._item)
		this.game_command = ""
		this.enable = false
		this.enable_script = false
		this.ResetCommandsList();
		Reset();			
		this.enable = true	
				
	}
	
}
