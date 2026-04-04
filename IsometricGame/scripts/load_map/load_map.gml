///@function load_map(map_number, grid_to_copy_to, list_of_battle_maps)
///@description loads in a previously saved map
///@param {real} map_number - The number of the map to load in.
///@param {real} grid_to_copy_to - 
///@param {list} list_of_battle_maps - 
function load_map(map_number, grid_to_copy_to, list_of_battle_maps)
{
	var grid_to_copy_from = ds_grid_create(1, 1);
	
	if(list_of_battle_maps[| map_number] != undefined) && (list_of_battle_maps[| map_number] != "")
	{
		ds_grid_read(grid_to_copy_from, list_of_battle_maps[| map_number]);
		
		for(var yy = 0; yy < ds_grid_width(grid_to_copy_to); yy++)
		{
			for(var xx = 0; xx < ds_grid_width(grid_to_copy_to); xx++)
			{
				var list = grid_to_copy_to[# xx, yy]
				ds_list_destroy(list);
			}
		}
		var grid_width = ds_grid_width(grid_to_copy_from);
		var grid_height = ds_grid_height(grid_to_copy_from);
		
		ds_grid_resize(grid_to_copy_to, grid_width, grid_height)
		
		unique_conversation_index = 0;
		
		for(var yy = 0; yy < grid_height; yy++)
		{
			for(var xx = 0; xx < grid_width; xx++)
			{
				var list = ds_list_create()
				var list_str = grid_to_copy_from[# xx, yy];
				ds_list_read(list, list_str);
				
				grid_to_copy_to[# xx, yy] = list;
				
				//show_debug_message(list) ***DEBUG LOADMAP
				
				var con_in = list[| TILE_DATA.conversation_index]
				if(con_in != undefined && con_in > unique_conversation_index)
				{
					unique_conversation_index = con_in
				}
			}
		}
		
		if(unique_conversation_index != 0)
		{
			unique_conversation_index++
		}
		
		show_debug_message("Map " + string(map_number) + " Loaded");
		ds_grid_destroy(grid_to_copy_from);
		
		return grid_to_copy_to;
		
	}
	else
	{
		show_debug_message("Map failed to load")
		return grid_to_copy_to;
	}
	
	
}