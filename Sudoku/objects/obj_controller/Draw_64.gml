var cam = view_camera[0]

var cx = camera_get_view_x(cam) + camera_get_view_width(cam) / 2
var cy = camera_get_view_y(cam) + camera_get_view_height(cam) / 5

draw_set_colour(c_black)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(f_boxText)

draw_text(cx, cy, "Current number selected: " + string(clickValue))
draw_text(cx, cy - 50, "Mistakes made: " + string(numMistakes))

with(obj_boardManager)
{
	if(!win)
	{
		draw_text(cx, cy - 100, difficulty)
	}
	else
	{
		draw_text(cx, cy - 150, winText)
	}
}