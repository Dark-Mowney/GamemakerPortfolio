var str = ""

for (var i = 0; i < 9; i++)
{
    for (var j = 0; j < 9; j++)
    {
        str += string(boxGrid[# j, i])
    }
}

var json = json_stringify(str)

var buffer = buffer_create(1024, buffer_fixed, 1)
buffer_write(buffer, buffer_string, json)

buffer_save(buffer, "sudoku_save.sav")

buffer_delete(buffer)