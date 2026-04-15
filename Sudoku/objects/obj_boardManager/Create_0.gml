randomise()

boxGrid = ds_grid_create(9,9)
difficulty = "none"

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

#region FUNCTIONS

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
	
	var rowMin = (row div 3) * 3;
	var colMin = (col div 3) * 3;
	
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
    if (row == 9)
	{
		return true
	}

    var next_row = row
    var next_col = col + 1

    if (next_col == 9) 
	{
        next_col = 0
        next_row++
    }

    var nums = [1,2,3,4,5,6,7,8,9]
    nums = array_shuffle(nums)

    for (var i = 0; i < 9; i++)
    {
        var num = nums[i]

        if (is_valid(grid, row, col, num))
        {
            var box = ds_grid_get(grid, col, row)
            box.boxNum = num

            if (make_solution(grid, next_row, next_col)) 
			{
                return true
            }
        }
    }

    var box = ds_grid_get(grid, col, row)
    box.boxNum = 0

    return false
}

function make_puzzle(grid)
{
    var cells = []

    for (var r = 0; r < 9; r++) 
    {
        for (var c = 0; c < 9; c++) 
        {
            array_push(cells, [r, c])
        }
    }

    cells = array_shuffle(cells)

    for (var i = 0; i < array_length(cells); i++) 
    {
        var r = cells[i][0]
        var c = cells[i][1]

        var box = grid[# c, r]
		
        var old_show = box.showNumber

        box.showNumber = false

		var test_grid = copy_grid(grid)
		var solutions = count_solutions_mrv(test_grid)
		ds_grid_destroy(test_grid)

        if (solutions != 1) {
            box.showNumber = old_show
        }
    }
}

function count_solutions(grid, row, col) //DEPRECIATED USE MRV NOW ***KEEP UNTIL MRV CONFIRMED TO BE BETTER
{
    if (row == 9)
	{
		return 1
	}

    var next_row = row
    var next_col = col + 1

    if (next_col == 9) 
	{
        next_col = 0
        next_row++
    }

    var box = grid[# col, row]

    
    if (box.showNumber) 
	{
        return count_solutions(grid, next_row, next_col)
    }

    var total = 0;
	
	var correct = boxGrid[# col, row].boxNum

	var nums = [1,2,3,4,5,6,7,8,9]
	nums = array_shuffle(nums)

	for (var i = 0; i < 9; i++) 
	{
		if (nums[i] == correct) 
		{
        var temp = nums[8]
        nums[8] = nums[i]
        nums[i] = temp
        break;
		}
	}

   for (var i = 0; i < 9; i++)
	{
		var num = nums[i]

		if (is_valid(grid, row, col, num))
		{
			box.boxNum = num
			
			total += count_solutions(grid, next_row, next_col)
			
			if (total >= 2) 
			{
			    box.boxNum = 0
			    return total
			}
		}
	}

    box.boxNum = 0

    return total
}

function count_solutions_mrv(grid)
{
    var cell = find_mrv_cell(grid)

    var row = cell[0]
    var col = cell[1]
    var options = cell[2]

    if (row == -1) 
	{
		return 1
	}

    if (options == 0) 
	{
		return 0
	}

    var total = 0

    var nums = [1,2,3,4,5,6,7,8,9]
    nums = array_shuffle(nums)

    for (var i = 0; i < 9; i++)
    {
        var num = nums[i]

        if (is_valid(grid, row, col, num))
        {
            var box = grid[# col, row]
            box.boxNum = num

            total += count_solutions_mrv(grid)

            if (total >= 2)
            {
                box.boxNum = 0
                return total
            }

            box.boxNum = 0;
        }
    }

    return total;
}

function copy_grid(original)
{
    var new_grid = ds_grid_create(9, 9)

    for (var r = 0; r < 9; r++)
    {
        for (var c = 0; c < 9; c++)
        {
            var old = original[# c, r]

            var new_box = 
			{
                boxNum: old.boxNum,
                showNumber: old.showNumber
            }

            if (!old.showNumber)  
			{
                new_box.boxNum = 0
            }

            new_grid[# c, r] = new_box
        }
    }

    return new_grid
}

function find_mrv_cell(grid)
{
    var best_row = -1
    var best_col = -1
    var best_count = 10

    for (var r = 0; r < 9; r++)
    {
        for (var c = 0; c < 9; c++)
        {
            var box = grid[# c, r]

            if (box.boxNum != 0)
			{
				continue;
			}

            var count = 0

            for (var num = 1; num <= 9; num++)
            {
                if (is_valid(grid, r, c, num))
                {
                    count++
                }
            }

            if (count == 0)
            {
                return [r, c, 0]
            }

            if (count < best_count)
            {
                best_count = count
                best_row = r
                best_col = c

                if (best_count == 1) 
				{
					break;
				}
            }
        }
    }

    return [best_row, best_col, best_count]
}

#endregion

make_solution(boxGrid,0,0)
make_puzzle(boxGrid)