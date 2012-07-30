__SCRIPT_NONE__ 	<- 0; 
__SCRIPT_LOAD__ 	<- 1; 
__SCRIPT_RUN__ 		<- 2; 
__SCRIPT_DONE__ 	<- 3; 
__SCRIPT_PAUSE__ 	<- 4;

g_script_thread <- 0;
g_script <- 0;

class TScript 
{  
 	state = -1;
	script = 0;
	trace = false ; 
	
	constructor()
	{
		
	}
	
	
	// ------------------------------------------------------------------------------------
	// TScript: Load
	// ------------------------------------------------------------------------------------
	function Load(script_name, tr = true)
	{
		try
		{
			debug("Loading script: '"+script_name+"'")
			this.state = __SCRIPT_LOAD__;
			this.trace = tr
			g_script = loadfile(script_name,true);
			print(g_script)
		}
		catch(e)
		{
			debug("ERROR: "+e)	
		}
			
			
	}
	
	// ------------------------------------------------------------------------------------
	// TScript: Run
	// ------------------------------------------------------------------------------------
	function Run(script_name, tr = true)
	{
		try
		{
			debug("Run script: '"+script_name+"'")
			this.state = __SCRIPT_LOAD__;
			this.trace = tr
			g_script = dofile(script_name,true);
			this.Execute();
		}
		catch(e)
		{
			debug("ERROR: "+e)
		}
	}
			
	// ------------------------------------------------------------------------------------
	// TScript: execute
	// ------------------------------------------------------------------------------------
	function Execute()
	{
		try
		{
			debug("TScript: Execute script")
			this.state = __SCRIPT_RUN__;
			
			g_script_thread = newthread(g_script);
		
			local ret = g_script_thread.call();
		}
		catch(e)
		{
			debug("ERROR: "+e)
		}

	}
	
	
	// ------------------------------------------------------------------------------------
	// TScript: trace step
	// ------------------------------------------------------------------------------------
	function Next()
	{
		try
		{
			debug("TScript: Next step script")
			local res = g_script_thread.wakeup();
	
			if (res==null)
			{
				this.state = __SCRIPT_DONE__;
				debug("TScript: Script is done.")
			}
		}
		catch(e)
		{
			debug("ERROR: "+e)			
		}
		
		
	}
	
	// ------------------------------------------------------------------------------------
	// TScript: stop and free
	// ------------------------------------------------------------------------------------
	function _IsDone_()
	{
		local res = false;
		if (this.state==__SCRIPT_DONE__)
		{

			res = true;
		}

		return res
	}

	// ------------------------------------------------------------------------------------
	// TScript: stop and free
	// ------------------------------------------------------------------------------------
	function Stop()
	{
		try
		{
			if ((this.state == __SCRIPT_RUN__) || (this.state == __SCRIPT_DONE__) || (this.state == __SCRIPT_LOAD__))
			{
				debug("TScript: Script is stopped.")
				this.state = __SCRIPT_NONE__;
				suspend("g_script");			
				g_script = null;		
			}
		}
		catch(e)
		{
			debug("ERROR: "+e)			
		}
	}
	
}