#region DETERMINE GRID_X/Y

grid_x = floor(( mouse_x / iso_width) + (mouse_y / iso_height));
grid_y = floor(( mouse_y / iso_height) - (mouse_x / iso_width));

actual_grid_x = grid_x
actual_grid_y = grid_y

//Cap grid_x/y
grid_x = clamp(grid_x ,0 ,ds_grid_width(ds_terrain_data) - 1);
grid_y = clamp(grid_y ,0 ,ds_grid_height(ds_terrain_data) - 1);

#endregion

#region CHANGE NEW_INDEX

if(editing_state == EDITING_STATES.map)
{

	if (keyboard_check_pressed(vk_right) )
	{
		if(keyboard_check(vk_shift) == false)
		{
			if(new_index + 1) < sprite_get_number(current_sprite)
			{
				new_index++;
			}
			else
			{
				new_index = 0
			}
		}
		else
		{
			#region CHANGE TILE PART
			
			if(current_part + 1) <= TILE_DATA.decoration_index current_part++;
			else current_part = 0;
			current_sprite = global.cell_sprites[current_part]
			new_index = 1;
			
			#endregion
		}
	}
	
	if (keyboard_check_pressed(vk_left) )
	{
		if(keyboard_check(vk_shift) == false)
		{
			if(new_index > 0) new_index--;
			else new_index = (sprite_get_number(current_sprite) - 1)
		}
		else
		{
			#region CHANGE TILE PART
			
			if(current_part + 1) <= TILE_DATA.decoration_index current_part++;
			else current_part = 0;
			current_sprite = global.cell_sprites[current_part]
			new_index = 1;
			
			#endregion
		}
	}
}

#endregion

#region PAINT THE MAP/PLACE UNIT/SPAWN TILE

