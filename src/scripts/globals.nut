/*
	File: e:/_3D_Engines/GameStart/Projects/AGFX_Game_ShiftBomber/Scripts/player.nut
	Author: AndyGFX
*/

g_player_speed_multiplier		<-	2.0	

function	PSpeedMul(val)
{	return (((val.tofloat()) / g_player_speed_multiplier).tostring()) }