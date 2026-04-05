if(instance_number(obj_gamemanager) > 1)
{
	instance_destroy()
}

randomise()

pink = #FFAAFF
green = #B2FFA3
lightblue = #94F6FF
blue = #7FB0FF
thistle = #E0BBE4
lavenderpurple = #957DAD
pastelviolet = #D291BC
cottancandy = #FEC8D8
lumber = #FFDFD3 
mintfrost = #9BF6FF
pastelgreen = #CAFFBF
peach = #FFD6A5
lightcoral = #FFADAD



backgroundcolor = choose(pink,green,lightblue,blue,thistle,lavenderpurple,pastelviolet,cottancandy
,lumber,mintfrost,pastelgreen,peach,lightcoral)

roomcolor = 0

switch(backgroundcolor)
{
	case pink:
		roomcolor = lightblue
	break;
	
	case green:
		roomcolor = pastelviolet
	break;
	
	case lightblue:
		roomcolor = cottancandy
	break;
	
	case blue:
		roomcolor = peach
	break;
	
	case thistle:
		roomcolor = lavenderpurple
	break;
	
	case lavenderpurple:
		roomcolor = thistle
	break;
	
	case pastelviolet:
		roomcolor = green;
	break;
	
	case cottancandy:
		roomcolor = lightblue
	break;
	
	case lumber:
		roomcolor = mintfrost
	break;
	
	case mintfrost:
		roomcolor = lumber
	break;
	
	case pastelgreen:
		roomcolor = lightcoral
	break;
	
	case peach:
		roomcolor = blue
	break;
	
	case lightcoral:
		roomcolor = pastelgreen
	break;
	
}
var layer_id = layer_get_id("Background")
var back_id = layer_background_get_id(layer_id);
layer_background_blend(back_id,backgroundcolor)

numtargets = 0
targetsleft = 0
ballsleft = 3

masteraudiogain = .5
targetpitch = .5

audio_master_gain(masteraudiogain)
audio_play_sound(Snd_Intro,0,true)

timeelapsed = 0

time_source = time_source_create(time_source_game, 1, time_source_units_seconds, function()
{
	timeelapsed += 1
},[],-1)

unlockedbuttons = [BUTTON_FUNC.LVL1,
BUTTON_FUNC.PLAY,
BUTTON_FUNC.CREDITS,
BUTTON_FUNC.BACK,
BUTTON_FUNC.LEVELSELECT,
BUTTON_FUNC.QUIT,
BUTTON_FUNC.MAINMENU,
BUTTON_FUNC.RESUME,
BUTTON_FUNC.PAUSE,
BUTTON_FUNC.SETTINGS,
BUTTON_FUNC.VOLUMEDOWN,
BUTTON_FUNC.VOLUMEUP,
BUTTON_FUNC.NOTES]

buttonarray = []

function unlockbutton(arraylength,button_obj_id,button_func)
{
	for(var i = 0; i < arraylength; i++)
	{
		if(button_func == unlockedbuttons[i])
		{
			button_obj_id.disabled = false
			button_obj_id.image_alpha = 1
			exit;
		}
	}
	button_obj_id.disabled = true
}