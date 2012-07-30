try
{	
	__DEFINE_KEYBOARD__ = 1;	
	
	print("INCLUDE: aOO - TKeyboard - exist")
}
catch(e)
{
	print("INCLUDE: aOO - TKeyboard")
	
	__DEFINE_KEYBOARD__ <- 1; 

	class TKeyboard
	{
		key_state = 0
		
		constructor()
		{
			key_state = array(50,0)
		}
		
		// --------------------------------------------------------------------		
		// Is key pressed
		// --------------------------------------------------------------------
				
		function IsDown(key)
		{		
			KeyboardUpdate() 
			return KeyboardSeekFunction(DeviceKeyPress, key)
		}
	
		// --------------------------------------------------------------------		
		// Is key released
		// --------------------------------------------------------------------
		
		function IsUp(key)
		{
			KeyboardUpdate() 
		
			// get key state
			local down = KeyboardSeekFunction(DeviceKeyPress, key)
			
			// when pressed
			if (down==true)
			{
				// store state and return false
				key_state[key] = true
				return false;	
			}
		
			// when released
			if ((key_state[key]==true) && (down==false))
			{
				// return true and reset key state
				key_state[key] = false
				return true
			}
		
			return false	 
			
		}	
	
	}
}