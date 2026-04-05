draw_self()

if(state == PLAYER_STATES.idle && path_point != noone)
{
	#region DRAW VALID PATHS
	
	for(var i = 0; i < ds_list_size(path_point.connects_to); i++)
	{
		connecting_path_point = path_point.connects_to[| i]
		connecting_id = path_array[connecting_path_point];
		
		draw_set_color(c_red)
		draw_line(path_point.x, path_point.y, connecting_id.x, connecting_id.y)
	}
	
	#endregion
}

if(state == PLAYER_STATES.world_menu)
{

#region DRAW ACTIONS

start_y = y - 80

for(var i = 0; i < WORLD_ACTIONS.last; i++)
{
	var story_state = global.ds_values[| VALUES_TO_TRACK.story_state]
	var column_to_check = (path_point.path_point) * PATH_POINT_SETUP.last
	var map_type = real( global.story_points[# column_to_check + 1, story_state] )
	
	var text = global.WORLD_ACTION_TEXT[i]
	
	if(map_type == MAP_TYPES.shop && i == WORLD_ACTIONS.shop) || (i != WORLD_ACTIONS.shop)
	{
		draw_set_colour(c_gray)
		
		if(i == highlighted_option)
		{
			draw_set_colour(c_white)
		}
		
	}
	else
	{
		draw_set_colour(c_black)
		
		if(i == highlighted_option)
		{
			draw_set_colour(c_dkgray)
		}
	}
	
	var draw_x = x
	var draw_y = start_y + (i * 14)
	
	draw_set_font(fnt_editor)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text(draw_x, draw_y, text)
	
}

#endregion

}