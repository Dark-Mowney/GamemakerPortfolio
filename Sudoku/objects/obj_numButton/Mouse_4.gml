with(obj_controller)
{
	clickValue = other.buttonValue
}

with(obj_box)
{
	unhighlightBox()
	
	if(boxNum == other.buttonValue && showNumber)
	{
		highlightBox()
	}
}