/// @description Size variables and mode setup
width = display_get_gui_width();
height = display_get_gui_height();
height_half = height * 0.5;
width_half = width * 0.5;
enum TRANS_MODE
{
	OFF,
	NEXT,
	GOTO,
	RESTART,
	INTRO
}
mode = TRANS_MODE.INTRO;
percent = 1;
target = room;