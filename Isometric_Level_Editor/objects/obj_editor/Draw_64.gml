#region DRAW EDITOR GUI

draw_set_halign(fa_left)
draw_set_valign(fa_top)

//grid x/y
draw_text(0, 0, "grid_x: " + string(grid_x) );
draw_text(0, 20, "grid_y: " + string(grid_y) );

//key bindings
draw_text(display_get_gui_width() - 275, 0, "right/left arrow - change part")
draw_text(display_get_gui_width() - 346, 20, "right/left arrow + shift - change part set")
draw_text(display_get_gui_width() - 165, 40, "WASD - move camera")
draw_text(display_get_gui_width() - 255, 60, "tab - toggle display heights")
draw_text(display_get_gui_width() - 120, 80, "F5 - save map")
draw_text(display_get_gui_width() - 200, 100, "Q/E + shift - load map")
draw_text(display_get_gui_width() - 200, 120, "enter - create new map")
draw_text(display_get_gui_width() - 275, 140, "backspace - delete current map")
draw_text(display_get_gui_width() - 280, 160, "spacebar - change editing state")
draw_text(display_get_gui_width() - 180, 180, "escape - end session")

#region TESTING - CONVERSATION INDEX

draw_set_halign(fa_center)
draw_set_valign(fa_middle)


draw_text(display_get_gui_width()/2, 10, "unique_conversation_index: " + string(unique_conversation_index) )
draw_text(display_get_gui_width()/2, 30, "map index: " + string(current_map_number) )
draw_text(display_get_gui_width()/2, 50, " mouse_index: " + string(mouse_index) )

#endregion

#endregion

#region DRAW MAP EDITOR GUI

if(editing_state == EDITING_STATES.map)
{
	//Draw current_part sprite
	var draw_x = display_get_gui_width() / 2;
	var draw_y = display_get_gui_height() - 32;
	var scale = 2
	

	var spr = global.cell_sprites[current_part];
	draw_sprite_ext(spr, new_index, draw_x, draw_y, scale, scale, 0, c_white, 1)
	
	//draw key bindings
	draw_text(display_get_gui_width() - 85, 210, "mb_left - paint map")
	draw_text(display_get_gui_width() - 140, 230, "up/down arrow - change height")	
	draw_text(display_get_gui_width() - 140, 250, "WASD + shift - change map size")
	
	
	
}


#endregion

#region DRAW MISSION EDITOR GUI

if(editing_state == EDITING_STATES.mission)
{
	draw_scale = 2
	
	#region DRAW KEY BINDINGS
	
	draw_text(display_get_gui_width() - 90, 210, "mb_left - place unit")
	draw_text(display_get_gui_width() - 100, 230, "mb_right - delete unit")
	draw_text(display_get_gui_width() - 100, 250, "mouse wheel - change unit")
	draw_text(display_get_gui_width() - 100, 270, "1 - toggle ai controlled")
	draw_text(display_get_gui_width() - 100, 290, "2 - toggle must survive")
	draw_text(display_get_gui_width() - 100, 310, "3 - toggle kill to win")
	
	#endregion
	
	#region DRAW SPAWN POINT ICONS
	
	var spr_w = sprite_get_width(spr_iso_spawn_tiles) * draw_scale
	var spr_h = sprite_get_height(spr_iso_spawn_tiles) * draw_scale
	var start_x = spr_w
	var start_y = display_get_gui_height() - spr_h
	
	for(var team = 0; team < sprite_get_number(spr_iso_spawn_tiles); team++)
	{
		var draw_x = start_x + (team * spr_w)
		var draw_y = start_y
		var mx = device_mouse_x_to_gui(0)
		var my = device_mouse_y_to_gui(0)
		
		if(abs(mx - draw_x) <= ( spr_w / 2) && abs(my - draw_y) <= (spr_h / 2) )
		{
			var col = c_ltgray
			if(mouse_check_button_pressed(mb_left))
			{
				mouse_sprite = spr_iso_spawn_tiles
				mouse_index = team
			}
		}
		else
		{
			col = c_white
		}
		
		draw_sprite_ext(spr_iso_spawn_tiles, team, draw_x,draw_y,draw_scale,draw_scale,0,col,1);
	}
	
	#endregion
	
	#region DRAW CHARACTER
	
	spr_w = sprite_get_width(spr_iso_actor_idle_w) * draw_scale
	spr_h = sprite_get_height(spr_iso_actor_idle_w) * draw_scale
	
	var draw_x = sprite_get_width(spr_iso_spawn_tiles) * 6
	var draw_y = display_get_gui_height() - sprite_get_height(spr_iso_actor_idle_w)
	
	var mx = device_mouse_x_to_gui(0)
	var my = device_mouse_y_to_gui(0)
	
	if(abs(mx - draw_x) <= (spr_w / 2) && abs(my - draw_y) <= (spr_h / 2) )
	{
		var col = c_ltgray
		
		if(mouse_check_button_pressed(mb_left))
		{
			mouse_sprite = spr_iso_actor_idle_s
			mouse_index = FACING.south
		}
		
	}
	else
	{
		var col = c_white
	}
	
	draw_sprite_ext(spr_iso_actor_idle_s, 0,draw_x,draw_y,draw_scale,draw_scale,0,col,1)
	
	#endregion
	
	#region DRAW AI CONTROLLED / MUST SURVIVE / KILL TO WIN
	
	var list = ds_terrain_data[# grid_x, grid_y]
	
	if(list != undefined && list[| TILE_DATA.unit] >= CHARACTERS.fighter && list[| TILE_DATA.unit] != undefined)
	{
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_text(0,60,"AI Controlled: " + string(list[| TILE_DATA.is_ai_controlled]))
		draw_text(0,80,"Must Survive: " + string(list[| TILE_DATA.must_survive_this_battle]))
		draw_text(0,100,"Kill to win: " + string(list[| TILE_DATA.kill_this_unit_to_win]))
	}
	
	#endregion
	

}

#endregion