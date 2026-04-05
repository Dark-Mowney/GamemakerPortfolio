if(sprite_index = spr_target_hit) exit;
sprite_index = spr_target_hit
with(obj_gamemanager)
{
	targetsleft--
	
	audio_play_sound(Snd_thump,1,false,masteraudiogain,.05,targetpitch)
	
	targetpitch += .1
	
	if(targetsleft <= 0)
	{
		SlideTransition(TRANS_MODE.NEXT)
	}
}