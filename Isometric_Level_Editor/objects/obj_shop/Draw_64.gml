draw_sprite(spr_shop_bg, 0, 0, 0)

if(state == SHOP_STATES.display_buy_sell || SHOP_STATES.display_items_units)
{
	
	#region DISPLAY OPTIONS
	
	draw_set_font(fnt_conversation)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_colour(c_white)
	
	var i_start = -1
	
	if(state == SHOP_STATES.display_items_units)
	{
		i_start = SHOP_STATES.items
	}
	else
	{
		i_start = SHOP_STATES.buy
	}
	
	var count = 1
	
	for (var i = i_start; i <= (i_start + 1); i++)
	{
		draw_set_colour(c_gray)
		if(selected_option == i)
		{
			draw_set_colour(c_white)
		}
		draw_text(0, count*30,text[i])
		
		count++
	}
	
	#endregion
}

if(state == SHOP_STATES.items)
{
	#region ITEMS
	
	for(var i = 0; i < ds_list_size(list_of_items); i++)
	{
		var item_width = sprite_get_width(spr_item_icons)
		var item_height = sprite_get_height(spr_item_icons)
		var draw_x = (item_width * 2) + (i * item_width)
		var draw_y = (item_height * 2)
		var item = list_of_items[| i]
		
		draw_sprite(spr_item_bg, 0, draw_x, draw_y)
		draw_sprite(spr_item_icons, item, draw_x, draw_y)
		
		if(selected_option == i)
		{
			draw_set_alpha(0.5)
			draw_set_colour(c_white)
			draw_rectangle(draw_x - (item_width / 2), draw_y - (item_height / 2), draw_x + (item_width / 2), draw_y + (item_height / 2), false)
			draw_set_alpha(1)
		}
	}
	
	#endregion
}

if(state ==SHOP_STATES.units)
{
	
	#region UNITS
	
	var draw_scale = 3
	var unit_width = sprite_get_width(spr_iso_actor_idle_e) * draw_scale
	var unit_height = sprite_get_height(spr_iso_actor_idle_e) * draw_scale
	var start_x = unit_width
	var start_y = unit_height
	
	for(var i = 0; i < ds_list_size(list_of_units); i++)
	{
		var draw_x = start_x + (unit_width * i)
		var draw_y = start_y
		var unit = list_of_units[| i]
		army_screen_draw_unit(unit, draw_x, draw_y, draw_scale, FACING.east, true)
		
		if(selected_option == i)
		{
			draw_sprite_ext(spr_army_selection, 0, draw_x, draw_y, draw_scale, draw_scale, 0, c_white, 1)
		}
	}
	
	#endregion
}

if(state == SHOP_STATES.sell)
{
	#region SELL
	
	var start_x = 32
	var start_y = 64
	var scale = 2
	var item_width = sprite_get_width(spr_item_icons) * scale
	var item_height = sprite_get_height(spr_item_icons) * scale
	
	for(var i = 0; i < ds_list_size(list_of_inventory); i++)
	{
		var draw_x = start_x + (i * item_width)
		var draw_y = start_y
		var item = list_of_inventory[| i]
		var quantity = global.inventory[| item]
		
		draw_sprite_ext(spr_item_bg, 0, draw_x, draw_y, scale, scale, 0, c_white, 1)
		draw_sprite_ext(spr_item_icons, item, draw_x, draw_y, scale, scale, 0, c_white, 1)
		
		draw_set_halign(fa_right)
		draw_set_valign(fa_bottom)
		draw_set_colour(c_yellow)
		draw_set_font(fnt_editor)
		draw_text(draw_x + (item_width / 2), draw_y + (item_height / 2), "x" + string(quantity) )
		
		if(selected_option == i)
		{
			draw_set_alpha(0.5)
			draw_set_colour(c_white)
			draw_rectangle(draw_x - (item_width / 2), draw_y - (item_height / 2), draw_x + (item_width / 2), draw_y + (item_height / 2), false)
			draw_set_alpha(1)
		}
	}
	
	#endregion
}
