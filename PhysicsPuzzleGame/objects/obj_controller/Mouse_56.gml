with(instance_create_layer(x,y,"Instances",obj_ball))
{	
	var _direction = point_direction(x,y,mouse_x,mouse_y)
	
	var xforce, yforce
	xforce = lengthdir_x(100,_direction) * clamp(other.force,0,other.maxforce)
	yforce = lengthdir_y(100,_direction) * clamp(other.force,0,other.maxforce)
	
	physics_apply_impulse(x,y,xforce,yforce)
}

with(obj_gamemanager)
{
	if(ballsleft <= 0)
	{
		SlideTransition(TRANS_MODE.GOTO,room)
	}
	ballsleft--
}
