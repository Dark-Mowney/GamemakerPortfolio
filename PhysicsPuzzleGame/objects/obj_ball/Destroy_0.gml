for (var i = 0; i < instance_number(obj_target); i++) 
{
	var target_instance = instance_find(obj_target, i);
	target_instance.sprite_index = spr_target
}

with(obj_gamemanager)
{
	if(ballsleft <= 0)
	{
		SlideTransition(TRANS_MODE.GOTO,room)
	}
	targetsleft = numtargets
	targetpitch = .5
}
