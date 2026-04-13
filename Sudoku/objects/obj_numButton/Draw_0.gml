draw_self()
if(buttonValue > 0)
{
	draw_set_colour(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_font(f_boxText)
	draw_text(x,y, string(buttonValue))
}