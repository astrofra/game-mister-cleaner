
try
{	
	__DEFINE_GUI_WINDOW__ = 1;	
	
	print("INCLUDE: aOO - TGUI_Window - exist")
}
catch(e)
{
	__DEFINE_GUI_WINDOW__ <- 1; 
	
	print("INCLUDE: aOO - TGUI_Window") 

	class TGUI_Window
	{
		ui = 0;
		window = 0;
		
		constructor()
		{
			this.ui = 0;
			this.window = 0;
			this.ui = SceneGetUI(g_scene)	
		}
		
		
		// --------------------------------------------------------------
		// Create
		// --------------------------------------------------------------
		function CreateWindow(title,w,h,fnt_name)
		{
	
			UISetSkin(this.ui,
					  "textures/gui_theme/agfx_gui_top.png",
	                  "textures/gui_theme/agfx_gui_left.png",
	                  "textures/gui_theme/agfx_gui_right.png",
	                  "textures/gui_theme/agfx_gui_bottom.png",
	                  "textures/gui_theme/agfx_gui_top_left.png",
	                  "textures/gui_theme/agfx_gui_top_right.png",
	                  "textures/gui_theme/agfx_gui_bottom_left.png",
	                  "textures/gui_theme/agfx_gui_bottom_right.png",
					   0xff1eaaff ,0xff000000,32,64,24, fnt_name)
			
			
			this.window = UIAddWindow(this.ui,-1,0,0,w,h)
			//WindowSetBackgroundPicture(this.window,"textures/gui_theme/agfx_gui_middle.png")
			//WindowSetBackgroundColor(this.window,0xffffffff);
			WindowSetTitle(this.window,title);
			
		}
		
		// --------------------------------------------------------------
		// SetPosition
		// --------------------------------------------------------------
		function SetPosition(x,y)
		{
			WindowSetPosition(this.window,x,y)
		}
		
		// --------------------------------------------------------------
		// Hide
		// --------------------------------------------------------------
		function Hide()
		{
			WindowShow(this.window,false)	
		}
		
		
		// --------------------------------------------------------------
		// Show
		// --------------------------------------------------------------
		function Show()
		{
			WindowShow(this.window,true)	
		}
	}
}