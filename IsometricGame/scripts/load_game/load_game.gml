// blah blah blah

function load_game()
{
	ini_open("battle_map_strings.ini")
	
	total_maps = ini_read_real("Total Maps", "Value", total_maps);
	
	for(var i = 0; i < total_maps; i++)
	{
		var str = ini_read_string("Data String", string(i), "")
		battle_map_list[| i] = str;
		
		//show_debug_message(str);
		//show_debug_message("TESTER"); ***DEBUG INIT
	}
	
	ini_close()
	
	if(ds_list_size(battle_map_list) > 0)
	{
		load_map(0, ds_terrain_data, battle_map_list)
	}
}