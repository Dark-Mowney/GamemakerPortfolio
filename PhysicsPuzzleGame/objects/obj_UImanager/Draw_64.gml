if(room == MainMenu) exit;
if(obj_gamemanager)
{
	draw_set_colour(obj_gamemanager.backgroundcolor)
	draw_set_font(fnt_ui)
	draw_set_alpha(1)
	draw_text(850,15,room_get_name(room))
}