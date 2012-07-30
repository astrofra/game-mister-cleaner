SPLINE_XYZ <- 0
SPLINE_XY <- 1
SPLINE_YZ <- 2
SPLINE_XZ <- 3

class TSpline
{
	A = 0;
	B = 0;
	C = 0;
	D = 0;
	E = 0;
	F = 0;
	G = 0;
	H = 0;
	I = 0;
	J = 0;
	K = 0;
	L = 0;
	
	mode = SPLINE_XYZ;

	constructor()
	{
		
		this.A = 0;
		this.B = 0;
		this.C = 0;
		this.D = 0;
		this.E = 0;
		this.F = 0;
		this.G = 0;
		this.H = 0;
		this.I = 0;
		this.J = 0;
		this.K = 0;
		this.L = 0;
		
		this.mode = SPLINE_XYZ;
			
	}
	
	function CreateSpline(p0, n0, p1, n1, mode, n0_mag , n1_mag )
	{
		local x0 = 0.0;
		local y0 = 0.0;
		local z0 = 0.0;
		local x1 = 0.0;
		local y1 = 0.0;
		local z1 = 0.0;
		local x2 = 0.0;
		local y2 = 0.0;
		local z2 = 0.0;
		local x3 = 0.0;
		local y3 = 0.0;
		local z3 = 0.0;
		
	
		x0 = p0.x
		y0 = p0.y		
		z0 = p0.z
		
		
		x1 = n0.x * n0_mag + p0.x
		y1 = n0.y * n0_mag + p0.y
		z1 = n0.z * n0_mag + p0.z
		
		x2 = n1.x * n1_mag + p1.x
		y2 = n1.y * n1_mag + p1.y
		z2 = n1.z * n1_mag + p1.z
		
		x3=p1.x
		y3=p1.y
		z3=p1.z
		
		//x coefficients...
		this.A = x3 - (3.0 * x2) + (3.0 * x1) - x0
		this.B = (3.0 * x2) - (6.0 * x1) + (3.0 * x0)
		this.C = (3.0 * x1) - (3.0 * x0)
		this.D = x0
		
		//y coefficients...
		this.E = y3 - (3.0 * y2) + (3.0 * y1) - y0
		this.F = (3.0 * y2) - (6.0 * y1) + (3.0 * y0)
		this.G = (3.0 * y1) - (3.0 * y0)
		this.H = y0
		
		//z coefficients...
		this.I = z3 - (3.0 * z2) + (3.0 * z1) - z0
		this.J = (3.0 * z2) - (6.0 * z1) + (3.0 * z0)
		this.K = (3.0 * z1) - (3.0 * z0)
		this.L = z0
	}
	
	function Interpolate(t)
	{
		local v = Vector(0, 0, 0)
		v.x = ((this.A * (t * t * t)) + (this.B * (t * t)) + (this.C * t) + this.D)
		v.y = ((this.E * (t * t * t)) + (this.F * (t * t)) + (this.G * t) + this.H)
		v.z = ((this.I * (t * t * t)) + (this.J * (t * t)) + (this.K * t) + this.L)
		
		if (this.mode == SPLINE_XY) { v.z = 0 }
		if (this.mode == SPLINE_YZ) { v.x = 0 }
		if (this.mode == SPLINE_XZ) { v.y = 0 }
		
		return v
	}
}