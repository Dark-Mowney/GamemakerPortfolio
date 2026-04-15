draw_self()
if(showNumber)
{
	draw_set_colour(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_font(f_boxText)
	draw_text(x,y, string(boxNum))
}


///Debug column and rows
draw_set_font(f_boxText_small)
//draw_text(x-14,y-14, "col" + string(col))
//draw_text(x-14,y-24, "row" + string(row))
//draw_text(x-14,y-34, "num" + string(boxNum))