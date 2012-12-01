	
	print("INCLUDE: aOO - TGUI_GameMenuItem")

	class TGUI_GameMenuItem
	{
		caption = 0;
		button_normal = 0;
		button_over   = 0;
		active = true;
		hint_txt = ""

		constructor()
		{
			
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
