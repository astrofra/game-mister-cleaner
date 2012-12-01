Include("Scripts/locale.nut")

class title_screen_level_preview
{
	window = 0;
	level = 0;
	frame = 0;
	pos_x = 0;
	pos_y = 96;
	x_off = 24
	
	txt_name = 0;
	txt_time = 0;
	
	constructor()
	{
		// window
		
		UILoadFont("fonts/HEMIHEAD.TTF")
		UILoadFont("fonts/Lifeline.ttf") 
				
		this.window = THUD_Sprite();
		this.window.Create("textures/hud/level_bkg.png")
		this.window.SetSize(512,512)		
		this.window.SetPosition(pos_x,32)
		this.window.SetDepth(0.5)
		
		
		// level
		this.level = THUD_Sprite();
		this.level.Create("textures/levels/level_0.png")
		this.level.SetSize(256,256)		
		this.level.SetPosition(pos_x+x_off,pos_y)
		this.level.SetDepth(0.5)
		
		
		// frame
		this.frame = THUD_Sprite();
		this.frame.Create("textures/hud/level_frame.png")
		this.frame.SetSize(256,256)		
		this.frame.SetPosition(pos_x+x_off,pos_y)
		this.frame.SetDepth(0.1)
		
		// text level name
		this.txt_name = THUD_Text()
		this.txt_name.Create("HEMIHEAD")
		this.txt_name.SetFontSize(32)
		this.txt_name.SetText("-------------")
		this.txt_name.SetPosition(pos_x+x_off,48)
		
		// text level time
		this.txt_time = THUD_Text()
		this.txt_time.Create("HEMIHEAD")
		this.txt_time.SetFontSize(32)
		this.txt_time.SetText(locale.hud_time + ": 0s")
		this.txt_time.SetPosition(pos_x+x_off,256+96)
		
		
	}

	function SetImage(ID)
	{
		
		local fname = g_levels[g_level_name[ID]].iconname
		local wname = g_levels[g_level_name[ID]].name
		local tim   = g_levels[g_level_name[ID]].g_score_time/10000
		
		// level
		
		this.level.Create(fname)
		this.level.SetSize(256,256)		
		this.level.SetPosition(pos_x+x_off,pos_y)
		this.txt_name.SetText(wname)
		this.txt_time.SetText("Time: "+tim.tostring())
		
		
	}

}