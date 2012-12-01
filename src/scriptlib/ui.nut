/*
	nEngine	SQUIRREL binding API.
	Copyright 2005~2008 Emmanuel Julien.
*/


//-----------------------------------
function    WindowCenterPivot(window)
{
	local   size = WindowGetSize(window)
	WindowSetPivot(window, size.x * 0.5, size.y * 0.5)
}

//------------------------------------------------------
function	CameraWorldToScene2d(camera, world, scene2d)
{
	local	screen = CameraWorldToScreen(camera, world),
			res2d = UIGetInternalResolution(scene2d)
	return Vector(screen.x * res2d.x, screen.y * res2d.y)
}
