enum PLAYER_STATES
{
	init,
	idle,
	walking,
	talking,
	army_screen,
	world_menu,
	shop
}

path_point = noone
state = PLAYER_STATES.init
unit = -1

char_grid = global.char_sprite_grids[| CHARACTERS.fighter]