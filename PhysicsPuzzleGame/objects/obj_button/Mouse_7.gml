if disabled exit;

switch(button_id)
{
	case BUTTON_FUNC.PLAY:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"GameModeSelectLayer")
	break;
	
	case BUTTON_FUNC.CHALLENGES:
		//TO DO
	break;
	
	case BUTTON_FUNC.TIMETRIALS:
		//TO DO
	break;
	
	case BUTTON_FUNC.RESUME:
		obj_UImanager.paused = false
		obj_UImanager.update_pause()
	break;
	
	case BUTTON_FUNC.PAUSE:
		obj_UImanager.paused = true
		obj_UImanager.update_pause()
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"PauseLayer")
	break;
		
	case BUTTON_FUNC.SETTINGS:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"SettingsLayer")
	break;
	
	case BUTTON_FUNC.CREDITS:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"CreditsLayer")
	break;
		
	case BUTTON_FUNC.QUIT:
		game_end()
	break;
		
	case BUTTON_FUNC.BACK:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,backlayer)
	break;
	
	case BUTTON_FUNC.LEVELSELECT:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"LevelSelectLayer")
	break;
	
	case BUTTON_FUNC.MAINMENU:
		room_goto(MainMenu);
		//SlideTransition(TRANS_MODE.GOTO,LVL_1)
	break;
	
	case BUTTON_FUNC.VOLUMEUP:
		with(obj_gamemanager)
		{
			masteraudiogain += .1
			masteraudiogain = clamp(masteraudiogain, 0, 1)

			audio_master_gain(masteraudiogain)
		}
	break;
		
	case BUTTON_FUNC.VOLUMEDOWN:
		with(obj_gamemanager)
		{
			masteraudiogain -= .1
			masteraudiogain = clamp(masteraudiogain, 0, 1)

			audio_master_gain(masteraudiogain)
		}
	break;
	
	case BUTTON_FUNC.NOTES:
		obj_UImanager.swap_layers(obj_UImanager.currentlayer,"NotesLayer")
	break;
	
	case BUTTON_FUNC.LVL1:
		SlideTransition(TRANS_MODE.GOTO,LVL_001)
	break;
		
	case BUTTON_FUNC.LVL2:
		SlideTransition(TRANS_MODE.GOTO,LVL_002)
	break;
		
	case BUTTON_FUNC.LVL3:
		SlideTransition(TRANS_MODE.GOTO,LVL_003)
	break;
		
	case BUTTON_FUNC.LVL4:
		SlideTransition(TRANS_MODE.GOTO,LVL_004)
	break;
		
	case BUTTON_FUNC.LVL5:
		SlideTransition(TRANS_MODE.GOTO,LVL_005)
	break;
		
	case BUTTON_FUNC.LVL6:
		SlideTransition(TRANS_MODE.GOTO,LVL_006)
	break;
		
	case BUTTON_FUNC.LVL7:
		SlideTransition(TRANS_MODE.GOTO,LVL_007_B)
	break;

	case BUTTON_FUNC.LVL8:
		SlideTransition(TRANS_MODE.GOTO,LVL_008_B)
	break;
		
	case BUTTON_FUNC.LVL9:
		SlideTransition(TRANS_MODE.GOTO,LVL_009_B)
	break;
		
	case BUTTON_FUNC.LVL10:
		SlideTransition(TRANS_MODE.GOTO,LVL_010_BB)
	break;
		
	case BUTTON_FUNC.LVL11:
		SlideTransition(TRANS_MODE.GOTO,LVL_011_BB)
	break;
		
	case BUTTON_FUNC.LVL12:
		SlideTransition(TRANS_MODE.GOTO,LVL_012_BB)
	break;
		
	case BUTTON_FUNC.LVL13:
		SlideTransition(TRANS_MODE.GOTO,LVL_013_B)
	break;
		
	case BUTTON_FUNC.LVL14:
		SlideTransition(TRANS_MODE.GOTO,LVL_014_B)
	break;
		
	case BUTTON_FUNC.LVL15:
		SlideTransition(TRANS_MODE.GOTO,LVL_015)
	break;
		
	case BUTTON_FUNC.LVL16:
		SlideTransition(TRANS_MODE.GOTO,LVL_016_BB)
	break;
		
	case BUTTON_FUNC.LVL17:
		SlideTransition(TRANS_MODE.GOTO,LVL_017)
	break;
	
	case BUTTON_FUNC.LVL18:
		SlideTransition(TRANS_MODE.GOTO,LVL_018)
	break;
		
	case BUTTON_FUNC.LVL19:
		SlideTransition(TRANS_MODE.GOTO,LVL_019)
	break;
		
	case BUTTON_FUNC.LVL20:
		SlideTransition(TRANS_MODE.GOTO,LVL_020)
	break;
		
}
