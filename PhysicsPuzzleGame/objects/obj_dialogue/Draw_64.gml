var tx = 0
var ty = gui_h *.7
var boxw = gui_w
var boxh = gui_h - ty

draw_sprite_stretched(spr_box, 0, tx, ty, boxw, boxh)

tx += 16
ty += 16

draw_set_font(font_arial)
draw_set_colour(c_black)

var name = messages[current_message].name
draw_text(tx,ty,name)

ty += 40

draw_text_ext(tx,ty,draw_message,-1,boxw - tx * 2)