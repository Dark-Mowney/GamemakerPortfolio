///@function center_on_speaker(speaker, terrain grid)
///@description Center the map on whoever is speaking
///@param {real} speaker - the unique_conversation_index of the speaker
///@param {real} terrain_grid - which grid holds the tile lists that we are drawing the map with
function center_on_speaker(speaker,terrain_grid)
{
	
	var draw_height = -1
	var unit = -1
	
	for(var yy = 0; yy < ds_grid_height(terrain_grid); yy++)
	{
		for(var xx = 0; xx < ds_grid_width(terrain_grid); xx++)
		{
			var list = terrain_grid[# xx, yy]
			var con_in = list[| TILE_DATA.conversation_index]
			
			if(con_in == speaker)
			{
				draw_height = list[| TILE_DATA.height]
				unit = list[| TILE_DATA.unit]
				
				show_debug_message("unit: " + string(unit))
				
				cx = (xx - yy) * (iso_width / 2)
				cy = (xx + yy) * (iso_height / 2) - (draw_height * (iso_height / 2) )
				
				camera_set_view_pos(view_camera[0], cx - ( camera_get_view_width(view_camera[0]) / 2), cy - ( camera_get_view_height(view_camera[0]) / 2) )
				
				show_debug_message("FOUND SPEAKER: " + string(xx) + "/" + string(yy))
				
				break;
			}
		}
	}
	
	if(unit > -1)
	{
		return(unit)
	}
	else
	{
		return(CHARACTERS.fighter)
	}
	
}