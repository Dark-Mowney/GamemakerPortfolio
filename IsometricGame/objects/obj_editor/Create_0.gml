#region SETUP TILE ENUMERATOR

enum TILE_DATA
{
	floor_index,
	decoration_index,
	height,
	spawn_tile,
	conversation_index,
	unit,
	unit_facing,
	is_ai_controlled,
	must_survive_this_battle,
	kill_this_unit_to_win,
	last
}

#endregion

#region SETUP GRID

hcells = 10;
vcells = 10;

ds_terrain_data = ds_grid_create(hcells, vcells);

for(var yy = 0; yy < vcells; yy++;)
{
	for(var xx = 0; xx < hcells; xx++;)
	{
		//ds_terrain_data[# xx, yy] = 1;
		
		var list = ds_list_create();
		
		for(var i = 0; i < TILE_DATA.last; i++)
		{
			if(i == TILE_DATA.floor_index) list[|i] = 1; else list[|i] = 0;
			if(i == TILE_DATA.spawn_tile) list[|i] = -1;
		}
		
		ds_terrain_data[# xx, yy] = list;
		
		show_debug_message(list)
	}
}

#endregion

#region VARIABLES

grid_x = 0;
grid_y = 0;
new_index = 1;
iso_width = sprite_get_width(spr_iso_width_height);
iso_height = sprite_get_height(spr_iso_width_height);
current_height = 0
max_height = 12
current_part = TILE_DATA.floor_index
current_sprite = global.cell_sprites[current_part]

display_all_heights = true;

current_map_number = 0;
battle_map_list = ds_list_create();
total_maps = 0

//Center the camera
cx = (iso_width / 2) - (camera_get_view_width(view_camera[0]) / 2);
cy = -(camera_get_view_height(view_camera[0]) / 4);
camera_set_view_pos(view_camera[0], cx, cy);

mouse_sprite = -1
mouse_index = 0
unique_conversation_index = 0

#endregion

#region EDITING STATES

enum EDITING_STATES
{
	map,
	mission
}

editing_state = EDITING_STATES.map

#endregion

load_game()