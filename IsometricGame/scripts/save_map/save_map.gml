/// @function save_map(map_number, grid to copy from)
/// @description this script saves the current map you are working on to be used later.
/// @param {real} map_number - This is the number of the map you would like to save. Like an index.
/// @param {real} grid_to_copy_from - asdf
function save_map(map_number, grid_to_copy_from)
{
	var grid_width = ds_grid_width(grid_to_copy_from)
	var grid_height = ds_grid_height(grid_to_copy_from)
	
	var grid_to_write_to = ds_grid_create(grid_width, grid_height)
	
	for(var yy = 0; yy < grid_height; yy++)
	{
		for(var xx = 0; xx < grid_width; xx++)
		{
			var list = grid_to_copy_from[# xx, yy]
			var list_str = ds_list_write(list);
			show_debug_message(list_str)
			
			grid_to_write_to[# xx, yy] = list_str;
		}
	}
	
	var grid_and_lists_string = ds_grid_write(grid_to_write_to)
	show_debug_message(grid_and_lists_string)
	show_debug_message("Map " + string(map_number) + " saved");
	
	ds_grid_destroy(grid_to_write_to)
	
	return grid_and_lists_string;
}