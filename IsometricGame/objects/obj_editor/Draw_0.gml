for(var yy = 0; yy < ds_grid_height(ds_terrain_data); yy++;)
{
	for(var xx = 0; xx < ds_grid_width(ds_terrain_data); xx++;)
	{
		#region DRAW CELL
		
		list = ds_terrain_data[# xx, yy];
		floor_ind = list[| TILE_DATA.floor_index];
		height = list[| TILE_DATA.height]
		spawn_tile = list[| TILE_DATA.spawn_tile]
		unit = list[| TILE_DATA.unit]
		unit_facing = list[| TILE_DATA.unit_facing]
		con_index = list[| TILE_DATA.conversation_index]
		
		draw_x = (xx - yy) * (iso_width / 2);
		
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
					
					if(xx == grid_x && yy == grid_y)
					{
						ed_col = c_yellow
					}
					else
					{
						ed_col = c_white
					}
					
					if(spawn_tile != undefined && spawn_tile > -1)
					{
						draw_sprite_ext(spr_iso_spawn_tiles, spawn_tile, draw_x,draw_y,1,1,0,ed_col,1)
					}
					
					//UNIT
					if(unit != undefined && unit >= CHARACTERS.fighter) //because fighter is the first valid enum
					{
						//DRAW UNIT
						var char_grid = global.char_sprite_grids[| unit]
						spr = char_grid[# ACTOR_SPRITES.idle, unit_facing];
						
						draw_sprite_ext(spr, mouse_index, draw_x, draw_y, 1,1,0,ed_col,1)
						
						//DRAW UNIT NAME
						draw_set_halign(fa_center)
						draw_set_valign(fa_middle)
						
						var name = string_copy(global.character_stats[# STATS.name, unit], 1, 2)
						
						draw_text(draw_x, draw_y - sprite_get_height(spr_iso_actor_idle_e), name)
						
						draw_text(draw_x, draw_y - (sprite_get_height(spr_iso_actor_idle_e) + 14), string(con_index))
					}
					
					#endregion
				}
			}
		}
		
			#region TESTING - show the numbers
			
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_set_colour(c_gray)
			//draw_text(draw_x,draw_y, string(xx) + string(yy))
			
			#endregion
		
		#endregion
		
		#region DRAW CURSOR
		
		if(xx == grid_x && yy == grid_y && actual_grid_x == grid_x && actual_grid_y == grid_y)
		{
			if(editing_state == EDITING_STATES.map)
			{
				#region MAP
				for( var draw_height = 0; draw_height <= current_height; draw_height ++)
				{
					draw_x = (xx - yy) * (iso_width / 2); // -1?
					draw_y = (xx + yy) * (iso_height / 2) - (draw_height * (iso_height / 2) );
					draw_sprite(spr_iso_cursor, 0, draw_x, draw_y);
					
					#region DRAW A BLUEPRINT FOR DECORATION
				
				if(current_part == TILE_DATA.decoration_index)
				{
					var spr = global.cell_sprites[current_part]
					draw_sprite_ext(spr, new_index, draw_x, draw_y, 1, 1, 0, c_yellow, 1);
				}
				
				#endregion
				}
				#endregion
			}
			else
			{
				#region MISSION
				
				if(editing_state == EDITING_STATES.mission)
				{
					if(mouse_sprite != -1)
					{
						draw_y = (xx + yy) * (iso_height / 2) - (height * (iso_height / 2) )
						
						draw_sprite_ext(mouse_sprite, mouse_index, draw_x, draw_y, 1,1,0,c_white,0.5)
					}
				}
				#endregion
			}

		}
		
		#endregion
	}
}

if(actual_grid_x != grid_x || actual_grid_y != grid_y) && (mouse_sprite != -1)
{
	draw_sprite(mouse_sprite, mouse_index, mouse_x, mouse_y)
}