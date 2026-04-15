switch(buttonText)
{
	case "easy":
	obj_boardManager.difficulty = "easy"
	room_goto_next()
	break;
	
	case "medium":
	obj_boardManager.difficulty = "medium"
	room_goto_next()
	break;
	
	case "hard":
	obj_boardManager.difficulty = "hard"
	room_goto_next()
	break;
}