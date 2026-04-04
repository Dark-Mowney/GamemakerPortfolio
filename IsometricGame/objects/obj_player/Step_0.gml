if(state == PLAYER_STATES.init)
{
	#region INIT
	
	with(obj_world_point)
	{
		other.path_array[path_point] = id
	}
	
	path_point = collision_point(x, y, obj_world_point, false, true)
	
	for(var i = 0; i < array_length(path_array); i++)
	{
		show_debug_message("path_array[" + string(path_array[i]) + "]")
	}
	
	//FOR THE CUTSCENE AT THE START OF THE GAME
	if(global.ds_values[| VALUES_TO_TRACK.story_state] == STORY.debriefing)
	{
		state = PLAYER_STATES.walking
		mouse_over_path = path_point
	}
	else
	{
		state = PLAYER_STATES.idle
	}

	#endregion
}

if(state == PLAYER_STATES.idle)
{
	#region IDLE
	
	with(obj_world_point)
	{
		image_index = 0
	}
	
	mouse_over_path = collision_point(mouse_x, mouse_y, obj_world_point, false, false)
	
	if(keyboard_check_pressed(vk_enter))
	{
		#region SET STATE TO MENU
		
		state = PLAYER_STATES.world_menu
		highlighted_option = WORLD_ACTIONS.army
		
		#endregion
	}
	else
	{	
		if(mouse_over_path != noone && ds_list_find_index(path_point.connects_to, mouse_over_path.path_point) != -1)
		{
			mouse_over_path.image_index = 1
			
			if(mouse_check_button_pressed(mb_left))
			{
				move_towards_point(mouse_over_path.x, mouse_over_path.y, 1)
				state = PLAYER_STATES.walking
				
				#region SET SPRITE
				
				var dir = point_direction(x, y, mouse_over_path.x, mouse_over_path.y)
				show_debug_message("dir: " + string(dir))
				if (dir >= 90 && dir < 180) 
				{
					sprite_index = char_grid[# ACTOR_SPRITES.idle, FACING.west]
					show_debug_message(sprite_index)
				}
				if (dir >= 0 && dir < 90) 
				{
					sprite_index = char_grid[# ACTOR_SPRITES.idle, FACING.north]
					show_debug_message(sprite_index)
				}
				if (dir >= 270 && dir < 360) 
				{
					sprite_index = char_grid[# ACTOR_SPRITES.idle, FACING.east]
					show_debug_message(sprite_index)
				}
				if (dir >= 180 && dir < 270) 
				{
					sprite_index = char_grid[# ACTOR_SPRITES.idle, FACING.south]
					show_debug_message(sprite_index)
				}
				
				#endregion
			}
		}
	}
	
	#endregion
}

else if(state == PLAYER_STATES.walking)
{
	#region WALKING
	
	if(abs(x - mouse_over_path.x) <= 1 && abs(y - mouse_over_path.y) <= 1)
	{
		speed = 0
		path_point = collision_point(x,y,obj_world_point, false, true)
		state = PLAYER_STATES.idle
		
		#region CHECK FOR CUT SCENE / BATTLE
		
		var story_state = global.ds_values[| VALUES_TO_TRACK.story_state]
		var column_to_check = (path_point.path_point) * PATH_POINT_SETUP.last
		var map = real( global.story_points[# column_to_check, story_state] )
		var map_type = real( global.story_points[# column_to_check + 1, story_state] )
		
		if( map_type != -1 && map_type != MAP_TYPES.shop)
		{
			with(obj_test)
			{
				if( map_type == MAP_TYPES.battle)
				{
					state = BATTLE_STATES.setup_battle
				}
				else
				{
					state = BATTLE_STATES.conversation
				}
				
				//ugly aint it
				map_type_ = map_type
				
				load_map(map, ds_terrain_data, battle_map_list);
				show_map = true
				
				#region SETUP CONVERSATION VARIABLES
				var csv = global.story_points[# column_to_check + PATH_POINT_SETUP.conversation_csv, story_state]
				conversation = load_csv(csv)
				show_debug_message("conversation id: " + string(conversation));
				conversation_entry = 0
				
				show_debug_message("story_state: " + string(story_state))
				show_debug_message("conversation: " + string(conversation))
				show_debug_message("conversation[# 0, conversation_entry]: " + string(conversation[# 0, conversation_entry]))
				
				text = conversation[# 0, conversation_entry]
				speaker = real(string_digits(text))
				
				unit = center_on_speaker(speaker, ds_terrain_data)
				unit_name = global.character_stats[# STATS.name, unit]
				
				remove_digits(text)
			}
		}
		
		#endregion
	}
	
	#endregion
}

else if(state == PLAYER_STATES.world_menu)
{
	#region WORLD MENU
	
	if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
	{
		highlighted_option = change_option(highlighted_option, 0, WORLD_ACTIONS.last - 1)
	}
	
	if(keyboard_check_pressed(vk_backspace))
	{
		state = PLAYER_STATES.idle
	}
	
	if(keyboard_check_pressed(vk_enter))
	{
		if(highlighted_option == WORLD_ACTIONS.army)
		{
			state = PLAYER_STATES.army_screen
			instance_create_layer(0, 0, layer, obj_army_screen)
		}
		
		//GO TO SHOP
		var story_state = global.ds_values[| VALUES_TO_TRACK.story_state]
		var column_to_check = (path_point.path_point) * PATH_POINT_SETUP.last
		var map_type = real ( global.story_points[# column_to_check + 1, story_state] )
		
		if(highlighted_option == WORLD_ACTIONS.shop && map_type == MAP_TYPES.shop)
		{
			state = PLAYER_STATES.shop
			instance_create_layer(0, 0, layer, obj_shop)
		}
	}
	
	#endregion
}