var placeNumber = true

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
	clickValue = 0
}

if(placeNumber)
{
	showNumber = true
}

