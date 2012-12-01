/*
	nEngine	SQUIRREL binding API.
	Copyright 2005~2008 Emmanuel Julien.
*/


class 	Vector2
{
	constructor(_x = 0.0, _y = 0.0)
	{   x = _x; y = _y	}

	function	Set(u, v)	{	x = u; y = v	}

	function	Scale(k)		{	return Vector2(x * k, y * k);		}

	function	Len2()			{	return x * x + y * y;	}
	function	Len()			{	local l = Len2(); return l ? sqrt(l) : 0.0;	}

	function    Dist(b)         {	return (b - this).Len();	}

	function	Max(b)			{	return Vector2(x > b.x ? x : b.x, y > b.y ? y : b.y);	}
	function	Min(b)			{	return Vector2(x < b.x ? x : b.x, y < b.y ? y : b.y);	}

	function	Lerp(k, b)
	{
		local	ik = 1.0 - k;
		return Vector2(x * k + b.x * ik, y * k + b.y * ik);
	}

	function	Normalize(length = 1.0)
	{
		local	k = Len();
		if	(k < 0.000001)
				k = 0.0;
		else	k = length / k;
		return Vector2(x * k, y * k);
	}

	function	ApplyMatrix(m)
	{
		return Vector2	(
							x * m.m00 + y * m.m01 + m.m02,
							x * m.m10 + y * m.m11 + m.m12
						);
	}
	function	ApplyRotationMatrix(m)
	{
		return Vector2	(
							x * m.m00 + y * m.m01,
							x * m.m10 + y * m.m11	
						);
	}

	function	Reverse()		{	return Vector2(-x, -y);	}

	function	_add(v)
	{
		switch (typeof(v))
		{
			case "integer":
			case "float":
				return Vector2(x + v, y + v);
		}
		return Vector2(x + v.x, y + v.y);
	}
	function	_sub(v)
	{
		switch (typeof(v))
		{
			case "integer":
			case "float":
				return Vector2(x - v, y - v);
		}
		return Vector2(x - v.x, y - v.y);
	}
	function	_mul(v)
	{
		switch (typeof(v))
		{
			case "integer":
			case "float":
				return Vector2(x * v, y * v);
		}
		return Vector2(x * v.x, y * v.y);
	}
	function	_div(v)
	{
		switch (typeof(v))
		{
			case "integer":
			case "float":
				return Vector2(x / v, y / v);
		}
		return Vector2(x / v.x, y / v.y);
	}
	function	_unm(v)
	{	return Vector2(-x, -y);	}

	function	Clamp(min, max)
	{	return Vector2(::Clamp(x, min, max), ::Clamp(y, min, max));	}
	function	Clamp2d(vmin, vmax)
	{	return Vector2(::Clamp(x, vmin.x, vmax.x), ::Clamp(y, vmin.y, vmax.y));	}
	function	ClampMagnitude(mag)
	{
		local 	l = Len2();
		if	(l < (mag * mag))
			return this;
		if	(l < 0.000001)
			return this;
		l = sqrt(l);
		return this.MulReal(mag / l);
	}

	function	Randomize(a, b)
	{	return Vector2(Rand(a, b), Rand(a, b));	}

	function	Print()
	{	::print("X = " + x + ", Y = " + y + ".\n");	}

	x = 0.0; y = 0.0;
}
