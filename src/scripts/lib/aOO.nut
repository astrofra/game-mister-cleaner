

try
{	
	__DEFINE_AGFX_OO__ = 1;	
	print("INCLUDE: aOO library - exist")
}
catch(e)
{ 
	__DEFINE_AGFX_OO__ <- 1;	
	print("INCLUDE: aOO library")
	
	Include("scripts/lib/aOO/aOO_Constants.nut")
	Include("scripts/lib/aOO/aOO_Globals.nut")
	Include("scripts/lib/aOO/aOO_Helpers.nut")
	Include("scripts/lib/aOO/aOO_TAxis.nut")
	Include("scripts/lib/aOO/aOO_TEntity.nut")
	Include("scripts/lib/aOO/aOO_TKeyboard.nut")
	Include("scripts/lib/aOO/aOO_TGUI_Window.nut")
	Include("scripts/lib/aOO/aOO_THUD_Sprite.nut")
	Include("scripts/lib/aOO/aOO_THUD_Text.nut")
	Include("scripts/lib/aOO/aOO_TMetadata.nut")
	Include("scripts/lib/aOO/aOO_TSpline.nut")
	Include("scripts/lib/aOO/aOO_TDirectoryList.nut")
	Include("scripts/lib/aOO/aOO_TGUI_Filelistbox.nut")
	Include("scripts/lib/aOO/aOO_TGUI_GamemenuItem.nut")
	Include("scripts/lib/aOO/aOO_TGUI_Gamemenu.nut")
	Include("scripts/lib/aOO/aOO_TScript.nut")
	
	
	
	
	
	
	debug("AndyGFX Object Oriented library loaded")
}