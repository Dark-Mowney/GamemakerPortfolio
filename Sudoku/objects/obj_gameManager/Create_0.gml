difficulty = "none"

loadedGame = false
loadedGrid = ""

if (file_exists("sudoku_save.sav"))
{
    var buffer = buffer_load("sudoku_save.sav")
    var json = buffer_read(buffer, buffer_string)
    buffer_delete(buffer)

    var data = json_parse(json)
    loadedGrid = data.board
	
	show_debug_message("FILE EXISTS")
}

