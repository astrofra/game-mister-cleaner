// test PUT command

print("USER: Start ... ;) ")

local i = 0;

for (i=0;i<20;i++)
{
	Move();
	if (IsBrick())
	{
		Take();
	}
	else
	{
		Put();
	}
	TurnLeft();
}

print("USER: I'm done ... ;) ")
