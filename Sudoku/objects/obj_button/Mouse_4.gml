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
	
	case "Pencil":						//ALL OF THESE SHOULD BE AN ENUM STATE MACHINE
	obj_controller.pencil = true
	obj_controller.pen = false
	obj_controller.erase = false
	break;
	
	case "Pen":
	obj_controller.pen = true
	obj_controller.pencil = false
	obj_controller.erase = false
	break;
	
	case "Erase":
	obj_controller.pen = false
	obj_controller.pencil = false
	obj_controller.erase = true
	break;
}