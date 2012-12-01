class TGUI_Window
{
	ui = 0;
	window = 0;
	
	constructor()
	{
		this.ui = SceneGetUI(g_scene)	
	}
	
	
	function CreateWindow(title,w,h)
	{	
				/*
				UISetSkin(this.ui,
				  "textures/gui_theme/agfx_gui_top.png",
                  "textures/gui_theme/agfx_gui_left.png",
                  "textures/gui_theme/agfx_gui_right.png",
                  "textures/gui_theme/agfx_gui_bottom.png",
                  "textures/gui_theme/agfx_gui_top_left.png",
                  "textures/gui_theme/agfx_gui_top_right.png",
                  "textures/gui_theme/agfx_gui_bottom_left.png",
                  "textures/gui_theme/agfx_gui_bottom_right.png",
				   0xffe6e6e6 ,0xff000000,32,64,24, "fonts/HEMIHEAD.ttf")
				   */
		this.window = UIAddWindow(this.ui,-1,0,0,w,h)
		//WindowSetBackgroundPicture(this.window,"textures/gui_theme/agfx_gui_middle.png")
		//WindowSetBackgroundColor(this.window,0xffffffff);
		WindowSetTitle(this.window,title);
		
	}
	
	function SetPosition(x,y)
	{
		WindowSetPosition(this.window,x,y)
	}
}