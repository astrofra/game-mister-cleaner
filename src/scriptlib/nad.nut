/*
	GameStart SQUIRREL binding API.
	Copyright 2010 Emmanuel Julien.
*/

try
{	__DEFINE_NENGINE_LIBRARY__ = 1;	}
catch(e)
{
	__DEFINE_NENGINE_LIBRARY__ <- 1;

	Include("@core/scriptlib/vector.nut");
	Include("@core/scriptlib/vector2.nut");
	Include("@core/scriptlib/rect.nut");
	Include("@core/scriptlib/matrix.nut");
	Include("@core/scriptlib/math.nut");
	Include("@core/scriptlib/minmax.nut");
	Include("@core/scriptlib/io.nut");
	Include("@core/scriptlib/ui.nut");
	Include("@core/scriptlib/timeout_handler.nut");
	Include("@core/scriptlib/helper.nut");
	Include("@core/scriptlib/project.nut");
	Include("@core/scriptlib/billboard.nut");

	// OO wrapper API.
	Include("@core/scriptlib/oo/oo.nut");
}
