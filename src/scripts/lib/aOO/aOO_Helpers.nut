
print("INCLUDE: aOO - Helpers")

function CopyString(str,from,to)
{
	local s=""
	
	for(local i=from;i<to;i++)
	{
		s = s + str[i].tochar()	
		
	}
	
	return s
}

function debug(txt)
{
	if (DEBUG)
	{

		local datum = date(time())
		local str = format("%2d.%2d.%4d %2d:%2d:%2d | %s",datum["day"],datum["month"],datum["year"],datum["hour"],datum["min"],datum["sec"],txt)
		print(str)
	}
}

function CreateBoxCollisionShape(item)
{
	
	local	_shape	= ItemAddCollisionShape(item)
	local	_size	= Vector(0,0,0),
	_pos	= Vector(0,0,0),
	_scale	= Vector(0,0,0)

	local	_mm = ItemGetMinMax(item)
		
	_scale = ItemGetScale(item)
		
		
	_size.x = _mm.max.x -  _mm.min.x
	_size.y = _mm.max.y -  _mm.min.y
	_size.z = _mm.max.z -  _mm.min.z

	_pos = (_mm.max).Lerp(0.5, _mm.min)

	ItemSetPhysicMode(item, PhysicModeKinematic)
	ShapeSetBox(_shape, _size)
	ShapeSetPosition(_shape, _pos)

	ShapeSetMass(_shape, 0)
	ItemWake(item) 		
}