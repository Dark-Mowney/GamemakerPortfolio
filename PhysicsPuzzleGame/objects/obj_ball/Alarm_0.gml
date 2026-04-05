
for(var i = 0; i < instance_number(obj_ball_fortrajectoryline); i++)
{
	var instance = instance_find(obj_ball_fortrajectoryline, i)
	
	instance_destroy(instance)
	i--
}
