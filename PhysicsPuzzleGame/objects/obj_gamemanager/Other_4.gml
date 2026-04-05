numtargets = instance_number(obj_target)
targetsleft = numtargets
targetpitch = .5
ballsleft = 3
var layer_id = layer_get_id("Background")
var back_id = layer_background_get_id(layer_id);
layer_background_blend(back_id,backgroundcolor)

for(var i = 0; i < array_length(buttonarray); i++)
{
	unlockbutton(array_length(unlockedbuttons),buttonarray[i], buttonarray[i].button_id)
}