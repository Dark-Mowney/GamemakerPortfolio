if(show_map)
{
	
	#region DRAW BLACK RECTANGLE TO HIDE OTHER STUFF
	
	x1 = 0
	y1 = 0
	x2 = x1 + display_get_width()
	y2 = y1 + display_get_height()
	
	draw_set_colour(c_black)
	draw_rectangle(x1, y1, x2, y2, false)
	draw_set_colour(c_white)
	
	#endregion

	draw_set_font(fnt_editor)
	
	for(var yy = 0; yy < ds_grid_height(ds_terrain_data); yy++)
	{
		for(var xx = 0; xx < ds_grid_width(ds_terrain_data); xx++)
		{
		
			#region DRAW CELL
			
			list = ds_terrain_data[# xx, yy]
			floor_ind = list[| TILE_DATA.floor_index]
			height = list[| TILE_DATA.height]
			spawn_tile = list[| TILE_DATA.spawn_tile]
			unit = list[| TILE_DATA.unit]
			unit_facing = list[| TILE_DATA.unit_facing]
			con_index = list[| TILE_DATA.conversation_index]
			
			draw_x = (xx - yy) * (iso_width / 2)
			
			for(var draw_height = 0; draw_height <= height; draw_height++)
			{
				if(display_all_heights == false && draw_height <= current_height) || (display_all_heights == true)
				{
					draw_y = (xx + yy) * (iso_height / 2) - (draw_height * (iso_height / 2) );
					
					var rgb_value = 150 + (draw_height * 9)
					var col = make_color_rgb(rgb_value, rgb_value, rgb_value);
					draw_sprite_ext(spr_iso_floor, floor_ind, draw_x, draw_y, 1, 1, 0, col, 1)
					
					if(draw_height == height)
					{
						var spr = global.cell_sprites[TILE_DATA.decoration_index]
						var index = list[| TILE_DATA.decoration_index]
						draw_sprite_ext(spr, index, draw_x, draw_y, 1, 1, 0, col, 1);
						
						#region DRAW SPAWN TILE / UNIT
					
						ed_col = c_white
					
						if(unit != undefined && unit >= CHARACTERS.fighter) //because fighter is the first valid enum
						{
							var char_grid = global.character_stats[| unit]
							spr = char_grid[# ACTOR_SPRITES.idle, unit_facing]
							
							draw_sprite_ext(spr, 0, draw_x, draw_y, 1,1,0,ed_col,1)
							
							//DRAW UNIT NAME
							draw_set_halign(fa_center)
							draw_set_valign(fa_middle)
							
							var name = string_copy(global.character_stats[# STATS.name, unit], 1, 2)
							
							draw_text(draw_x, draw_y - sprite_get_height(spr_iso_actor_idle_w), name)
						}
						
						#endregion
					}
				}
			}
			
			#endregion
			
		}
	}
}