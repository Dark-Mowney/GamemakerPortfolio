#region CHANGE OPTION

if(keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) )
{
	if(state == ARMY_STATES.choose_unit)
	{
		selected_unit = change_option(selected_unit, 0, ds_list_size(army_list) - 1)
	}
	if(state == ARMY_STATES.change_class)
	{
		selected_option = change_option(selected_option, CHARACTERS.fighter, CHARACTERS.monk)
	}
}
if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
{
	if(state == ARMY_STATES.display_options)
	{
		selected_option = change_option(selected_option, ARMY_STATES.change_class, ARMY_STATES.fire_unit)
	}
}

#endregion

if(keyboard_check_pressed(vk_enter))
{
	#region PRESS ENTER
	
	if(state == ARMY_STATES.choose_unit)
	{
		state = ARMY_STATES.display_options
		selected_option = ARMY_STATES.change_class
	}
	else
	{
		if(state == ARMY_STATES.display_options)
		{
			state = selected_option
			
			if(state == ARMY_STATES.change_class)
			{
				selected_option = real(global.character_stats[# STATS.class, army_list[| selected_unit] ])
			}
			else
			{
				selected_option = 0
				
				if(state == ARMY_STATES.fire_unit)
				{
					#region FIRE UNIT
					
					if(global.character_stats[# STATS.is_special_character, army_list[| selected_unit] ] == "0")
					{
						// **TO DO** remove items and add them to inventory **TO DO**
						
						//remove the character from the grid and the army list
						for(var xx = 0; xx < STATS.last; xx++)
						{
							global.character_stats[# xx, army_list[| selected_unit] ] = "-1"
						}
						ds_list_delete(army_list, selected_unit)
						
						//make sure selected unit is not larger than the size of the list
						selected_unit = clamp(selected_unit, 0, ds_list_size(army_list) - 1)
						
						//set state
						state = ARMY_STATES.choose_unit
						selected_option = selected_unit
					}
					else
					{
						//if the unit is special, do not remove
						state = ARMY_STATES.display_options
						selected_option = ARMY_STATES.fire_unit
					}
				}
			}
		}
		else
		{
			if(state == ARMY_STATES.change_class)
			{
				#region CHANGE UNITS CLASS
				
				global.character_stats[# STATS.class, army_list[| selected_unit] ] = string(selected_option)
				
				#region UNEQUIP INAPPROPRIATE GEAR FOR THIS CLASS
				
				var start = STATS.left_hand
				var _end = STATS.item_2
				
				for(var i = start; i <= _end; i++)
				{
					show_debug_message("global.character_stats[# " + string(i) + ", army_list[| selected_unit] ]: " + string(global.character_stats[# i, army_list[| selected_unit] ]))
					var item = real(global.character_stats[# i, army_list[| selected_unit] ]);
					show_debug_message("item: " + string(item));
					
					if(item != ITEMS.empty)
					{
						show_debug_message("selected_option: " + string(selected_option))
						show_debug_message("grid_height: " + string(ds_grid_height(global.items)));
						var can_be_used_by_this_class = global.items[# item, selected_option]
						
						if(can_be_used_by_this_class == "0")
						{
							show_debug_message("i: " + string(i))
							show_debug_message("list size: " + string(ds_list_size(global.inventory) ))
							global.inventory[| item] ++
							
							global.character_stats[# i, army_list[| selected_unit] ] = ITEMS.empty
						}
					}
				}
				
				#endregion
				
				selected_option = ARMY_STATES.change_class
				state = ARMY_STATES.display_options
				
				#endregion
			}
		}
	}
}
	
#endregion

if(keyboard_check_pressed(vk_backspace))
{
	#region PRESS BACKSPACE
	
	if(state == ARMY_STATES.display_options)
	{
		state = ARMY_STATES.choose_unit
		selected_unit = 0
		selected_option = 0
	}
	else
	{
		if(state = ARMY_STATES.choose_unit)
		{
			obj_player.state = PLAYER_STATES.world_menu
			instance_destroy()
		}
		else
		{
			state = ARMY_STATES.display_options
			selected_option = ARMY_STATES.change_class
		}
		
		ds_list_clear(gear_list)
	}
	
	#endregion
}