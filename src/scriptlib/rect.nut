/*
	naD/bfmk Squirrel naD binding struct definition.
	Copyright 2005 Emmanuel Julien.
*/

class Point
{
	constructor(...)
	{
		assert((vargc == 0) || (vargc == 2));
		if	(vargc == 2)
		{	x = vargv[0]; y = vargv[1];		}
	}
	x = 0.0; y = 0.0;
}

class Rect
{
	constructor(...)
	{
		local   vargc = vargv.len();
		assert((vargc == 0) || (vargc == 4));
		if	(vargc == 4)
		{	sx = vargv[0]; sy = vargv[1]; ex = vargv[2]; ey = vargv[3];	}
	}

	function	IsInside(p)
	{	return (p.x > sx) && (p.y > sy) && (p.x < ex) && (p.y < ey);	}

	function	Set(u, v, s, t)	{	sx = u; sy = v; ex = s; ey = t;	}

	function	Print()
	{	::print("SX = " + sx + ", SY = " + sy + ", EX = " + ex + ", EY = " + ey + ".\n");	}

	function	GetWidth()
	{	return ex - sx;		}
	function	GetHeight()
	{	return ey - sy;		}

	function	Contract(s)
	{	return Rect(sx + s, sy + s, ex - s, ey - s);	}
	function	Expand(s)
	{	return Contract(-s);	}

	function	Offset(x, y)
	{	return Rect(sx + x, sy + y, ex + x, ey + y);	}

	function	CenterIn(r)
	{
		local		_sx = ((r.ex - r.sx) - (ex - sx)) * 0.5 + r.sx,
					_sy = ((r.ey - r.sy) - (ey - sy)) * 0.5 + r.sy;
		return Rect(_sx, _sy, _sx + (ex - sx), _sy + (ey - sy));
	}

	function	GetCenter()
	{	return Point((sx + ex) * 0.5, (sy + ey) * 0.5);		}

	sx = 0.0; sy = 0.0; ex = 0.0; ey = 1.0;
}
