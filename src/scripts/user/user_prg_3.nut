// walk around walls




function Callback()
{
	while (!IsWall())
	{
		Move();	
	}
	
	TurnLeft()
	Callback()
}


Callback()