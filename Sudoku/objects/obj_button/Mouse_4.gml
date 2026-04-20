switch(buttonText)
{
	case "Easy":
	obj_gameManager.difficulty = "Easy"
	room_goto_next()
	break;
	
	case "Medium":
	obj_gameManager.difficulty = "Medium"
	room_goto_next()
	break;
	
	case "Hard":
	obj_gameManager.difficulty = "Hard"
	room_goto_next()
	break;
	
	case "Pencil":
	obj_controller.state = CONTROLLER_STATE.pencil
	break;
	
	case "Pen":
	obj_controller.state = CONTROLLER_STATE.pen
	break;
	
	case "Erase":
	obj_controller.state = CONTROLLER_STATE.erase
	break;
	
	case "Debug":
	with(obj_box)
	{
		debug = true
	}
	break;
	
	case "Load Game":
	with(obj_gameManager)
	{
		loadedGame = true
	}
}

with(obj_button)
{
	sprite_index = spr_button_unpressed
}

sprite_index = spr_button_pressed