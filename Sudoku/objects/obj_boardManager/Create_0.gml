randomise()

boxGrid = ds_grid_create(9,9)
difficulty = obj_gameManager.difficulty
iterations = 0
win = false
winText = "YOU WON!!!"

savedjson = 0

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

/// @desc Checks whether a given number can be placed at a specific position in a Sudoku grid.
/// @param grid The ds_grid containing Sudoku cell structs (each with a boxNum variable)
/// @param row The row index (0–8)
/// @param col The column index (0–8)
/// @param num The number to validate (1–9)
/// @returns True if the number can be placed at (row, col), false otherwise
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

/// @desc Recursively fills a Sudoku grid with a valid complete solution using backtracking.
/// @param grid The ds_grid containing Sudoku cell structs (each with a boxNum variable)
/// @param row The current row index (0–8)
/// @param col The current column index (0–8)
/// @returns True if a valid solution was generated, false if no solution is possible
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

/// @desc Removes numbers from a completed Sudoku grid to create a playable puzzle, ensuring the puzzle has a unique solution.
/// @param grid The ds_grid containing Sudoku cell structs
/// @returns Nothing (modifies the grid in-place)
function make_puzzle(grid)
{
	var target_removals;

    switch (difficulty)
    {
        case "Easy":   target_removals = irandom_range(30, 40); break;
        case "Medium": target_removals = irandom_range(41, 50); break;
        case "Hard":   target_removals = irandom_range(51, 60); break;
        case "none":   target_removals = irandom_range(30, 40); break;
    }

    var removed = 0;
	
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
        if (removed >= target_removals) break;

        var r = cells[i][0];
        var c = cells[i][1];

        var box = grid[# c, r];
        var old_show = box.showNumber;

        box.showNumber = false;

        var test_grid = copy_grid(grid);
        var solutions = count_solutions_mrv(test_grid);
        ds_grid_destroy(test_grid);

        if (solutions == 1) {
            removed++;
        } else {
            box.showNumber = old_show;
        }
    }
}

/// @desc Counts the number of valid solutions for a Sudoku grid using backtracking. Stops early if more than one solution is found (useful for uniqueness checks).
/// @param grid The ds_grid containing Sudoku cell structs (boxNum, showNumber)
/// @param row The current row index (0–8)
/// @param col The current column index (0–8)
/// @returns The number of solutions found (0, 1, or 2+)
/// @note DEPRECATED: replaced by count_solutions_mrv() for better performance
function count_solutions(grid, row, col)
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

/// @desc Counts the number of valid Sudoku solutions using a Minimum Remaining Values (MRV) heuristic. Selects the cell with the fewest valid candidates to improve performance. Stops early if more than one solution is found.
/// @param grid The ds_grid containing Sudoku cell structs (boxNum, showNumber)
/// @returns The number of solutions (0, 1, or 2+)
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

/// @desc Creates a deep copy of a Sudoku grid for solving purposes. Hidden cells are cleared (boxNum = 0) so the solver treats them as empty.
/// @param original The source ds_grid containing cell structs (boxNum, showNumber)
/// @returns A new ds_grid with independent cell structs
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


/// @desc Finds the empty cell with the fewest valid candidate numbers (MRV heuristic). Used to optimize backtracking by selecting the most constrained cell first.
/// @param grid The ds_grid containing Sudoku cell structs (boxNum, showNumber)
/// @returns An array [row, col, count]:
///          - row, col: position of the selected cell
///          - count: number of valid candidates
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

function save_puzzle(grid)
{
	var data = [];
	
	#region SAVE BOARD
	var w = ds_grid_width(grid);
	var h = ds_grid_height(grid);
	
	for (var i = 0; i < w; i++)
	{
	    for (var j = 0; j < h; j++)
	    {
	        var box = grid[# i, j];
	
	        array_push(data, {
	            boxNum: box.boxNum,
	            showNumber: box.showNumber,
				pencilNumbers: box.pencilNumbers
	        })
	    }
	}
	
	var json = json_stringify(data);
	
	var buffer = buffer_create(string_length(json) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, json);

	buffer_save(buffer, "gridsave.json");
	buffer_delete(buffer);
	#endregion
	
	#region SAVE GAME MANAGER
	data = [];
	var boardManager = instance_find(obj_boardManager, 0)
	array_push(data, {
		difficulty: boardManager.difficulty
	})
	json = json_stringify(data);
	
	buffer = buffer_create(string_length(json) + 1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, json);

	buffer_save(buffer, "boardmanagersave.json");
	buffer_delete(buffer);
	#endregion
	
	show_message("GAME SAVED")
}

function load_puzzle(grid)
{
	var gridbuffer = buffer_load("gridsave.json")
	var boardmanagerbuffer = buffer_load("boardmanagersave.json")
	
	if (gridbuffer != -1)
	{
		var json = buffer_read(gridbuffer, buffer_string)
		buffer_delete(gridbuffer)
		
		var data = json_parse(json)
		
		var w = ds_grid_width(grid)
		var h = ds_grid_height(grid)
		
		var index = 0;
		
		for (var i = 0; i < w; i++)
		{
		    for (var j = 0; j < h; j++)
		    {
		        var box = grid[# i, j]
		        var entry = data[index]
		
		        box.boxNum = entry.boxNum
		        box.showNumber = entry.showNumber
				box.pencilNumbers = entry.pencilNumbers
		
		        index++
		    }
		}
	}
	else
	{
	    show_message("Failed to load grid buffer on GX.games")
	}
	
	if(boardmanagerbuffer != -1)
	{
		var json = buffer_read(boardmanagerbuffer, buffer_string)
		buffer_delete(boardmanagerbuffer)
		
		var data = json_parse(json)
		var boardManager = instance_find(obj_boardManager, 0)
		boardManager.difficulty = data[0].difficulty ///index 0 because right now there is only one entry. I think I would turn this into an enum if I were to add more entries.
		
	}
	else
	{
	    show_message("Failed to load boardmanager buffer on GX.games")
	}
	
}

#endregion


make_solution(boxGrid,0,0)
make_puzzle(boxGrid)
if(obj_gameManager.loadedGame)
{
	show_debug_message("LOADING PUZZLE")
	if(load_puzzle(boxGrid))
	{
		show_debug_message(game_save_id)
	}
}
		

//debug message to show number of iterations through loops. just use iterations variable.
//show_debug_message("iterations: " + string(iterations))