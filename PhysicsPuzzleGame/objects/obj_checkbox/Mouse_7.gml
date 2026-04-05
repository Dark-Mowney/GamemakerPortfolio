enabled = !enabled

image_alpha = .4 + enabled * .6

if(enabled)
{
	switch(checkbox_id)
	{
		case CHECKBOX_FUNC.ENABLESOUND:
		audio_master_gain(1)
		break;
		
	}
}

if(!enabled)
{
	switch(checkbox_id)
	{
		case CHECKBOX_FUNC.ENABLESOUND:
		audio_master_gain(0)
		break;	
	}
}