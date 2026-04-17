clickValue = 0
numMistakes = 0

//MAKE THIS INTO A STATE MACHINE
enum CONTROLLER_STATE
{
	pen,
	pencil,
	erase
}

state = CONTROLLER_STATE.pen

// DELETE AFTER IMPLEMENTING STATE MACHINE
pen = true
pencil = false
erase = false