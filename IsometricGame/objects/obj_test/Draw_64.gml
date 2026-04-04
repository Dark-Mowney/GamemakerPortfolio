#region DRAW CONVERSATION

if(state == BATTLE_STATES.conversation)
{
		
	draw_set_font(fnt_conversation)
	var font_size = font_get_size(fnt_conversation)
	
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	
	var sep = font_size * 1.4
	var w = 300
	t_height = string_height_ext(text, sep, w) + 20
	
	var xx = display_get_gui_width() / 2
	var yy = display_get_gui_height() - t_height
	
	//Name
	draw_set_font(fnt_names)
	
	#region DRAW BLACK BACKGROUND
	
	var x1 = xx - (string_width(unit_name) / 2);
	var y1 = yy - (font_size + 20)
	var x2 = xx + (string_width(unit_name) / 2);
	var y2 = yy + string_height(unit_name)
	
	draw_set_colour(c_black)
	draw_rectangle(x1,y1,x2,y2,false)
	
	#endregion
	
	draw_set_colour(c_red)
	draw_text(xx, yy - (font_size + 20), unit_name)
	
	//Text
	draw_set_font(fnt_conversation)
	
	#region DRAW BLACK RECTANGLE
	
	x1 = xx - (string_width_ext(text, sep, w) / 2)
	y1 = yy
	x2 = xx + (string_width_ext(text, sep, w) / 2)
	y2 = yy + string_height_ext(text, sep, w)
	
	draw_set_colour(c_black)
	draw_rectangle(x1,y1,x2,y2, false)
	
	#endregion
	
	draw_set_colour(c_white)
	draw_text_ext(xx, yy, text, sep, w)
	
}
#endregion

if(state == BATTLE_STATES.choose_units)
{
	#region CHOOSE UNITS
	
	draw_sprite(spr_armyscreen, 0, 0, 0)
	
	var draw_scale = 3;
	var tile_width = sprite_get_width( spr_iso_width_height) * draw_scale
	var tile_height = sprite_get_height( spr_iso_width_height) * draw_scale
	
	var start_x = (display_get_gui_width() / 2) - (tile_width / 2)
	var start_y = (display_get_gui_height() / 2) - ( tile_height )
	
	var counter = 0
	
	for(var yy = 0; yy < 2; yy++)
	{
		for( var xx = 0; xx < 4; xx++)
		{
			var draw_x = start_x + (xx - yy) * (tile_width / 2)
			var draw_y = start_y + (xx + yy) * (tile_height / 2)
			
			draw_sprite_ext(spr_iso_spawn_tiles, 0, draw_x, draw_y, draw_scale, draw_scale, 0, c_white, 1)
			var unit = spawn_tile_list[| counter]
			
			if(unit >= CHARACTERS.fighter)
			{
				army_screen_draw_unit(unit, draw_x, draw_y, draw_scale, FACING.south, false)
			}
			
			counter++
		}
	}
	
	#endregion
}