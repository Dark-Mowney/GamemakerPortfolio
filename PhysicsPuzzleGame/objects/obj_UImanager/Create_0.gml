enum BUTTON_FUNC
{
	PLAY,
	TIMETRIALS,
	CHALLENGES,
	RESUME,
	PAUSE,
	SETTINGS,
	CREDITS,
	QUIT,
	MAINMENU,
	BACK,
	LEVELSELECT,
	VOLUMEUP,
	VOLUMEDOWN,
	NOTES,
	LVL1,
	LVL2,
	LVL3,
	LVL4,
	LVL5,
	LVL6,
	LVL7,
	LVL8,
	LVL9,
	LVL10,
	LVL11,
	LVL12,
	LVL13,
	LVL14,
	LVL15,
	LVL16,
	LVL17,
	LVL18,
	LVL19,
	LVL20
}

enum CHECKBOX_FUNC
{
	UNKNOWN,
	ENABLESOUND
}

paused = false;
backlayer = ""
currentlayer = ""
UIlayerarray = [
"PauseLayer",
"SettingsLayer",
"MainMenuLayer",
"LevelSelectLayer",
"GameLayer",
"CreditsLayer",
"NotesLayer",
"GameModeSelectLayer"
]

update_pause = function()
{
	if(paused)
	{
		instance_deactivate_all(true)
		instance_activate_object(obj_gamemanager)
		layer_set_visible("PauseLayer", true)
		currentlayer = "PauseLayer"
	}
	else
	{
		instance_activate_all()
		layer_set_visible("PauseLayer", false)
		layer_set_visible("SettingsLayer", false)
		backlayer = ""
		currentlayer = ""
	}
}

swap_layers = function(original_layer,new_layer)
{
	layer_set_visible(original_layer, false)
	layer_set_visible(new_layer,true)
	backlayer = original_layer
	currentlayer = new_layer
}