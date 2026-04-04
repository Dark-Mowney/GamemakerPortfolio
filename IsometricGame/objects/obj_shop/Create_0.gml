enum SHOP_STATES
{
	display_buy_sell,
	display_items_units,
	buy,
	sell,
	items,
	units
}

state = SHOP_STATES.display_buy_sell
selected_option = SHOP_STATES.buy

text[SHOP_STATES.buy] = "BUY"
text[SHOP_STATES.sell] = "SELL"
text[SHOP_STATES.items] = "ITEMS"
text[SHOP_STATES.units] = "UNITS"

list_of_units = ds_list_create()
list_of_items = ds_list_create()
list_of_inventory = ds_list_create()

ds_list_add(list_of_units, CHARACTERS.fighter, CHARACTERS.archer)
ds_list_add(list_of_items, ITEMS.axe, ITEMS.short_bow, ITEMS.leather_chest)