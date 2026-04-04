///@function delete_map(map_number, list_of_battle_maps)
///@description delete the map
///@param {real} map_number - the number of the map to delete
///@param {real} list_of_battle_maps - the list from which we are deleting from
function delete_map(map_number, list_of_battle_maps)
{
	ds_list_delete(list_of_battle_maps, map_number)
	
	if(map_number >= ds_list_size(list_of_battle_maps))
	{
		map_number = (ds_list_size(list_of_battle_maps) - 1);
		
		show_debug_message(map_number)
		
		return map_number;
	}
}