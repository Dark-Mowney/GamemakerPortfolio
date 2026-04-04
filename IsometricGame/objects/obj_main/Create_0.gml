window_set_fullscreen(true)

#region CHARACTER ENUMS

enum FACING
{
	west,
	north,
	east,
	south
}

enum CHARACTERS
{
	leave_empty,
	fighter,
	archer,
	mage,
	priest,
	warrior,
	knight,
	ranger,
	sniper,
	wizard,
	sorceror,
	healer,
	monk,
	butz,
	sarah,
	brian,
	davos,
	last
}

enum STATS
{
	name,
	is_special_character,
	on_players_team,
	is_ai_controlled,
	must_survive_this_battle,
	class,
	kill_this_unit_to_win,
	hp_max,
	hp_current,
	mp_max,
	mp_current,
	level,
	xp,
	strength,
	intelligence,
	defence,
	wisdom,
	accuracy,
	agility,
	block_chance_melee,
	block_chance_range,
	fire_resist,
	ice_resist,
	left_hand,
	right_hand,
	chest,
	accessory,
	item_1,
	item_2,
	last
}

global.character_stats = load_csv("classes_and_characters.csv")

#endregion

#region WORLD ACTIONS

enum WORLD_ACTIONS
{
	army,
	save,
	load,
	shop,
	last
}

global.WORLD_ACTION_TEXT[WORLD_ACTIONS.army] = "Army"
global.WORLD_ACTION_TEXT[WORLD_ACTIONS.save] = "Save"
global.WORLD_ACTION_TEXT[WORLD_ACTIONS.load] = "Load"
global.WORLD_ACTION_TEXT[WORLD_ACTIONS.shop] = "Shop"

#endregion

#region SETUP MAP SPRITE ARRAY

global.cell_sprites[TILE_DATA.floor_index] = spr_iso_floor;
global.cell_sprites[TILE_DATA.decoration_index] = spr_iso_decoration;

#endregion

#region SETUP CHARACTER SPRITE GRIDS

enum ACTOR_SPRITES
{
	idle,
	last
}

global.char_sprite_grids = ds_list_create();

#region FIGHTER SPRITE SETUP

var fightergrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

fightergrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_fighter_idle_e
fightergrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_fighter_idle_w
fightergrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_fighter_idle_n
fightergrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_fighter_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.fighter, fightergrid)
global.char_sprite_grids[| CHARACTERS.fighter] = fightergrid;

#endregion

#region ARCHER SPRITE SETUP

var archergrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

archergrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_archer_idle_e
archergrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_archer_idle_w
archergrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_archer_idle_n
archergrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_archer_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.archer, archergrid)
global.char_sprite_grids[| CHARACTERS.archer] = archergrid;

#endregion

#region MAGE SPRITE SETUP

var magegrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

magegrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_mage_idle_e
magegrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_mage_idle_w
magegrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_mage_idle_n
magegrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_mage_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.mage, magegrid)
global.char_sprite_grids[| CHARACTERS.mage] = magegrid;


#endregion

#region PRIEST SPRITE SETUP

var priestgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

priestgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_priest_idle_e
priestgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_priest_idle_w
priestgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_priest_idle_n
priestgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_priest_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.priest, priestgrid)
global.char_sprite_grids[| CHARACTERS.priest] = priestgrid;


#endregion

#region WARRIOR SPRITE SETUP

var warriorgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

warriorgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_warrior_idle_e
warriorgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_warrior_idle_w
warriorgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_warrior_idle_n
warriorgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_warrior_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.warrior, warriorgrid)
global.char_sprite_grids[| CHARACTERS.warrior] = warriorgrid;


#endregion

#region KNIGHT SPRITE SETUP

var knightgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

knightgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_knight_idle_e
knightgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_knight_idle_w
knightgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_knight_idle_n
knightgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_knight_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.knight, knightgrid)
global.char_sprite_grids[| CHARACTERS.knight] = knightgrid;


#endregion

#region RANGER SPRITE SETUP

var rangergrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

rangergrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_ranger_idle_e
rangergrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_ranger_idle_w
rangergrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_ranger_idle_n
rangergrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_ranger_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.ranger, rangergrid)
global.char_sprite_grids[| CHARACTERS.ranger] = rangergrid;


#endregion

#region SNIPER SPRITE SETUP

var snipergrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

snipergrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_sniper_idle_e
snipergrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_sniper_idle_w
snipergrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_sniper_idle_n
snipergrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_sniper_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.sniper, snipergrid)
global.char_sprite_grids[| CHARACTERS.sniper] = snipergrid;


#endregion

#region WIZARD SPRITE SETUP

var wizardgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

wizardgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_wizard_idle_e
wizardgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_wizard_idle_w
wizardgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_wizard_idle_n
wizardgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_wizard_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.wizard, wizardgrid)
global.char_sprite_grids[| CHARACTERS.wizard] = wizardgrid;


#endregion

#region SORCEROR SPRITE SETUP

var sorcerorgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

sorcerorgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_sorceror_idle_e
sorcerorgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_sorceror_idle_w
sorcerorgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_sorceror_idle_n
sorcerorgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_sorceror_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.sorceror, sorcerorgrid)
global.char_sprite_grids[| CHARACTERS.sorceror] = sorcerorgrid;


#endregion

#region HEALER SPRITE SETUP

var healergrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

healergrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_healer_idle_e
healergrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_healer_idle_w
healergrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_healer_idle_n
healergrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_healer_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.healer, healergrid)
global.char_sprite_grids[| CHARACTERS.healer] = healergrid;


#endregion

#region MONK SPRITE SETUP

var monkgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

monkgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_monk_idle_e
monkgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_monk_idle_w
monkgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_monk_idle_n
monkgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_monk_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.monk, monkgrid)
global.char_sprite_grids[| CHARACTERS.monk] = monkgrid;


#endregion

#region BUTZ SPRITE SETUP

var butzgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

butzgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_butz_idle_e
butzgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_butz_idle_w
butzgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_butz_idle_n
butzgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_butz_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.butz, butzgrid)
global.char_sprite_grids[| CHARACTERS.butz] = butzgrid;


#endregion

#region SARAH SPRITE SETUP

var sarahgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

sarahgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_sarah_idle_e
sarahgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_sarah_idle_w
sarahgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_sarah_idle_n
sarahgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_sarah_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.sarah, sarahgrid)
global.char_sprite_grids[| CHARACTERS.sarah] = sarahgrid;


#endregion

#region BRIAN SPRITE SETUP

var briangrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

briangrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_brian_idle_e
briangrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_brian_idle_w
briangrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_brian_idle_n
briangrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_brian_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.brian, briangrid)
global.char_sprite_grids[| CHARACTERS.brian] = briangrid;


#endregion

#region DAVOS SPRITE SETUP

var davosgrid = ds_grid_create(ACTOR_SPRITES.last, CHARACTERS.last)

davosgrid[# ACTOR_SPRITES.idle, FACING.east] = spr_iso_davos_idle_e
davosgrid[# ACTOR_SPRITES.idle, FACING.west] = spr_iso_davos_idle_w
davosgrid[# ACTOR_SPRITES.idle, FACING.north] = spr_iso_davos_idle_n
davosgrid[# ACTOR_SPRITES.idle, FACING.south] = spr_iso_davos_idle_s

//ds_list_insert(global.char_sprite_grids, CHARACTERS.davos, davosgrid)
global.char_sprite_grids[| CHARACTERS.davos] = davosgrid;


#endregion

#endregion

#region SETUP MISSIONS

//enum MISSION_PARAMS
//{
//	map,
//	conversation_csv,
//	last
//}

//global.mission_grid = ds_grid_create(MISSION_PARAMS.last, 3)

//global.mission_grid[# MISSION_PARAMS.map, 0] = 0
//global.mission_grid[# MISSION_PARAMS.conversation_csv, 0] = "conversation_1.csv"

//global.mission_grid[# MISSION_PARAMS.map, 0] = 1
//global.mission_grid[# MISSION_PARAMS.conversation_csv, 0] = "conversation_2.csv"  ***REMOVED 01/09***

#endregion

#region STATES

enum GAME_STATES
{
	editing,
	testing,
	game
}

enum STORY
{
	leave_empty,
	debriefing,
	first_battle,
	second_battle,
	third_battle,
	last
}

enum MAP_TYPES
{
	story_scene,
	battle,
	shop,
	last
}

enum PATH_POINT_SETUP
{
	map,
	type_of_map,
	conversation_csv,
	last
}

enum VALUES_TO_TRACK
{
	story_state,
	player_x,
	player_y,
	player_facing,
	last
}

global.ds_values = ds_list_create()

global.ds_values[| VALUES_TO_TRACK.story_state] = STORY.first_battle

game_state = GAME_STATES.editing

if(game_state == GAME_STATES.editing)
{
	room_goto(rm_editor)
}
if(game_state == GAME_STATES.testing)
{
	room_goto(rm_testing)
}
if(game_state == GAME_STATES.game)
{
	room_goto(rm_world_map)
}

#endregion

#region SETUP STORY MAPS/MISSION

global.story_points = load_csv("world_path_maps.csv")

#endregion

#region ITEMS / INVENTORY

enum ITEMS
{
	empty,
	dagger,
	sword,
	short_bow,
	bow,
	staff,
	axe,
	large_shield,
	leather_chest,
	metal_chest,
	ring_fire,
	ring_ice,
	ring_magic,
	ring_accuracy,
	tome_fire,
	tome_ice,
	tome_healing,
	heal_potion,
	mana_potion,
	last
}

enum ITEM_STATS //SHOULD RENAME THIS BAD NAME
{
	name,
	fighter_equip,
	archer_equip,
	mage_equip,
	priest_equip,
	warrior_equip,
	knight_equip,
	ranger_equip,
	sniper_equip,
	wizard_equip,
	sorceror_equip,
	healer_equip,
	monk_equip,
	cost,
	equip_where
}

enum EQUIP_WHERE
{
	hands,
	accessory,
	armour,
	item,
	nowhere
}

global.gear_goes_where[STATS.left_hand] = EQUIP_WHERE.hands
global.gear_goes_where[STATS.right_hand] = EQUIP_WHERE.hands
global.gear_goes_where[STATS.chest] = EQUIP_WHERE.armour
global.gear_goes_where[STATS.accessory] = EQUIP_WHERE.accessory
global.gear_goes_where[STATS.item_1] = EQUIP_WHERE.item
global.gear_goes_where[STATS.item_2] = EQUIP_WHERE.item

global.items = load_csv("item_stats.csv")

global.inventory = ds_list_create()


/*
	THIS LIST IS A FIXED SIZE, 1 FOR EVERY ITEM IN THE GAME. THE VALUE AT
	EACH INDEX IS THE QUANTITY IN THE PLAYERS INVENTORY
*/

//setting the quantity to zero for every item
for(var i = 0; i < ITEMS.last; i++)
{
	global.inventory[| i] = 0
}

//ADDING ITEMS FOR TESTING
global.inventory[| ITEMS.leather_chest] = 2
global.inventory[| ITEMS.sword] = 2
global.inventory[| ITEMS.dagger] = 1

#endregion