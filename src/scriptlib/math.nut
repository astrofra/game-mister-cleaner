/*
	nEngine	SQUIRREL binding API.
	Copyright 2005~2008 Emmanuel Julien.
*/

function	Deg(deg)
{	return deg * PI / 180.0;	}
function	DegreeToRadian(deg)
{	return Deg(deg);	}
function	RadianToDegree(rad)
{	return rad * 180.0 / PI;	}

function	Tn(v)	{	return v * 1000.0;	}
function	Kg(v)	{	return v;	}
function	Gr(v)	{	return v * 0.001;	}

function	Km(v)	{	return v * 1000.0;	}
function	MtrToKm(v)	{	return v / 1000.0;	}
function	Mtr(v)	{	return v;	}
function	Cm(v)	{	return v * 0.01;	}
function	Mm(v)	{	return v * 0.001;	}

function	Sec(v)	{	return v;	}
function	SecToTick(v)
{	return v * SystemClockFrequency;	}
function	TickToSec(v)
{	return v / SystemClockFrequency;	}

function	Mtrs(v)	{	return v;	}
function	Kmh(v)	{	return v / 3.6;	}

function	KmhToMtrs(v)
{	return v / 3.6;		}
function	MtrsToKmh(v)
{	return v * 3.6;		}

function	HintKmh(v)
{	return v;	}

function	Clamp(v, min, max)
{
	if	(v < min)
		return min;
	if	(v > max)
		return max;
	return v;
}
function	Loop(v, min, max)
{
	if	(v < min)
		return max;
	if	(v > max)
		return min;
	return v;
}
function	Min(a, b)
{	return a < b ? a : b;	}
function	Max(a, b)
{	return a > b ? a : b;	}
function	Lerp(k, a, b)
{	return (b - a) * k + a;		}
function	RangeAdjust(k, a, b, u, v)
{	return (k - a) / (b - a) * (v - u) + u;	}
function	RangeAdjustClamped(k, a, b, u, v)
{	return Clamp((k - a) / (b - a) * (v - u) + u, u, v);	}
function	Max(a, b)
{	return a > b ? a : b;	}
function	Min(a, b)
{	return a < b ? a : b;	}

function    Rand(min, max)
{	return SystemRand(RAND_MAX).tofloat() / RAND_MAX * (max - min) + min;		}
function	Irand(min, max)
{	return (SystemRand(RAND_MAX) % (max - min)) + min;	}

function	SignedPow(v, e)
{
	local	neg = v < 0 ? true : false;
	v = Pow(Abs(v), e);
	return neg ? -v : v;
}

function    RoundFloatValue(v)
{	return floor(v * 100.0) / 100.0;	}

function	Sign(v)
{	return v < 0.0 ? -1.0 : 1.0;	}
function	Normalize(v, a, b)
{	return Clamp((v - a) / (b - a), 0.0, 1.0);	}

function	Mod(v, m)
{	return v - floor(v / m) * m;	}
function	Abs(v)
{	return v < 0.0 ? -v : v;	}

Euler_XYZ <- 0;
Euler_XZY <- 1;
Euler_YXZ <- 2;
Euler_YZX <- 3;
Euler_ZXY <- 4;
Euler_ZYX <- 5;
Euler_YX <- 6;
Euler_Default <- Euler_ZXY;
