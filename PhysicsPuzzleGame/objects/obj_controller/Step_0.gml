if(instance_exists(obj_dialogue)) exit;

image_angle = point_direction(x,y,mouse_x,mouse_y)

if(timer > 0)
{
	timer -= delta_time
}
else
{
	if(instance_number(obj_ball_fortrajectoryline) < 20)
	{
		with(instance_create_layer(x,y,"Instances",obj_ball_fortrajectoryline))
		{	
			var _direction = point_direction(x,y,mouse_x,mouse_y)
			
			var xforce, yforce
			xforce = lengthdir_x(100,_direction) * clamp(other.force,0,other.maxforce)
			yforce = lengthdir_y(100,_direction) * clamp(other.force,0,other.maxforce)
			
			physics_apply_impulse(x,y,xforce,yforce)
			
			phy_speed_x *= 10000
			phy_speed_y *= 10000
			image_alpha = 0
		}
		
		timer = 50000
	}
}