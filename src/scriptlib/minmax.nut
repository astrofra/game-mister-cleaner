/*
	nEngine	SQUIRREL binding API.
	Copyright 2005~2008 Emmanuel Julien.
*/

class	MinMax
{
	min			=	0
	max			=	0

	function        Grow(mm)
	{   return MinMax(min.Min(mm.min), max.Max(mm.max))		}

	function        Set(_min = Vector(), _max = Vector())
	{
		min = _min
		max = _max
	}

	constructor(_min = Vector(), _max = Vector())
	{   Set(_min, _max);    }
}
