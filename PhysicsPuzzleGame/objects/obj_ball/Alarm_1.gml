/// @description Destroy
var psys = part_system_create(ps_BallDestroyed)
part_system_position(psys,x,y)
part_system_colour(psys,obj_gamemanager.roomcolor,1)
instance_destroy()