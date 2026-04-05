/// @function change_option(current, min, max)
/// @description Return the new value of a variable after pressing up/down
/// @param {real} current - the current value of the variable we're changing
/// @param {real} min - the minimum value that this variable can be
/// @param {real} max - the maximum value that this variable can be

function change_option(current_value, min_value, max_value)
{
	if(keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right))
	{
		if(current_value < max_value)
		{
			current_value++
		}
		else
		{
			current_value = min_value
		}
	}
	
	if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left))
	{
		if(current_value > min_value)
		{
			current_value--
		}
		else
		{
			current_value = max_value
		}
	}
	
	return(current_value)
}