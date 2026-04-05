event_inherited();

function unlock()
{
	with obj_gamemanager
	{
		unlockbutton(array_length(unlockedbuttons),other.id,other.button_id)
	}
	
	if disabled
	{
		image_alpha = 0.5
	}
}

with(obj_gamemanager)
{
	array_push(buttonarray,other)
}

unlock()