if(mouse_check_button(mb_left))
{
	var list = ds_terrain_data [# grid_x, grid_y]
	
	if(editing_state == EDITING_STATES.map)
	{
		list[| current_part] = new_index
		list[| TILE_DATA.height] = current_height
	}
	
	if(editing_state == EDITING_STATES.mission && mouse_check_button_pressed(mb_left))
	{
		if(actual_grid_x == grid_x && actual_grid_y == grid_y)
		{
			if(mouse_sprite == spr_iso_spawn_tiles)
			{
				list [| TILE_DATA.spawn_tile] = mouse_index;
				
				if(list[| TILE_DATA.conversation_index] == -1 || list[| TILE_DATA.conversation_index] == undefined)
				{
					list[| TILE_DATA.conversation_index] = unique_conversation_index
					
					unique_conversation_index++
				}
				
			}
			else
			{
				if(mouse_sprite == spr_iso_actor_idle_s && list[| TILE_DATA.spawn_tile] != undefined && list[| TILE_DATA.spawn_tile] > -1)
				{
					//update unit entry
					list[|TILE_DATA.unit] = CHARACTERS.fighter
					list[|TILE_DATA.unit_facing] = mouse_index
					
					//update ai controlled
					if(list[| TILE_DATA.spawn_tile] == 0) 
					{
						list[| TILE_DATA.is_ai_controlled] = false
					}
					else 
					{
						list[| TILE_DATA.is_ai_controlled] = true;
					}
					
					//update must_survive
					list[| TILE_DATA.must_survive_this_battle] = false
					
					//update must_kill
					list[| TILE_DATA.kill_this_unit_to_win] = false
				}
			}
		}
	}
}

#endregion

#region DELETE SPAWN POINTS / UNITS

if(mouse_check_button_pressed(mb_right))
{
	if(editing_state == EDITING_STATES.mission)
	{
		mouse_sprite = -1
		mouse_index = -1
		
		if(actual_grid_x == grid_x && actual_grid_y == grid_y)
		{
			var list = ds_terrain_data[# grid_x, grid_y]
			
			if(list[| TILE_DATA.unit] != undefined && list[| TILE_DATA.unit] >= 0)
			{
				list[| TILE_DATA.unit] = -1
			}
			else
			{
				list[| TILE_DATA.spawn_tile] = -1
			}
		}
	}
}

#endregion

#region ROTATE THE UNIT / CHANGE THE CLASS

if(editing_state == EDITING_STATES.mission)
{
	var list = ds_terrain_data[# grid_x, grid_y]
	var class = list[| TILE_DATA.unit]
	
	if(mouse_wheel_down())
	{
		if(mouse_sprite == spr_iso_actor_idle_s)
		{
			if((mouse_index + 1) < 4) //4 because now each sprite is standalone. this number will need to be changed when we add more sprites
			{
				mouse_index++
			}
			else
			{
				mouse_index = 0
			}
		}
		if(mouse_sprite == -1 && class != undefined && class >= CHARACTERS.fighter) // because fighter is first
		{
			if((class + 1) < CHARACTERS.last)
			{
				list[| TILE_DATA.unit]++
			}
			else
			{
				list[| TILE_DATA.unit] = CHARACTERS.fighter
			}
		}
	}
	if(mouse_wheel_up())
	{
		if(mouse_sprite == spr_iso_actor_idle_s)
		{
			if(mouse_index > 0)
			{
				mouse_index--
			}
			else
			{
				mouse_index = 3 //same as above, the number of sprites the character has -1
			}
		}
		if(mouse_sprite == -1 && class != undefined && class > 0)
		{
			if(class > CHARACTERS.fighter)
			{
				list[| TILE_DATA.unit]--
			}
			else
			{
				list[| TILE_DATA.unit] = (CHARACTERS.last - 1)
			}
		}
	}
}

#endregion

#region TOGGLE AI CONTROLLED / MUST SURVIVE / KILL TO WIN

if(editing_state == EDITING_STATES.mission && keyboard_check(vk_shift))
{
	var list = ds_terrain_data[# grid_x, grid_y]
	
	//AI CONTROLLED
	if(list[| TILE_DATA.unit] >= CHARACTERS.fighter)
	{
		if(keyboard_check_pressed(ord("1")))
		{
			if(list[| TILE_DATA.is_ai_controlled] != true && list[| TILE_DATA.is_ai_controlled] != false)
			{
				if(list[| TILE_DATA.spawn_tile] != 0)
				{
					list[| TILE_DATA.is_ai_controlled] = true
				}
				else
				{
					list[| TILE_DATA.is_ai_controlled] = false
				}
			}
			else
			{
				list[| TILE_DATA.is_ai_controlled] = !list[| TILE_DATA.is_ai_controlled]
			}
		}
	}
	
	//MUST SURVIVE
	if(keyboard_check_pressed(ord("2")))
	{
		if(list[| TILE_DATA.must_survive_this_battle] != true && list[| TILE_DATA.must_survive_this_battle] != false)
		{
			list[| TILE_DATA.must_survive_this_battle] = false
		}
		else
		{
			list[| TILE_DATA.must_survive_this_battle] = !list[| TILE_DATA.must_survive_this_battle]
		}
	}
	
	//KILL TO WIN
	if(keyboard_check_pressed(ord("3")))
	{
		if(list[| TILE_DATA.kill_this_unit_to_win] != true && list[| TILE_DATA.kill_this_unit_to_win] != false)
		{
			list[| TILE_DATA.kill_this_unit_to_win] = false
		}
		else
		{
			list[| TILE_DATA.kill_this_unit_to_win] = !list[| TILE_DATA.kill_this_unit_to_win]
		}
	}
}

#endregion

#region MOVE THE CAMERA

if(!keyboard_check(vk_shift))
{
	if(keyboard_check(ord("W"))) cy -= 10;
	if(keyboard_check(ord("S"))) cy += 10;
	if(keyboard_check(ord("A"))) cx -= 10;
	if(keyboard_check(ord("D"))) cx += 10;

	if(keyboard_check(ord("W")) || keyboard_check(ord("S")) || 
	keyboard_check(ord("A")) || keyboard_check(ord("D")))
	{
		camera_set_view_pos(view_camera[0], cx, cy);
	}
}
#endregion

#region CHANGE THE HEIGHT

if(keyboard_check_pressed(vk_up) )
{
	if((current_height + 1) < max_height) 
	{
		current_height++
	}
	else
	{
		current_height = 0
	}
}

if(keyboard_check_pressed(vk_down) )
{
	if((current_height) > 0) // took away a -1 from current height -  DATE: awhile ago
	{
		current_height--
	}
	else
	{
		current_height = (max_height - 1)
	}
}

#endregion

#region TOGGLE DISPLAY_ALL_HEIGHTS

if(keyboard_check_pressed(vk_tab) ) 
{
	display_all_heights = !display_all_heights;
}

#endregion

#region SAVE / LOAD / CREATE NEW / DELETE CURRENT MAP

//Save map
if(keyboard_check_pressed(vk_f5) )
{
	battle_map_list[| current_map_number] = save_map(current_map_number, ds_terrain_data)
}

//load map
if(ds_list_size(battle_map_list) > 0)
{
	if(keyboard_check(vk_shift))
	{
		if(keyboard_check_pressed(ord("Q")))
		{
			if(current_map_number > 0) 
			{
				current_map_number--;
			}
			else
			{
				current_map_number = (ds_list_size(battle_map_list) - 1);
			}
			
			load_map(current_map_number, ds_terrain_data, battle_map_list);
		}
		else if(keyboard_check_pressed(ord("E")))
		{
			if(current_map_number + 1 < ds_list_size(battle_map_list) )
			{
				current_map_number++;
			}
			else
			{
				current_map_number = 0;
			}
			load_map(current_map_number, ds_terrain_data, battle_map_list);
		}
	}
}

//Create new map
if(keyboard_check_pressed(vk_enter))
{
	create_map(battle_map_list,ds_terrain_data)
}

//delete current map
if(keyboard_check_pressed(vk_backspace) )
{
	current_map_number = delete_map(current_map_number, battle_map_list)
	
	if(ds_list_size(battle_map_list) > 0)
	{
		ds_terrain_data = load_map(0, ds_terrain_data, battle_map_list) 
		// zero should actually probably be current_map_number but it was crashing so i made it zero
	}
	else
	{
		create_map(battle_map_list, ds_terrain_data)
	}
	
}

#endregion

#region CHANGE HEIGHT/WIDTH OF MAP

if(editing_state == EDITING_STATES.map)
{
	if(keyboard_check(vk_shift))
	{
		#region DECREASE GRID HEIGHT
	
	if(keyboard_check_pressed(ord("W")))
	{
		var grid_h = ds_grid_height(ds_terrain_data)
		
		if(grid_h > 1)
		{
			for(var xx = 0; xx < ds_grid_width(ds_terrain_data); xx++)
			{
				var list_to_destroy = ds_terrain_data[# xx, (grid_h - 1) ]
				ds_list_destroy(list_to_destroy);
			}
			
			ds_grid_resize(ds_terrain_data, ds_grid_width(ds_terrain_data), grid_h - 1);
		}
	}
	
	#endregion
		
		#region INCREASE GRID HEIGHT
	
	if(keyboard_check_pressed(ord("S")))
	{
		var yy = ds_grid_height(ds_terrain_data);
		var grid_h = yy + 1;
		ds_grid_resize(ds_terrain_data, ds_grid_width(ds_terrain_data), grid_h);
		
		for(var xx = 0; xx < ds_grid_width(ds_terrain_data); xx++)
		{
			var list = ds_list_create();
			
			for(var i = 0; i < TILE_DATA.last; i++)
			{
				if(i == TILE_DATA.floor_index) list [| i] = 1; else list[| i] = 0;
				if(i == TILE_DATA.spawn_tile) list[| i] = -1; // ****DO I NEED TO PUT THIS HERE???****
			}
			
			ds_terrain_data[# xx, yy] = list;
		}
	}
	
	#endregion
		
		#region DECREASE GRID WIDTH
		
		if(keyboard_check_pressed(ord("A")))
		{
			var xx = ds_grid_width(ds_terrain_data) - 1
			
			if(xx > 0)
			{
				for(var yy = 0; yy < ds_grid_height(ds_terrain_data); yy++)
				{
					var list_to_destroy = ds_terrain_data[# xx, yy ]
					ds_list_destroy(list_to_destroy);
				}
				
				ds_grid_resize(ds_terrain_data, xx, ds_grid_height(ds_terrain_data));
			}
		}
		
		#endregion
		
		#region INCREASE GRID WIDTH
	
	if(keyboard_check_pressed(ord("D")))
	{
		var xx = ds_grid_width(ds_terrain_data);
		var grid_w = xx + 1;
		ds_grid_resize(ds_terrain_data, grid_w, ds_grid_height(ds_terrain_data));
		
		for(var yy = 0; yy < ds_grid_height(ds_terrain_data); yy++)
		{
			var list = ds_list_create();
			
			for(var i = 0; i < TILE_DATA.last; i++)
			{
				if(i == TILE_DATA.floor_index) list [| i] = 1; else list[| i] = 0;
				if(i == TILE_DATA.spawn_tile) list[| i] = -1;
			}
			
			ds_terrain_data[# xx, yy] = list;
		}
	}
	
	#endregion
	}
}

#endregion

#region CHANGE EDITING STATE

if(keyboard_check_pressed(vk_space))
{
	if(editing_state == EDITING_STATES.map)
	{
		editing_state = EDITING_STATES.mission
	}
	else if(editing_state == EDITING_STATES.mission)
	{
		editing_state = EDITING_STATES.map
	}
}

#endregion