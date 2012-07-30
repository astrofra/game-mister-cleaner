
try
{	
	__DEFINE_GUI_FILELISTBOX__ = 1;	
	
	print("INCLUDE: aOO - TGUI_Filelistbox - exist")
}
catch(e)
{
	__DEFINE_GUI_FILELISTBOX__ <- 1; 
	
	print("INCLUDE: aOO - TGUI_Filelistbox") 
	
	
	
	class TGUI_Filelistbox
	{
		BKG = 0;
		DIR = 0;
		CURSOR = 0;
		cursor_line_id = 0;
		cursor_file_id = 0;
		
		KeyInput = 0;

		FILES=0;
		
		files_count=0;
		files_to_show = 10;
		from_id = 0;		
		
		x = 0;
		y = 0;
		
		selected_filename = 0
		enable = 0;
		OnEnter = 0;
		
		constructor()
		{
			
			this.BKG = 0;
			this.DIR = TDirectoryList();
			this.CURSOR = 0;
			this.cursor_line_id = 0;
			this.cursor_file_id = 0;
			
			this.KeyInput = 0;
	
			this.FILES=[];
			
			this.files_count=0;
			this.files_to_show = 10;
			this.from_id = 0;		
			
			this.x = 400;
			this.y = 300;
			
			this.selected_filename = ""
			this.enable = true;
			this.OnEnter = null;
		
			UILoadFont("fonts/HEMIHEAD.TTF") 
			this.KeyInput = TKeyboard()
		}
		
		// --------------------------------------------------------------
		// create
		// --------------------------------------------------------------
		function Create(dir_path,ext)
		{
			
			this.DIR.ReadFileList(dir_path,ext);
			
			this.CreateFrame();
			
			this.CreateCursor();
			
			this.CreateFileList();
			
			
		}
		
		// --------------------------------------------------------------
		// INTERNAL:
		// --------------------------------------------------------------
		function CreateFrame()
		{
			this.BKG = THUD_Sprite();
			this.BKG.Create("textures/gui/GUI_FilesFrame.png");
			this.BKG.SetPivot(0,0);
			this.BKG.SetPosition(this.x,this.y);
			
		}
		
		// --------------------------------------------------------------
		// INTERNAL:
		// --------------------------------------------------------------
		function CreateCursor()
		{
			this.CURSOR = THUD_Sprite();
			this.CURSOR.Create("textures/gui/GUI_FIlelistbox_cursor.png");
			this.CURSOR.SetPivot(0,0);
			this.CURSOR.SetPosition(this.x+64,this.y+128+12);
		}
		
		// --------------------------------------------------------------
		// INTERNAL:
		// --------------------------------------------------------------
		function CreateFileList()
		{
			this.files_count=this.DIR.filelist.len()
			
			if (this.files_count>10)
			{
				this.files_to_show = 10;	
			}
			else
			{
				this.files_to_show=this.files_count;
			}
			
			for(local i=0; i<this.files_to_show;i++)
			{
				local text = THUD_Text()
				text.Create("HEMIHEAD")
				text.SetFontSize(24)
				text.SetText(this.DIR.filelist[i])
				text.SetPosition(this.x+128,this.y+i*32+128) 
				this.FILES.append(text)
				
			}
		}
		
		// --------------------------------------------------------------
		// Update
		// --------------------------------------------------------------
		function Update()
		{
			if (this.enable)
			{
				this.CURSOR.SetPosition(this.x+64,this.y+this.cursor_line_id*32+140);	
	
				if(this.KeyInput.IsUp(KeyUpArrow))
				{
					this.MoveCursorUp()
				}	
				
				if(this.KeyInput.IsUp(KeyDownArrow))
				{
					this.MoveCursorDown()
				}
				
				if(this.KeyInput.IsUp(KeySpace))
				{
					this.OnEnter(this.selected_filename);
					debug(this.selected_filename)
				}	
				if(this.KeyInput.IsUp(KeyEscape))
				{
					this.OnEnter(this.selected_filename);
					debug(this.selected_filename)
				}
			}
			
		}
		
		
		// --------------------------------------------------------------
		// INTERNAL
		// --------------------------------------------------------------
		function SetTextList()
		{
			this.selected_filename = this.DIR.filelist[this.cursor_file_id]
			
			if (this.cursor_line_id==9) this.from_id++; 
			if (this.cursor_line_id==0) this.from_id--; 
			
			if (from_id<0) from_id=0;
			
			if ((from_id+this.files_to_show)>this.files_count) from_id = this.files_count-this.files_to_show;
			
			for(local i=0;i<this.files_to_show;i++)
			{
				this.FILES[i].SetText(this.DIR.filelist[from_id+i])
			}
			
			
			
		}
		
		// --------------------------------------------------------------
		// INTERNAL:
		// --------------------------------------------------------------
		function MoveCursorDown()
		{
			if(WindowIsCommandListDone(this.CURSOR.sprite))
			{
				
				if(this.cursor_line_id<this.files_to_show-1)
				{
					this.cursor_line_id++;
					this.cursor_file_id++;
					
					
				}
				else
				{
					if(this.cursor_file_id<this.files_count-1)
					{
						this.cursor_file_id++;
					}
					
				}
								
				
				this.SetTextList()
			}
		}
		
		// --------------------------------------------------------------
		// INTERNAL:
		// --------------------------------------------------------------
		function MoveCursorUp()
		{
			if(WindowIsCommandListDone(this.CURSOR.sprite))
			{
				if (this.cursor_line_id>0)
				{
					
					this.cursor_line_id--;
					this.cursor_file_id--;
					
				}
				else
				{
					
					this.cursor_file_id--;
					
					if(this.cursor_file_id<0)
					{
						this.cursor_file_id=0;
					}	
				}

				this.SetTextList()
				
			}
		}
		
		
		// --------------------------------------------------------------
		// set position
		// --------------------------------------------------------------
		function SetPosition(x,y)		
		{
			this.x = x
			this.y = y
			
			// bkg
			
			this.BKG.SetPosition(this.x,this.y);
			
			// list
			
			for(local i=0; i<this.files_to_show;i++)
			{
				this.FILES[i].SetPosition(this.x+128,this.y+i*32+128) 
			}
			
			// cursor
			
			this.CURSOR.SetPosition(this.x+64,this.y+128+12);
		}
		
		// --------------------------------------------------------------
		// hide
		// --------------------------------------------------------------
		function Hide()
		{
			this.BKG.Hide()
			this.CURSOR.Hide()
			
			for(local i=0; i<this.files_to_show;i++)
			{
				this.FILES[i].Hide()
			}
			this.enable = false
		}
		
		// --------------------------------------------------------------
		// show
		// --------------------------------------------------------------
		function Show()
		{
			this.BKG.Show()
			this.CURSOR.Show()
			
			for(local i=0; i<this.files_to_show;i++)
			{
				this.FILES[i].Show()
				
			}
			
			this.enable = true
		}
	}
}
