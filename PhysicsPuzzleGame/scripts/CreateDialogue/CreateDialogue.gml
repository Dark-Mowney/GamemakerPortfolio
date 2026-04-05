function CreateDialogue(messages){
	if(instance_exists(obj_dialogue)) return;
	
	var inst = instance_create_depth(0,0,0,obj_dialogue)
	inst.messages = messages
	inst.current_message = 0
}