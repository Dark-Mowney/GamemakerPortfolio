var placeNumber = true

switch(obj_controller.state)
{
	case CONTROLLER_STATE.pen:
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
	
		break;
	
	case CONTROLLER_STATE.pencil:
		with(obj_controller)
		{
			if(clickValue <= 0)
			{
				placeNumber = false
			}
		}
		if(placeNumber)
		{
			if(array_length(pencilNumbers) >= 4)
			{
				array_delete(pencilNumbers,0,1)
			}
			array_push(pencilNumbers, string(obj_controller.clickValue))
		}
		break;
	
	case CONTROLLER_STATE.erase:
		pencilNumbers = []	
		break;
}

var win = true

with (obj_box)
{
	if(!showNumber)
	{
		win = false
		break;
	}
}

if(win)
{
	obj_boardManager.win = win
}

