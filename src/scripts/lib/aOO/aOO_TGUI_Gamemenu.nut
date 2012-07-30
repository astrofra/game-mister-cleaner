try
{	
	__DEFINE_GUI_GAMEMENU__ = 1;	
	print("INCLUDE: aOO - TGUI_GameMenu - exist")
}
catch(e)
{
	__DEFINE_GUI_GAMEMENU__ <- 1; 
	
	print("INCLUDE: aOO - TGUI_GameMenu")

	class TGUI_GameMenu
	{
		menu_lines = 0;
		item_count = 0;
		x = 0;
		y = 0;
		dx = 0;
		dy = 0;
		caption_off_x = 0;
		caption_off_y = 0;
		
		current_line_id = 0;
		
		KeyInput = 0;

		key_prev = 0;		
		key_next = 0;
		key_enter = 0;
		OnEnter = 0;
		
		enable = 0;
		
		constructor()
		{

			this.menu_lines = [];
			this.item_count = 0;
			this.x = 0;
			this.y = 0;
			this.dx = 256;
			this.dy = 0;
			this.caption_off_x = 24;
			this.caption_off_y = 24;
			
			this.current_line_id = 0;
			
			this.KeyInput = TKeyboard();
	
			this.key_prev = KeyLeftArrow;		
			this.key_next = KeyRightArrow;
			this.key_enter = KeySpace;
			this.OnEnter = null;
			
			this.enable = false;			
			
		}

		function AddMenuItem(caption,btn_normal,btn_over,act,fnt_name,fnt_size)
		{
			local menu_item = TGUI_GameMenuItem()
				
			menu_item.button_normal = THUD_Sprite(); 
			menu_item.button_normal.Create(btn_normal)
			menu_item.button_normal.SetPivot(0,0);
			menu_item.button_normal.SetPosition(this.x+this.item_count*dx,this.y+this.item_count*dy);
			
			menu_item.button_over = THUD_Sprite(); 
			menu_item.button_over.Create(btn_over)
			menu_item.button_over.SetPivot(0,0);
			menu_item.button_over.SetPosition(this.x+this.item_count*dx,100-this.y+this.item_count*dy);
			
			menu_item.caption = THUD_Text()
			menu_item.caption.Create(fnt_name)
			menu_item.caption.SetFontSize(fnt_size)
			menu_item.caption.SetText(caption) 
			menu_item.caption.SetPosition(this.x+this.caption_off_x+this.item_count*dx,this.y+this.caption_off_y+this.item_count*dy);
			
			


			menu_item.active = act
						
			this.menu_lines.append(menu_item)
			this.item_count = this.menu_lines.len();
		}
		
		
		function SetPosition(x,y)
		{
			this.x = x;
			this.y = y;	
			
			this.UpdatePositions()
		}
		
		function SetItemOffset(fx,fy)
		{
			this.dx = fx;
			this.dy = fy;	
			
			this.UpdatePositions()
		}
		
		
		function SetCaptionOffset(cx,cy)
		{
			this.caption_off_x = cx;
			this.caption_off_y = cy;	
			
			this.UpdatePositions()
		}
		
		function SetKeys(kprev,knext,kenter)
		{
			this.key_prev = kprev;		
			this.key_next = knext;
			this.key_enter = kenter;	
		}
		
		
		
		
		function OnUpdate()
		{
			if (this.enable)
			{
				if (this.KeyInput.IsUp(this.key_prev))
				{
					
					this.current_line_id--;
					if (this.current_line_id<0) this.current_line_id=0;
					this.ChangeActivateState()
				}
				
				if (this.KeyInput.IsUp(this.key_next))
				{	
					this.current_line_id++;
					if (this.current_line_id>this.menu_lines.len()-1) this.current_line_id=this.menu_lines.len()-1;
					this.ChangeActivateState()
				}
				
				if (this.KeyInput.IsUp(this.key_enter))
				{
					this.OnEnter(this.current_line_id);
				}
			}
			
		}
		
		function ChangeActivateState()
		{
			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].button_over.Hide()
				if (i==this.current_line_id)
				{
					this.menu_lines[i].button_over.Show()
				}
			}
			
		}
		
		function UpdatePositions()
		{
			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].caption.SetPosition(this.x+this.caption_off_x+i*dx,this.y+this.caption_off_y+i*dy);
				this.menu_lines[i].button_normal.SetPosition(this.x+i*dx,this.y+i*dy);
				this.menu_lines[i].button_over.SetPosition(this.x+i*dx,this.y+i*dy);
				
				
				if (this.menu_lines[i].active)
				{
					this.menu_lines[i].button_over.Show()					
				}
				else
				{
					this.menu_lines[i].button_over.Hide()
					
				}
				
			}
			
			
		}
		
		function Show()
		{
			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].Show();
				this.menu_lines[i].Show();
				this.menu_lines[i].Show();
				
			}
			this.current_line_id=0
			this.UpdatePositions()
			this.enable = true;
		}
		
		
		function Hide()
		{
			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].Hide();
				this.menu_lines[i].Hide();
				this.menu_lines[i].Hide();
				
			}
			
			this.enable = false;
		}
	}
}
