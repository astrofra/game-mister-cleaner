
try
{	
	__DEFINE_HUD_SPRITE__ = 1;	
	
	print("INCLUDE: aOO - THUD_Sprite - exist")
}
catch(e)
{
	__DEFINE_HUD_SPRITE__ <- 1; 
	
	print("INCLUDE: aOO - THUD_Sprite") 

	class THUD_Sprite
	{
		ui = 0;
		sprite = 0;
		texture = 0;
		width = 64;
		height = 64;
		
		// --------------------------------------------------------------
		// constructor
		// --------------------------------------------------------------
		constructor()
		{
			this.ui = SceneGetUI(g_scene) 
			
		}
	
		// --------------------------------------------------------------
		// Create sprite
		// --------------------------------------------------------------
		function Create(path)
		{
			this.texture = EngineLoadTexture(g_engine, path);
			local my_pict = TextureGetPicture(this.texture)
			local my_rect = PictureGetRect(my_pict)
			this.width = my_rect.GetWidth() 
			this.height = my_rect.GetHeight()
			this.sprite = UIAddSprite(this.ui,-1,this.texture,0,0,this.width,this.height)		
		}
		
		// --------------------------------------------------------------
		// set width + height
		// --------------------------------------------------------------
		function SetSize(w,h)
		{
			WindowSetSize(this.sprite,w,h)
		}
		
		// --------------------------------------------------------------
		// set scale
		// --------------------------------------------------------------
		function SetScale(sx,sy)
		{
			WindowSetScale(this.sprite,sx,sy)
		}
		
		// --------------------------------------------------------------
		// set pivot
		// --------------------------------------------------------------
		function SetPivot(px,py)
		{
			WindowSetPivot(this.sprite,px,py)		
		}
	
		// --------------------------------------------------------------
		// align pivot to center of sprite
		// --------------------------------------------------------------
		function SetPivotToCenter()
		{
			WindowSetPivot(this.sprite,this.width/2.0,this.height/2.0)		
		}
		
		// --------------------------------------------------------------
		// set position
		// --------------------------------------------------------------
		function SetPosition(x,y)
		{
			WindowSetPosition(this.sprite,x,y)
		}
		
		// --------------------------------------------------------------
		// set angle
		// --------------------------------------------------------------
		function SetAngle(a)
		{
			WindowSetRotation(this.sprite,Deg(a))
		}
		
		// --------------------------------------------------------------
		// set depth = ZOrder
		// --------------------------------------------------------------	
		function SetDepth(d)
		{
		
			WindowSetZOrder(this.sprite,d)	
			
		}
		
		// --------------------------------------------------------------
		// Hide
		// --------------------------------------------------------------	
		function Hide()
		{
			WindowShow(this.sprite,false)	
		}
		
		// --------------------------------------------------------------
		// Show
		// --------------------------------------------------------------	
		function Show()
		{
			WindowShow(this.sprite,true)	
		}
	}
}