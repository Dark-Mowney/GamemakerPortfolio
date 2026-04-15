var placeNumber = true

if(obj_controller.pen) //Pretty ugly to do it like this
{
	with(obj_controller)
	{
		if(clickValue <= 0)
		{
			placeNumber = false
		}
		else if(clickValue != other.boxNum)
		{
			placeNumber = false
			numMistakes++
		}
	}
	
	if(placeNumber)
	{
		showNumber = true
		highlightBox()
	}
}
else if(obj_controller.pencil)
{
	with(obj_controller)
	{
		if(clickValue <= 0)
		{
			placeNumber = false
		}
	}
	if(placeNumber)
	{
		array_push(pencilNumbers, string(obj_controller.clickValue))
	}
}
else if(obj_controller.erase)
{
	pencilNumbers = []
}

