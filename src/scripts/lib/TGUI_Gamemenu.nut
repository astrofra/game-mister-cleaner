	
	print("INCLUDE: aOO - TGUI_GameMenu")

	class TGUI_GameMenu
	{
		ui = 0
		menu_lines = 0; //[];
		item_count = 0;
		x = 0;
		y = 0;
		dx = 256;
		dy = 0;
		caption_off_x = 24;
		caption_off_y = 24;
		background_window = 0;
		
		current_line_id = 0;
		
		KeyInput = 0; //TKeyboard();

		key_prev = KeyLeftArrow;		
		key_next = KeyRightArrow;
		key_enter = KeySpace;
		OnEnter = null;
		HINT = 0;
		enable = false;
		
		constructor()
		{
			menu_lines = [];
			KeyInput = TKeyboard();
			this.CreateHint(0,0)
			this.ui = SceneGetUI(g_scene)

			// Create the background.
			background_window = UIAddBitmapWindow(ui, -1, "textures/hud/hud_background_bottom.tga", 0, 0, 1024, 256)
			WindowSetPivot(background_window, 512, 128)
			WindowSetPosition(background_window, 1280/2.0, 1024 + 32.0)
			WindowSetOpacity(background_window, 0.6)			
			WindowSetScale(background_window, 2.0, 2.0)
			WindowSetZOrder(background_window, 1.0)
		}

		function AddMenuItem(caption,btn_normal,btn_over,act,fnt_name,fnt_size,hint)
		{
			local menu_item = TGUI_GameMenuItem()
			
			menu_item.hint_txt = hint
				
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
		
		function CreateHint(hx,hy)
		{
			
			this.HINT = THUD_Text()
			this.HINT.Create("HEMIHEAD")
			this.HINT.SetFontSize(32)
			this.HINT.SetPosition(hx,hy); 
			this.HINT.SetFontColor(255,255,255,255)
			this.HINT.SetText("")
		} 
		function SetPosition(x,y)
		{
			this.x = x;
			this.y = y;	
			this.HINT.SetPosition(x,y);
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
				this.HINT.SetText(this.menu_lines[this.current_line_id].hint_txt)
				
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
					this.OnEnter(this.current_line_id,this);
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
			print("UPDATE BUTTON POSTION")
				for (local i=0;i<this.menu_lines.len();i++)
				{
					this.menu_lines[i].caption.SetPosition(this.x+this.caption_off_x+i*dx,this.y+this.caption_off_y+i*dy);
					this.menu_lines[i].button_normal.SetPosition(this.x+i*dx,this.y+i*dy);
					this.menu_lines[i].button_over.SetPosition(this.x+i*dx,this.y+i*dy);
				
				
					if (this.menu_lines[i].active)
						this.menu_lines[i].button_over.Show()					
					else
						this.menu_lines[i].button_over.Hide()
				}
		}
		
		function Show()
		{
			WindowShow(background_window, true)

			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].Show();
				this.menu_lines[i].Show();
				this.menu_lines[i].Show();
				
			}
			this.current_line_id=0
			this.UpdatePositions()
			this.enable = true;
			this.HINT.Show()
		}
		
		
		function Hide()
		{
			WindowShow(background_window, false)

			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i].Hide();
				this.menu_lines[i].Hide();
				this.menu_lines[i].Hide();
				
			}
			this.HINT.Hide()
			this.enable = false;
		}
		
		function Free()
		{
			this.enable = false
			this.current_line_id=0
			this.OnEnter = null;
			for (local i=0;i<this.menu_lines.len();i++)
			{
				this.menu_lines[i]= null
			}
			background_window = null
		}
	}
