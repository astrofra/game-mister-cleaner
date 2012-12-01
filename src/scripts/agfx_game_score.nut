
g_score_time  <- 0 ;
g_score_steps <- 0 ;
g_score_turn_left <- 0 ;
g_score_turn_right <- 0 ;
g_score_turn_back <- 0 ;

class TGameScore
{
	function PrintInfo()
	{
		/*
		print("STEP   :"+g_score_steps)	
		print("LEFT   :"+g_score_turn_left)
		print("RIGH   :"+g_score_turn_right)
		print("BACK   :"+g_score_turn_back)
		print("--------------------------")
		*/
		
	}
	
	function AddStep()
	{
		this.g_score_steps++;	
				
	}
	
	function AddTurnLeft()
	{
		this.g_score_turn_left++;
	}
	
	function AddTurnRight()
	{
		this.g_score_turn_right++;
	}
	
	function AddTurnBackward()
	{
		this.g_score_turn_back++;
		this.g_score_turn_back++;
	}
	
	function GetCount()
	{
		return 	this.g_score_steps + this.g_score_turn_left + this.g_score_turn_right + this.g_score_turn_back
	}

	function Reset()
	{
		g_score_time  = 0 ;
		g_score_steps = 0 ;
		g_score_turn_left = 0 ;
		g_score_turn_right = 0 ;
		g_score_turn_back = 0 ;
		
	}
}