for(i = 0; i< array_length(UIlayerarray); i++)
{
	layer_set_visible(UIlayerarray[i],false)
}

if(room == MainMenu)
{
	layer_set_visible("MainMenuLayer",true)
	currentlayer = "MainMenuLayer"
}
else
{
	layer_set_visible("GameLayer",true)
	currentlayer = "GameLayer"
}

