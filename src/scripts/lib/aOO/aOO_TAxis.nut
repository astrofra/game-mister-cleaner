
try
{	
	__DEFINE_AXIS__ = 1;	
	
	print("INCLUDE: aOO - TAxis - exist")
}
catch(e)
{
	__DEFINE_AXIS__ <- 1; 
	
	print("INCLUDE: aOO - TAxis") 

	class TAxis
	{
		_item 	= 0;
		
		constructor(item)
		{
			this._item = item
		}
		
		function GetUp()
		{
			return ItemGetMatrix(this._item).GetUp()
		}
		
		function GetRight()
		{
			return ItemGetMatrix(this._item).GetRight()
		}
		
		function GetForward()
		{
			return ItemGetMatrix(this._item).GetFront()
		}
	}
}