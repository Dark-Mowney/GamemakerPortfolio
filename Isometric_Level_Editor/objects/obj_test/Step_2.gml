//GO TO NEXT ENTRY OF CONVERSATION

if(state == BATTLE_STATES.conversation)
{
	#region CONVERSATION
	
	if(keyboard_check_pressed(vk_enter))
	{
		if((conversation_entry + 1) < ds_grid_height(conversation))
		{
			conversation_entry++
			text = conversation[# 0, conversation_entry]
			speaker = real(string_digits(text))
		
			//Remove digits from string
			remove_digits(text)
			
			unit = center_on_speaker(speaker, ds_terrain_data)
			if(unit != undefined) //I put this check here because it kept crashing because it was undefined. I think because I dont have a map yet.
			{
				unit_name = global.character_stats[# STATS.name, unit]
			}
		}
		else
		{
			if(map_type_ != MAP_TYPES.battle)
			{
				state = BATTLE_STATES.done
			}
			else
			{
				state = BATTLE_STATES.in_battle
			}
			
			if(state == BATTLE_STATES.done)
			{
				global.ds_values[| VALUES_TO_TRACK.story_state] ++
				show_map = false
				camera_set_view_pos(view_camera[0], 0, 0)
				
				state = BATTLE_STATES.idle
				obj_player.state = PLAYER_STATES.idle
			}
		}
	}
	
	#endregion
}

if(state == BATTLE_STATES.setup_battle)
{
	#region SETUP BATTLE
	
	ds_list_clear(spawn_tile_list)
	
	for(var yy = 0; yy < ds_grid_height(ds_terrain_data); yy++)
	{
		for(var xx = 0; xx < ds_grid_width(ds_terrain_data); xx++)
		{
			var list = ds_terrain_data[# xx, yy]
			
			if(list[| TILE_DATA.spawn_tile] == 0)
			{
				var unit = list[| TILE_DATA.unit]
				ds_list_add(spawn_tile_list, unit)
			}
		}
	}
	
	state = BATTLE_STATES.choose_units
	
	#endregion
}
//LEAVE CURRENT MAP AND ADVANCE STORY
//if(keyboard_check_pressed(vk_enter))
//{
//	global.ds_values[| VALUES_TO_TRACK.story_state]++;
//	show_map = false
//	camera_set_view_pos(view_camera[0], 0, 0)
//}