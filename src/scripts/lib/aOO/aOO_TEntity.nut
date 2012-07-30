

try
{	
	__DEFINE_TENTITY__ = 1;	
	print("INCLUDE: aOO - TEntity - exist")
}
catch(e)
{
	__DEFINE_TENTITY__ <- 1; 
	
	print("INCLUDE: aOO - TEntity")
	
	class TEntity
	{
		
	
		classname=0;
		classtype=0;
		classtypename=0;		
		axis = 0;		
		_item = 0;

		// --------------------------------------------------------------------		
		// TEntity CONSTRUCTOR
		// --------------------------------------------------------------------		
		constructor()
		{	
			this.classname="ITEM"
			this.classtype=CLASSTYPE_NONE
			this.classtypename="CLASSTYPE_NONE";
		
			this.axis = 0;		
			this._item = 0;
		}

		// --------------------------------------------------------------------		
		// OnSetup
		// --------------------------------------------------------------------				
		function OnSetup(item)
		{			
			this._item = item;	
			this.axis = TAxis(item);
			
			// set class type flag
			if (ItemGetFlags(this._item)==ItemTypeNone) 	{ this.classtype = CLASSTYPE_NONE ;}
			if (ItemGetFlags(this._item)==ItemTypeCamera) 	{ this.classtype = CLASSTYPE_CAMERA ;}
			if (ItemGetFlags(this._item)==ItemTypeObject) 	{ this.classtype = CLASSTYPE_OBJECT ;}
			if (ItemGetFlags(this._item)==ItemTypeLight) 	{ this.classtype = CLASSTYPE_LIGHT ;}
			if (ItemGetFlags(this._item)==ItemTypeTrigger) 	{ this.classtype = CLASSTYPE_TRIGGER ;}
			if (ItemGetFlags(this._item)==ItemTypeEmitter) 	{ this.classtype = CLASSTYPE_EMITTER ;}
			if (ItemGetFlags(this._item)==ItemTypeInstance) { this.classtype = CLASSTYPE_INSTANCE ;}
			
			// set class type flag name
			if (ItemGetFlags(this._item)==ItemTypeNone) 	{ this.classtypename = "CLASSTYPE_NONE" ;}
			if (ItemGetFlags(this._item)==ItemTypeCamera) 	{ this.classtypename = "CLASSTYPE_CAMERA" ;}
			if (ItemGetFlags(this._item)==ItemTypeObject) 	{ this.classtypename = "CLASSTYPE_OBJECT" ;}
			if (ItemGetFlags(this._item)==ItemTypeLight) 	{ this.classtypename = "CLASSTYPE_LIGHT" ;}
			if (ItemGetFlags(this._item)==ItemTypeTrigger) 	{ this.classtypename = "CLASSTYPE_TRIGGER" ;}
			if (ItemGetFlags(this._item)==ItemTypeEmitter) 	{ this.classtypename = "CLASSTYPE_EMITTER" ;}
			if (ItemGetFlags(this._item)==ItemTypeInstance) { this.classtypename = "CLASSTYPE_INSTANCE" ;}
			
			
		}

		// --------------------------------------------------------------------		
		// Getter
		// --------------------------------------------------------------------		
		function _get(_Index)
		{
			
			switch(_Index)
		    {
		      case "position":
		        return ItemGetPosition(this._item);
		        
		      case "rotation":
		        return ItemGetRotation(this._item);	
		        
		      case "scale":
		      	return ItemGetScale(this._item);	
		      			      	
		      case "valid":
		      	return ItemIsValid(this._item);
		      	
		      case "enable":
		      	return ItemIsActive(this._item);
		      	
		      case "name":		      	
		        return ItemGetName(this._item);

		        
		      default:
		        throw null;
		    }	
			
		}
		

		// --------------------------------------------------------------------		
		// Setter
		// --------------------------------------------------------------------		
		function _set(...)
		{
			
			debug("key = "+vargv[0]+"\n");
			debug("val = "+vargv[1]+"\n")
			debug("c   = "+vargv.len()+"\n")
			
			
			switch(vargv[0])
		    {
		      case "position":
		     	ItemSetPosition(this._item,vargv[1]);
		     	
		      case "rotation":
		        ItemSetRotation(this._item,vargv[1]);	
		        
		      case "scale":
		      	ItemSetScale(this._item,vargv[1]);	
		      	
		      case "enable":
		      	{
			      	if (vargv[1].tointeger()==1)
			      	{
			      		ItemActivate(this._item, true);
			      	}
			      	if (vargv[1].tointeger()==0)
			      	{
			      		ItemActivate(this._item, false);
			      	}
			     }
		      	
		      case "name":		      	
		        ItemSetName(this._item,vargv[1].tostring());
			
		       default:
		  
		    }
			
		}

		// --------------------------------------------------------------------		
		// get item name
		// --------------------------------------------------------------------		
		function GetName()
		{
			return ItemGetName(this._item)
			
		}
		
		// --------------------------------------------------------------------		
		// set item name
		// --------------------------------------------------------------------		
		function SetName(n)
		{
			ItemSetName(this._item,n)
		}
		
		// --------------------------------------------------------------------		
		// get item name
		// --------------------------------------------------------------------		
		function GetClassname()
		{
			return this.classname
			
		}
		
		// --------------------------------------------------------------------		
		// set item name
		// --------------------------------------------------------------------		
		function SetClassname(n)
		{
			this.classname= n
		}
		
		// --------------------------------------------------------------------		
		// get item info
		// --------------------------------------------------------------------		
		function _tostring()
		{
			return ("Item name: "+this.GetName()+" [ Classname: " +this.classname+" Class type name: "+this.classtypename + "  Class type ID: "+this.classtype+"]")
		}
		
		
		// --------------------------------------------------------------------		
		// Set position
		// --------------------------------------------------------------------		
		function SetPosition(...)
		{
			if (vargv.len()==3)	
			{
				ItemSetPosition(this._item,Vector(vargv[0],vargv[1],vargv[2]))	;
			}
			
			if (vargv.len()==1)	
			{
				ItemSetPosition(this._item,vargv[0]);
			}
			
		}

		// --------------------------------------------------------------------		
		// Get position
		// --------------------------------------------------------------------		
		function GetPosition(world = false)
		{
			local pos;
			if (world)
			{
				pos = ItemGetWorldPosition(this._item);
			}
			else
			{
				pos = ItemGetPosition(this._item);
			}
			
			return pos;
		}	
		
		// --------------------------------------------------------------------		
		// Set Target
		// --------------------------------------------------------------------		
		function SetTarget(targ)
		{	
			ItemSetTarget(this._item, targ);	
		}	
		
		// --------------------------------------------------------------------		
		// LookAt = Set Target
		// --------------------------------------------------------------------		
		function LookAt(targ)
		{	
			ItemSetTarget(this._item, targ);	
		}
		
		// --------------------------------------------------------------------		
		// Get rotation
		// --------------------------------------------------------------------		
		function GetRotation()
		{	
			return ItemGetRotation(this._item);	
		}
	
		// --------------------------------------------------------------------		
		// Set roattion
		// --------------------------------------------------------------------		
		function SetRotation(r)
		{	
			ItemSetRotation(this._item, r);	
		}
	
		// --------------------------------------------------------------------		
		// Get scale
		// --------------------------------------------------------------------		
		function GetScale()
		{	
			return ItemGetScale(this._item);	
		}
		
		// --------------------------------------------------------------------		
		// Set scale
		// --------------------------------------------------------------------		
		function SetScale(s)
		{	
			ItemSetScale(this._item, s);

		}
		
		// --------------------------------------------------------------------		
		// Get Script Instance
		// --------------------------------------------------------------------		
		function GetScriptInstance()
		{
			return ItemGetScriptInstance(this._item);	
		}
		
		// --------------------------------------------------------------------		
		// is command list done
		// --------------------------------------------------------------------		
		function IsCommandListDone()
		{
			return ItemIsCommandListDone(this._item);
		}
		
		// --------------------------------------------------------------------		
		// Set command list 
		// --------------------------------------------------------------------		
		function SetCommandList(cmd)
		{
			ItemSetCommandList(this._item,cmd);
		}
		
		// --------------------------------------------------------------------		
		// ReSet command list 
		// --------------------------------------------------------------------		
		function ResetCommandList()
		{
			ItemResetCommandList(this._item);
		}
		
		// --------------------------------------------------------------------		
		// Activate
		// --------------------------------------------------------------------		
		function Activate(act = true)
		{
			ItemActivate(this._item, act);
		}
		
		
		// --------------------------------------------------------------------		
		// Is Active ?
		// --------------------------------------------------------------------		
		function IsActive()
		{
			return ItemIsActive(this._item);
		}
		
		// --------------------------------------------------------------------		
		// Is Valid ?
		// --------------------------------------------------------------------		
		function IsValid()
		{
			return ItemIsValid(this._item);
		}
		
		
		// --------------------------------------------------------------------		
		// Set item registry key value.
		// --------------------------------------------------------------------		
		function SetRegistryKey(name,value)
		{
			ItemRegistrySetKey(this._item,name,value);
		}
		
		// --------------------------------------------------------------------		
		// Get item registry key value.
		// --------------------------------------------------------------------		
		function GetRegistryKey(name,value)
		{
			return ItemRegistryGetKey(this._item,name,value);
		}
		
	}
		
}