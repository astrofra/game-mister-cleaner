function GetHitItem(pos,dir,length,flag)
{
	return SceneCollisionRaytrace(g_scene, pos,dir, -1, flag, Mtr(length)); 
}
