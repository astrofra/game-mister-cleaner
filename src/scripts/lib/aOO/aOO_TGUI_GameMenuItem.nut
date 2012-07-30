try
{	
	__DEFINE_GUI_GAMEMENUITEM__ = 1;	
	print("INCLUDE: aOO - TGUI_GameMenuItem - exist")
}
catch(e)
{
	__DEFINE_GUI_GAMEMENUITEM__ <- 1; 
	
	print("INCLUDE: aOO - TGUI_GameMenuItem")

	class TGUI_GameMenuItem
	{
		caption = 0;
		button_normal = 0;
		button_over   = 0;
		active = 0;

		constructor()
		{
			this.caption = 0;
			this.button_normal = 0;
			this.button_over   = 0;
			this.active = true;			
		}

		function Hide()
		{
			this.button_normal.Hide()
			this.button_over.Hide()
			this.caption.Hide()
			
		}
		
		function Show()
		{
			this.button_normal.Show()
			this.button_over.Show()	
			this.caption.Show()
		}


	}
}