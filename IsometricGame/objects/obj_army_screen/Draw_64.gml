//THERE ARE MOUSE INPUTS IN THIS EVENT IN THE DISPLAY STATS REGION, I DID THIS FOR SIMPLICITY SAKE

draw_sprite(spr_armyscreen, 0, 0, 0)

var draw_scale = 3

if(state == ARMY_STATES.choose_unit)
{
	#region CHOOSE UNIT
	
	
	var start_x = sprite_get_width(spr_iso_actor_idle_e) * draw_scale
	var start_y = (sprite_get_height(spr_iso_actor_idle_e) * draw_scale) + 20
	
	for(var i = 0; i < ds_list_size(army_list); i++)
	{
		var draw_x = start_x + (i * sprite_get_width(spr_iso_actor_idle_e) * draw_scale )
		var draw_y = start_y
		
		army_screen_draw_unit(army_list[| i], draw_x, draw_y, draw_scale, FACING.east, true)
		
		if(i == selected_unit)
		{
			draw_sprite_ext(spr_army_selection, 0, draw_x, draw_y, draw_scale, draw_scale, 0, c_white, 1)
		}
	}
	
	#endregion	
}

#region DRAW SELECTED UNIT

if(state == ARMY_STATES.display_options || state == ARMY_STATES.change_equipment || state == ARMY_STATES.change_class)
{
	
	var draw_x = display_get_gui_width() / 2
	var draw_y = sprite_get_height(spr_iso_actor_idle_e) * draw_scale
	
	army_screen_draw_unit(army_list[| selected_unit], draw_x, draw_y, draw_scale, FACING.east, true)
}

#endregion

