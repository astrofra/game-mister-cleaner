try
{	
	__DEFINE_HUD_TEXT__ = 1;	
	
	print("INCLUDE: aOO - THUD_Text - exist")
}
catch(e)
{
	print("INCLUDE: aOO - THUD_Text")
	
	__DEFINE_HUD_TEXT__ <- 1; 
	
	class THUD_Text
	{
		ui = 0;
		window = 0 
		widget = 0;
		
		constructor()
		{
			
			this.ui = SceneGetUI(g_scene)
			
			// Create UI window.
			this.window = UIAddWindow(this.ui, -1, 0, 0, 800, 48)
			WindowSetStyle(this.window,StyleNoDecoration)
			
			// Center window pivot.		
			WindowSetPivot(this.window, 0,0)
			WindowSetTitle(this.window,"");
			
		}
		// --------------------------------------------------------------
		// create
		// --------------------------------------------------------------
		function Create(fnt_name)
		{
			this.widget = UIAddStaticTextWidget(this.ui, -1, "", fnt_name)
			WindowSetBaseWidget(this.window, this.widget)
			TextSetSize(widget, 10)
			TextSetColor(widget, 0, 0, 0, 255)
			TextSetAlignment(widget, TextAlignLeft)	
		}
		
		// --------------------------------------------------------------
		// set position
		// --------------------------------------------------------------
		function SetPosition(x,y)
		{
			print(this.window)
			WindowSetPosition(this.window,x,y)		
		}
		
	
	    // --------------------------------------------------------------
		// set font color
		// --------------------------------------------------------------
		function SetFontSize(fs)
		{
			TextSetSize(widget, fs)		
		}
	
		// --------------------------------------------------------------
		// set text color
		// --------------------------------------------------------------
		function SetFontColor(r,g,b,a)
		{
			TextSetColor(widget, r, g, b, a)	
		}
		
		// --------------------------------------------------------------
		// Set text
		// --------------------------------------------------------------
		function SetText(txt)
		{
			TextSetText(this.widget,txt)	
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