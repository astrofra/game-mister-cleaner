// test RESET cmd




function Callback()
{
	while (!IsWall())
	{
		Move();	
	}
	Reset();
	TurnLeft()
	Callback()
}


Callback()