/// @function create_unit(class, level, grid, entry)
/// @description Add a unit to a grid (eg a shop or enemy army grid for battle
/// @param {real} unit_class - the class of the new unit
/// @param {real} unit_level - the level of the new unit - this will affect its stats
/// @param {real} character_grid - the grid to add the unit to

function create_unit(class, level, grid, entry = -1)
{
	for (var yy = 0; yy < ds_grid_height(grid); yy++)
	{
		if(grid[# STATS.name, yy] == "")
		{
			entry = yy; 
			break;
		}
	}
	
	if(entry == -1)
	{
		entry = ds_grid_height(grid)
		ds_grid_resize(grid, ds_grid_width(grid), ds_grid_height(grid) + 1)
	}
	
	//ADJUSTING STATS BASED ON LEVEL
	for(var stats = 0; stats < STATS.last; stats++)
	{
		grid[# stats, entry] = global.character_stats[# stats, class]
		
		if (stats >= STATS.hp_max && stats <= STATS.mp_current)
		{
			grid[# stats, entry] = ( real(global.character_stats[# stats, class]) * level)
		}
		if(stats == STATS.level)
		{
			grid[# stats, entry] = level
		}
		if(stats >= STATS.strength && stats <= STATS.accuracy) 
		{
			grid[# stats, entry] = (real(global.character_stats[# stats, class]) * level )
		}
	}
	
	return(entry)
}