if(state == ARMY_STATES.display_options)
{
	#region DISPLAY OPTIONS

	for(var i = ARMY_STATES.change_class; i < ARMY_STATES.last; i++)
	{
		var text = option_text[i]
		var start_y = display_get_gui_height() - (24 * 4)
		var can_be_sacked = -1
		
		if(global.character_stats[# STATS.is_special_character, army_list[| selected_unit] ] == "0")
		{
			can_be_sacked = true
		}
		else
		{
			can_be_sacked = false
		}
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		
		if(i == ARMY_STATES.fire_unit && can_be_sacked || i != ARMY_STATES.fire_unit)
		{
			draw_set_colour(c_gray)
			if(i == selected_option)
			{
				draw_set_colour(c_white)
			}
		}
		else
		{
			draw_set_colour(c_black)
			if(i == selected_option)
			{
				draw_set_colour(c_dkgray)
			}
		}
		
		draw_set_font(fnt_options)
		
		draw_text(20, start_y + ( ( i - 2 ) * 24), text)
	}
	
	#endregion	
}

if(state == ARMY_STATES.change_class)
{
	#region CHANGE CLASS

	class_counter = 1
	draw_scale = 2
	var start_x = (display_get_gui_width() / 2) - (sprite_get_width(spr_iso_actor_idle_e) * draw_scale * 3 * 2)
	var start_y = (display_get_gui_height() / 2) - (sprite_get_height(spr_iso_actor_idle_e) * draw_scale)
	
	for(var yy = 0; yy < 2; yy++) // two rows in army screen
	{
		for( var xx = 0; xx < 6; xx++) // six to display in each row
		{
			var draw_x = start_x + ( xx * (sprite_get_width(spr_iso_actor_idle_e) * draw_scale * 2) )
			var draw_y = start_y + ( yy * (sprite_get_height(spr_iso_actor_idle_e) * draw_scale * 2) )
			
			army_screen_draw_unit(class_counter, draw_x, draw_y, draw_scale, FACING.east, true)
			
			if(class_counter == selected_option)
			{
				draw_sprite_ext(spr_army_selection, 0, draw_x, draw_y, draw_scale, draw_scale, 0, c_white, 1)
			}
			
			class_counter++
		}
	}
	
	#endregion
}

#region DISPLAY STATS

if(state == ARMY_STATES.display_options || state == ARMY_STATES.change_equipment)
{
	#region DISPLAY GEAR
	
	var item_width = sprite_get_width(spr_item_icons)
	var item_height = sprite_get_height(spr_item_icons)
	
	var unit_class = global.character_stats[# STATS.class, army_list[| selected_unit] ]
	
	var start_x = ( display_get_gui_width() / 2) - ( ( item_width * 4.5 ) / 2 )    //lots of weird number here not sure why they are chosen
	var start_y = (sprite_get_height(spr_iso_actor_idle_e) * 3) + (item_height * 2) //lots of weird number here not sure why they are chosen
	
	var counter = 0
	for(var i = STATS.left_hand; i <= STATS.item_2; i++)
	{
		var equipped_item = real(global.character_stats[# i, army_list[| selected_unit] ])
		
		var draw_x = start_x + (counter * item_width)
		var draw_y = start_y
		
		draw_sprite(spr_item_bg, 0, draw_x, draw_y)
		
		draw_sprite(spr_item_icons, equipped_item, draw_x, draw_y)
		draw_set_colour(c_black)
		draw_text(draw_x,draw_y, string(equipped_item) )
		
		if(state == ARMY_STATES.change_equipment)
		{
			if( abs (device_mouse_x_to_gui(0) - draw_x) < (item_width / 2) && abs( device_mouse_y_to_gui(0) - draw_y) < (item_height / 2) )
			{
				draw_set_alpha(0.5)
				draw_set_colour(c_lime)
				draw_rectangle(draw_x - (item_width/2), draw_y - (item_height/2), draw_x + (item_width/2), draw_y + (item_height/2), false)
				draw_set_alpha(1)
				
				if(mouse_check_button_pressed(mb_left) )
				{
					show_debug_message("UNIT_CLASS: " + string(unit_class))
					ds_list_clear(gear_list)
					show_gear_list = true
					gear_goes_here = i
					slot_to_equip = global.gear_goes_where[i]
					
					#region ADD ITEMS TO GEAR_LIST
					
					//ADDING AN EMPTY SLOT SO THAT ITEMS CAN BE REMOVED EASILY
					ds_list_add(gear_list, ITEMS.empty)
					
					for(var j = ITEMS.dagger; j < ITEMS.last; j++) //DAGGER IS FIRST VALID ITEM
					{
						var quantity = global.inventory[| j]
						var equips_where = global.items[# j, ITEM_STATS.equip_where]
						
						if(quantity > 0 && equips_where == slot_to_equip && global.items[# j, unit_class] == "1")
						{
							ds_list_add(gear_list, j)
						}
					}
					
					#endregion
					
					if(ds_list_size(gear_list) == 0)
					{
						show_gear_list = false
					}
				}
			}
		}
		
		counter++
		
	}
	
	
	
	#endregion
	
	#region DISPLAY GEAR LIST
	
	var item_width = sprite_get_width(spr_item_icons)
	var item_height = sprite_get_height(spr_item_icons)
	
	if(state == ARMY_STATES.change_equipment && show_gear_list)
	{
		var start_x = ( display_get_gui_width() / 2 ) - ( ( item_width * 4.5 ) / 2 )
		var start_y = (sprite_get_height(spr_iso_actor_idle_e) * 3) + (item_height * 4)
		
		for(var i = 0; i < ds_list_size(gear_list); i++)
		{
			var draw_x = start_x + (i * item_width)
			var draw_y = start_y
			
			draw_sprite(spr_item_bg, 0, draw_x, draw_y)
			
			draw_sprite(spr_item_icons, gear_list[| i], draw_x, draw_y)
			
			if( abs (device_mouse_x_to_gui(0) - draw_x) < (item_width / 2) && abs (device_mouse_y_to_gui(0) - draw_y) < (item_height / 2) )
			{
				draw_set_alpha(0.5)
				draw_set_colour(c_lime)
				draw_rectangle(draw_x - (item_width/2), draw_y - (item_height/2), draw_x + (item_width/2), draw_y + (item_height/2), false)
				draw_set_alpha(1)
				
				if(mouse_check_button_pressed(mb_left) )
				{
					
					var current_item_in_slot = real(global.character_stats[# gear_goes_here, army_list[| selected_unit] ] )
					var new_item_to_place = gear_list[| i]
					
					if(current_item_in_slot != ITEMS.empty)
					{
						global.inventory[| current_item_in_slot] ++
						
						//ADD ITEM TO GEAR LIST
						if(ds_list_find_index(gear_list, current_item_in_slot) == -1)
						{
							ds_list_add(gear_list, current_item_in_slot)
							
							ds_list_sort(gear_list, true)
						}
					}
					
					global.character_stats[# gear_goes_here, army_list[| selected_unit] ] = new_item_to_place
					
					global.inventory[| new_item_to_place]-- //this might need a check before it
					
					if(global.inventory[| new_item_to_place] == 0)
					{
						ds_list_delete(gear_list, i)
					}
				}
			}
		}
	}
	
	#endregion
	
	var unit = army_list[| selected_unit]
	
	for(var i = 0; i < ds_list_size(stats_to_display); i++)
	{
		var stat_value = global.character_stats[# stats_to_display[| i], unit]
		
		if(stats_to_display[| i] == STATS.class)
		{
			var class = global.character_stats[# STATS.class, unit]
			stat_value = global.character_stats[# STATS.name, class]
		}
		
		var stat_text = stats_text_grid[# 0, stats_to_display[| i]]
		
		draw_set_halign(fa_right)
		draw_set_valign(fa_top)
		draw_set_font(fnt_editor)
		draw_set_colour(c_orange)
		
		draw_text(display_get_gui_width() - 100, i * 14, stat_text + ": ")
		
		draw_set_halign(fa_left)
		draw_set_colour(c_red)
		draw_text(display_get_gui_width() - 100, i * 14, stat_value)
	}
	
}

#endregion