


class TIO_metadata
{
	md = 0;
	child_root = 0;
	constructor()
	{
		this.md = MetafileNew();

	}

	function Create(project_name)
	{
		this.Clean()
		local tag = MetafileAddRootWithValue(this.md,"Project_codename",project_name)

	}

	function Clean()
	{
		this.md = MetafileNew();
	}


	function SetValue(name,value)
	{
		local tag = MetafileGetTag(this.md,name)
		MetatagSetValue(tag,value)
	}
	
	function AddValue(name,value)
	{

		local tag = MetafileAddRootWithValue(this.md,name,value)
	}


	function GetValue(name)
	{
		local tag = MetafileGetTag(this.md,name)
		return MetatagGetValue(tag)


	}
	function Save(fname)
	{
		MetafileSave(this.md,fname)

	}	


	function Load(fname)
	{

		return MetafileLoad(this.md,fname)
		
	}
	
	function CreateRoot(root_name)
	{
		
		this.child_root = MetafileAddRoot(this.md, root_name)
		
	}
	
	function CreateChild(child_name)
	{
				
		return MetatagAddChild(this.child_root, child_name)	
		
	}
	
	
	function AddChildValue(child_tag,var_name,value)
	{
		
		local child1 = MetatagAddChildWithValue(child_tag,var_name, value)
		
	}
	
	function SetChildValue(root_name,child_name,var_name,value)
	{
		
		local tag = MetafileGetTag(this.md, root_name+":"+child_name+":"+var_name)
		MetatagSetValue(tag,value)
		
	}

}