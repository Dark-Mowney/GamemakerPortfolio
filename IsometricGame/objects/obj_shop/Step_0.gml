#region CHANGE SELECTED OPTION

if( state == SHOP_STATES.display_buy_sell)
{
	if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
	{
		selected_option = change_option(selected_option, SHOP_STATES.buy, SHOP_STATES.sell)
	}
}

if( state == SHOP_STATES.display_items_units)
{
	if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down))
	{
		selected_option = change_option(selected_option, SHOP_STATES.items, SHOP_STATES.units)
	}
}

if(state == SHOP_STATES.items)
{
	if( keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right))
	{
		selected_option = change_option(selected_option, 0, ds_list_size(list_of_items) - 1)
	}
}

if(state == SHOP_STATES.units)
{
	if(keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) )
	{
		selected_option = change_option(selected_option, 0, ds_list_size(list_of_units) - 1)
	}
}

if(state == SHOP_STATES.sell)
{
	if(keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) )
	{
		selected_option = change_option(selected_option, 0, ds_list_size(list_of_inventory) - 1)
		selected_option = clamp(selected_option, 0, ds_list_size(global.inventory) - 1)
	}
}

#endregion

#region CHOOSE AN OPTION

if(keyboard_check_pressed(vk_enter))
{
	if(state == SHOP_STATES.display_items_units)
	{
		state = selected_option
		selected_option = 0
	}
	else
	{
		if(state == SHOP_STATES.items)
		{
			var item = list_of_items[| selected_option]
			global.inventory[| item] ++
		}
		else
		{
			if(state == SHOP_STATES.units)
			{
				var unit = list_of_units[| selected_option]
				var entry = create_unit(unit, 1, global.character_stats)
				global.character_stats[# STATS.on_players_team, entry] = 1
			}
		}
	}
	
	if(state == SHOP_STATES.display_buy_sell)
	{
		#region DISPLAY BUY/SELL
		
		if(selected_option == SHOP_STATES.buy)
		{
			state = SHOP_STATES.display_items_units
			selected_option = SHOP_STATES.items
		}
		else
		{
			state = SHOP_STATES.sell
			selected_option = 0
			ds_list_clear(list_of_inventory)
			
			for(var i = 1; i < ds_list_size(global.inventory); i++)
			{
				if(global.inventory[| i] > 0)
				{
					ds_list_add(list_of_inventory, i)
				}
			}
		}
		
		#endregion
	}
	else
	{
		if(state == SHOP_STATES.sell)
		{
			#region SELL
			
			if(ds_list_size(list_of_inventory > 0))
			{
				var item = list_of_inventory[| selected_option]
				
				global.inventory[| item]--
				
				if(global.inventory[| item] <= 0)
				{
					ds_list_delete(list_of_inventory, selected_option)
					
					selected_option = clamp(selected_option, 0, ds_list_size(list_of_inventory) - 1)
				}
			}
			
			#endregion
		}
	}
}

#endregion

#region GO BACK TO DISPLAY OPTIONS OR EXIT SHOP

if(keyboard_check_pressed(vk_backspace))
{
	if(state == SHOP_STATES.items || state == SHOP_STATES.units)
	{
		state = SHOP_STATES.display_items_units
		selected_option = SHOP_STATES.items
	}
	else
	{
		if(state = SHOP_STATES.sell || state == SHOP_STATES.display_items_units)
		{
			state = SHOP_STATES.display_buy_sell
			selected_option = SHOP_STATES.buy
		}
		else
		{
			obj_player.state = PLAYER_STATES.world_menu
			instance_destroy()
		}
	}
}

#endregion