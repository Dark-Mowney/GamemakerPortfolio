flash = true
var psys = part_system_create(ps_BallBounced)
part_system_position(psys,other.x,other.y)
part_system_angle(psys,bouncedirection)
part_system_colour(psys,obj_gamemanager.roomcolor,1)
alarm[0] = 4

var _direction = point_direction(x,y,other.x,other.y)

var xforce, yforce

xforce = lengthdir_x(100,bouncedirection) * 20000
yforce = lengthdir_y(100,bouncedirection) * 20000

with(other)
{
	physics_apply_impulse(x,y,xforce,yforce)
}