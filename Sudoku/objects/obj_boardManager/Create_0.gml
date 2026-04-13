randomise()

boxGrid = ds_grid_create(9,9)

// Board size
var grid_size = 9;
var cell_size = sprite_get_width(spr_box)

// Center of the board
var start_x = x - ((grid_size * cell_size) / 2) + (cell_size/2)
var start_y = y - ((grid_size * cell_size) / 2) + (cell_size/2)

// Creating boxes and adding them to ds_grid
for (var row = 0; row < grid_size; row++)
{
    for (var col = 0; col < grid_size; col++)
    {
        // Position relative to center
        var relative_x = (col * cell_size) + start_x
        var relative_y = (row * cell_size) + start_y
		
		var box = instance_create_layer(relative_x, relative_y,"Instances", obj_box)
		box.row = row
		box.col = col
		
		ds_grid_add(boxGrid, col, row, box)
    }
}

function is_valid(grid, row, col, num) 
{
    // Check row
    for (var i = 0; i < 9; i++) 
	{
		if(i==col)
		{
			continue;
		}
        else if(grid[# i, row].boxNum == num)
		{
			return false
		}
    }

	// Check column
	for (var i = 0; i < 9; i++) 
	{
		if(i==row)
		{
			//skip
		}
		else if (grid[# col, i].boxNum == num)
		{
			return false
		}
	}

    // Check 3x3 box
	var rowMin = -1
	var colMin = -1
	
	if(row == 0 || row == 1 || row == 2)
	{
		rowMin = 0
	}
	else if (row == 3 || row == 4 || row == 5)
	{
		rowMin = 3
	}
	else if (row == 6 || row == 7 || row == 8)
	{
		rowMin = 6
	}
	
	if(col == 0 || col == 1 || col == 2)
	{
		colMin = 0
	}
	else if (col == 3 || col == 4 || col == 5)
	{
		colMin = 3
	}
	else if (col == 6 || col == 7 || col == 8)
	{
		colMin = 6
	}
	for(var c = 0; c < 3; c++)
	{
		for(var r = 0; r < 3; r++)
		{
			var box = ds_grid_get(grid, colMin + c, rowMin + r)
			if(box.boxNum == num)
			{
				return false
			}
		}
	}


    return true;
}

function make_solution(grid, row, col)
{
    if (row == 9) return true;

    var next_row = row;
    var next_col = col + 1;

    if (next_col == 9) {
        next_col = 0;
        next_row++;
    }

    var nums = [1,2,3,4,5,6,7,8,9];
    nums = array_shuffle(nums);

    for (var i = 0; i < 9; i++)
    {
        var num = nums[i];

        if (is_valid(grid, row, col, num))
        {
            var box = ds_grid_get(grid, col, row);
            box.boxNum = num;

            if (make_solution(grid, next_row, next_col)) {
                return true;
            }
        }
    }

    var box = ds_grid_get(grid, col, row);
    box.boxNum = 0;

    return false;
}

make_solution(boxGrid,0,0)

function make_puzzle(grid)
{
	var cells = [];

	for (var r = 0; r < 9; r++) 
	{
		for (var c = 0; c < 9; c++) 
		{
			array_push(cells, [r, c]);
		}
	}
	
	cells = array_shuffle(cells);
	
	var remove_count = 40;

	for (var i = 0; i < remove_count; i++) 
	{
		var r = cells[i][0]
		var c = cells[i][1]
		
		grid[# c, r].showNumber = false
	}
}

make_puzzle(boxGrid)