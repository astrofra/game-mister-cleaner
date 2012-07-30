
// http://www.emil.input.sk//index.html

print("INCLUDE: RLC - commands")

g_robot 			<- 0;
g_move_duration		<- 0.25;
g_angle_y			<- 0;
g_program			<- 0;

	// ------------------------------------------------------------------------------------
	// initialize cmds for g_robot item
	// ------------------------------------------------------------------------------------
	
	function InitializeCommands()
	{
		debug("COMMAND: InitializeCommands()")
		g_robot = SceneFindItem(g_scene, "Player");
		debug("NAME:"+ItemGetName(g_robot))	
	}
	
	// ------------------------------------------------------------------------------------
	// Set move direction from transformation matrix
	// ------------------------------------------------------------------------------------

	function SetMoveDirection()
	{
					
		local item_forward = ItemGetMatrix(g_robot).GetFront();
		local dir = (item_forward.x+","+item_forward.y+","+item_forward.z);		
		return dir;
	}




	// ------------------------------------------------------------------------------------
	// turn g_robot RIGHT
	// ------------------------------------------------------------------------------------

	function TurnRight()
	{
		debug("COMMAND: TurnRight()")
		g_angle_y = g_angle_y + 90;
		ItemSetCommandList(g_robot, "torotation "+g_move_duration+",0,"+g_angle_y+",0;")
		suspend("g_script");
	}

	// ------------------------------------------------------------------------------------
	// turn g_robot LEFT
	// ------------------------------------------------------------------------------------

	function TurnLeft()
	{
		debug("COMMAND: TurnLeft()")
		g_angle_y = g_angle_y - 90;
		ItemSetCommandList(g_robot, "torotation "+g_move_duration+",0,"+g_angle_y+",0;")
		suspend("g_script");
	}
	
	// ------------------------------------------------------------------------------------
	// turn g_robot LEFT
	// ------------------------------------------------------------------------------------

	function Move()
	{
		debug("COMMAND: Move()")
		local cmd = SetMoveDirection();
		ItemSetCommandList(g_robot, "offsetposition 0.5,"+cmd+";")
		suspend("g_script");
	}
	
	
	// ------------------------------------------------------------------------------------
	// is wall behid me?
	// ------------------------------------------------------------------------------------
	function IsWall()
	{
		debug("COMMAND: IsWall()")
		
		local res = false;
		
		local item_pos = ItemGetPosition(g_robot)
		local item_matrix = ItemGetMatrix(g_robot);
		local v_forward = item_matrix.GetRow(2);
		local item_dir = clone(v_forward)
		local res = false

		local contact = SceneCollisionRaytrace(g_scene, item_pos+Vector(0,0.5,0),item_dir, -1, CollisionTraceAll, Mtr(1)); 
		
		if ((contact.hit)  && (ItemGetName(contact.item)=="wall"))		
		{
			debug("COMMAND: IsWall() = true ; name="+ItemGetName(contact.item))
			res = true; 
		}		
		return res	
	}
	

	// ------------------------------------------------------------------------------------
	// is wall behid me?
	// ------------------------------------------------------------------------------------
	function IsBrick()
	{
		debug("COMMAND: IsBrick()")
		
		local res = false;
		
		local item_pos = ItemGetPosition(g_robot)
		local item_matrix = ItemGetMatrix(g_robot);
		local v_forward = item_matrix.GetRow(2);
		local item_dir = clone(v_forward)

		local contact = SceneCollisionRaytrace(g_scene, item_pos+Vector(0,0.5,0),item_dir, -1, CollisionTraceAll, Mtr(1)); 
		

		if ((contact.hit)  && (ItemGetName(contact.item)=="brick"))
		//if (contact.hit)
		{
			debug("COMMAND: IsBrick() = true ; name="+ItemGetName(contact.item))
			res = true; 
		}		
		
		return res	
	}
	
	// ------------------------------------------------------------------------------------
	// turn g_robot LEFT
	// ------------------------------------------------------------------------------------
	function Reset()
	{
		debug("COMMAND: Reset()")
		ItemSetPosition(g_robot,Vector(0,0,0))
		ItemSetRotation(g_robot,Vector(0,0,0))
		ItemResetCommandList(g_robot)
		local items = SceneGetItemList(g_scene)
		
		for(local i=0; i<items.len();i++)
		{
			if (ItemGetName(items[i])=="brick") SceneDeleteItem(g_scene,items[i])
		}
	}
	
	// ------------------------------------------------------------------------------------
	// put brick behind robot
	// ------------------------------------------------------------------------------------
	function Put(...)
	{
		
		if (vargv.len()==0)
		{
			
			if (!IsBrick())
			{
				debug("COMMAND: Put()")
				
				local my_object = SceneAddObject(g_scene, "brick")
				local my_geo = EngineLoadGeometry(g_engine, "geometry/wall/rlc_wall.nmg")
				local item = ObjectGetItem(my_object)
				ObjectSetGeometry(my_object, my_geo)
				
				
				local robot_forward = ItemGetMatrix(g_robot).GetFront();
				local robot_pos = ItemGetPosition(g_robot)
				local item_pos = robot_pos + robot_forward
				item_pos = item_pos + Vector(0,-1,0)
				
				ItemSetPosition(item,item_pos)
				CreateBoxCollisionShape(item)			
				
				ItemSetup(item)
				
				ItemSetCommandList(item, "offsetposition "+g_move_duration+",0,1,0;")
			}
			else
			{
				debug("COMMAND: Put() = WARNING - exist on same place !!")
			}
			
		}
		
		if (vargv.len()==3)
		{
			if (!IsBrick())
			{
				
				debug("COMMAND: Put()")
				
				local my_object = SceneAddObject(g_scene, "brick")
				local my_geo = EngineLoadGeometry(g_engine, "geometry/wall/rlc_wall.nmg")
				local item = ObjectGetItem(my_object)
				ObjectSetGeometry(my_object, my_geo)
				CreateBoxCollisionShape(item)			
				
				
				ItemSetup(item)
				ItemSetPosition(item,Vector(vargv[0].tofloat(),vargv[1].tofloat(),vargv[2].tofloat()))
				
			}
			else
			{
				debug("COMMAND: Put() = WARNING - exist on same place !!")
			}
			
		}
		
	}
	
	// ------------------------------------------------------------------------------------
	// Take brick behind robot
	// ------------------------------------------------------------------------------------
	function Take()
	{
		if (IsBrick())
		{
			debug("COMMAND: Take()")
			
			local item_pos = ItemGetPosition(g_robot)
			local item_matrix = ItemGetMatrix(g_robot);
			local v_forward = item_matrix.GetRow(2);
			local item_dir = clone(v_forward)
			
			local contact = SceneCollisionRaytrace(g_scene, item_pos+Vector(0,0.5,0),item_dir, -1, CollisionTraceAll, Mtr(1)); 
			
			if ((contact.hit)  && (ItemGetName(contact.item)=="brick"))			
			{				
				SceneDeleteItem(g_scene,contact.item)
			}			
		}
		
		
	}
	
	function IsNorth()
	{
		
	}
	
	