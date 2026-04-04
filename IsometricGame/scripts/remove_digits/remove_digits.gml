//THIS SCRIPT JUST DELETES THE FIRST CHARACTER OF A STRING ONLY IF IT IS A DIGIT!!!
function remove_digits(text)
{
	for(var i = 1; i < string_length(text); i++)
	{
		var char = string_char_at(text, 1)
		
		if(string_digits(char) != "")
		{
			text = string_delete(text, 1, 1)
		}
		else
		{
			break;
		}
	}
}