for (var i = 0; i < instance_number(obj_target); i++) 
{
	var target_instance = instance_find(obj_target, i);
	with(target_instance)
	{
		draw_set_valign(fa_middle)
		draw_set_halign(fa_center)
		draw_set_colour(c_ltgray + other.roomcolor)
		draw_text(x,y,other.targetsleft)
	}
}

if(room != MainMenu)
{
	for(var i = 0; i < ballsleft; i++)
	{
		draw_sprite_ext(spr_ball,-1,16 +(i * 32), 16,1,1,0,backgroundcolor,1)
	}
	
	draw_text(480,50, timeelapsed)
}