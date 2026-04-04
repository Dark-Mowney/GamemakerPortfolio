/// @function army_screen_draw_unit(unit, draw_x, draw_y, draw_scale, facing, draw_name)
/// @description draw a unit for the army screen
/// @param {real} unit - which unit are we trying to draw (Class/Special Character)
/// @param {real} draw_x - x coordinate to draw
/// @param {real} draw_y - y coordinate to draw
/// @param {real} draw_scale - how much to scale the sprite
/// @param {real} facing - which facing do we want to draw
/// @param {boolean} draw_name - draw the name?

function army_screen_draw_unit(unit, draw_x, draw_y, draw_scale, facing, draw_name)
{
	var sprite_grid = global.char_sprite_grids[| unit]
	
	if(global.character_stats[# STATS.is_special_character, unit] == "0")
	{
		var class = global.character_stats[# STATS.class, unit]
		sprite_grid = global.char_sprite_grids[| class]
	}
	
	var sprite = sprite_grid[# ACTOR_SPRITES.idle, facing]
	var name = global.character_stats[# STATS.name, unit]
	
	draw_sprite_ext(sprite, 0, draw_x, draw_y, draw_scale, draw_scale, 0, c_white, 1)
	
	if(draw_name)
	{
		draw_set_halign(fa_center)
		draw_set_valign(fa_bottom)
		draw_set_colour(c_red)
		draw_set_font(fnt_editor)
		
		draw_text(draw_x, draw_y + ( (sprite_get_height(spr_army_selection) - sprite_get_yoffset(spr_army_selection) ) * draw_scale ), name)
	}
}