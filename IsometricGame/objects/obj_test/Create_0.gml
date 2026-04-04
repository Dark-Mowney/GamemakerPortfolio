iso_width = sprite_get_width(spr_iso_width_height);
iso_height = sprite_get_height(spr_iso_width_height);
display_all_heights = true;

mission_to_load = 0 ///not being used atm
conversation_entry = 0
conversation = -1

//SETUP GRID
total_maps = 0
battle_map_list = ds_list_create()

ds_terrain_data = ds_grid_create(1,1)
var list = ds_list_create()
ds_terrain_data[# 0, 0] = list

map_index_to_load = real( global.story_points[# PATH_POINT_SETUP.map, STORY.debriefing] )

																////SETUP CONVERSATION
																//var csv = global.mission_grid[# MISSION_PARAMS.conversation_csv, mission_to_load]
																//conversation = load_csv(csv)
																
																//text = conversation[# 0, conversation_entry]
																//speaker = real(string_digits(text))
					//could delete all this stuff maybe											
																////remove digits from string
																//for(var i = 1; i < string_length(text); i++)
																//{
																//	var char = string_char_at(text, i);
																//	if(string_digits(char) != "")
																//	{
																//		text = string_delete(text, i, 1)
																//	}
																//}               ****REMOVED 01/09****

load_game()
load_map(map_index_to_load, ds_terrain_data, battle_map_list)

																//unit = 0
																//unit = center_on_speaker(speaker, ds_terrain_data)
																//unit_name = global.character_stats[# STATS.name, unit]  ***KEEP THIS FOR LATER MAYBE***

show_map = false

enum BATTLE_STATES
{
	idle,
	setup_battle,
	choose_units,
	conversation,
	in_battle,
	done
}

state = BATTLE_STATES.idle
spawn_tile_list = ds_list_create()