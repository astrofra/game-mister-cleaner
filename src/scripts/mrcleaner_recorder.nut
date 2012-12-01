class TMoveRecorder
{
	record = 0
	childnode = 0
	count = 0
	cmd_id = 0
	
	constructor()
	{
		this.record = TIO_metadata()
	}

	function Initialize(level_id)
	{
		this.record = TIO_metadata()
		this.record.CreateRoot("Record")
		this.childnode = this.record.CreateChild(g_level_name[level_id])
		count = 0
	
	}	
	
	function AddMoveCommand(cmd)
	{
		this.record.AddChildValue(this.childnode,"cmd_"+this.count,cmd)	
		this.count = this.count + 1
	}
	
	function Save(level_id)
	{
		this.record.Save("records/"+g_level_name[level_id]+".record")
		this.record.Clean()
	}
	
	function Clear()
	{
		this.record.Clean()	
	}
	
	function Exist(level_id)
	{
		return FileExists("records/"+g_level_name[level_id]+".record")
	}
	
	function Load(level_id)
	{
		print("LOAD RECORD")
		this.record.Clean()
		this.record.Load("records/"+g_level_name[level_id]+".record")
		this.count=0
		this.cmd_id = 0
	}
	
	function GetNextCommand(level_id)
	{
		local cmd = this.record.GetValue("Record:"+g_level_name[level_id]+":cmd_"+cmd_id)
		this.cmd_id = this.cmd_id+1		
		return cmd
		
	}
}