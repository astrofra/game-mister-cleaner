try
{	
	__DEFINE_GUI_DIRECTORILIST__ = 1;	
	
	print("INCLUDE: aOO - TDirectoryList - exist")
}
catch(e)
{
	__DEFINE_GUI_DIRECTORILIST__ <- 1; 
	
	print("INCLUDE: aOO - TDirectoryList") 

	class TDirectoryList
	{
	
		path = 0
		filelist=0
		
		constructor()
		{
			path = ""
			filelist=[]	
		}
		
		
		function ReadFileList(path,extension)
		{
			this.path = path
			local dir_text = system("dir "+path+extension+" > dir.list")	
			
			local dir_file = file("dir.list","rb+");
	
			local file_size = dir_file.len()
	
			local data = ""
			
			while (!dir_file.eos())
			{
					local VAL = dir_file.readn('b')
					
					data = data + VAL.tochar()
				
			}
			
			local list = []
			list = split(data, "\n");
			
			for(local i=0;i<list.len();i++)
			{
				local last_id = list[i].len()-2;
				
				if (last_id>0)
				{
					
					if ((list[i][last_id-0].tochar()==extension[4].tochar()) &&
						(list[i][last_id-1].tochar()==extension[3].tochar()) &&
						(list[i][last_id-2].tochar()==extension[2].tochar()) &&
						(list[i][last_id-3].tochar()==extension[1].tochar()))
						{
							local file_name = split(list[i], " ");
							local cstr = file_name[file_name.len()-1]
							cstr = CopyString(cstr,0,cstr.len()-1)
							this.filelist.append(cstr)							
							
						}
				}
				
			}
		}
				
		
	}
}