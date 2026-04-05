enum ARMY_STATES
{
	choose_unit,
	display_options,
	change_class,
	change_equipment,
	fire_unit,
	last
}

option_text[ARMY_STATES.change_class] = "CHANGE CLASS"
option_text[ARMY_STATES.change_equipment] = "CHANGE GEAR"
option_text[ARMY_STATES.fire_unit] = "FIRE UNIT"

army_list = ds_list_create()
stats_to_display = ds_list_create()
sort_stats(stats_to_display)


stats_text_grid = load_csv("stat_strings.csv")

selected_unit = 0
selected_option = ARMY_STATES.change_class
state = ARMY_STATES.choose_unit

//#region ADD SOME UNITS TO THE PLAYER ARMY    ****JAN 12 SHOULD BE ABLE TO BUY UNITS SOON SO DO NOT NEED****

//var entry = create_unit(CHARACTERS.fighter, 1, global.character_stats)
//global.character_stats[# STATS.on_players_team, entry] = 1
//entry = create_unit(CHARACTERS.wizard, 1, global.character_stats)
//global.character_stats[# STATS.on_players_team, entry] = 1

//#endregion

//add any character on player team to the army list
for(var yy = 0; yy < ds_grid_height(global.character_stats ); yy++)
{
	if(global.character_stats[# STATS.on_players_team, yy] == "1")
	{
		ds_list_add(army_list, yy)
	}
}

gear_list = ds_list_create()
show_gear_list = false

#region TESTING

global.character_stats[# STATS.right_hand, CHARACTERS.butz] = ITEMS.sword
global.character_stats[# STATS.chest, CHARACTERS.butz] = ITEMS.leather_chest

#endregion