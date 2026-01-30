extends Node2D

var cell_scene = preload("res://scenes/cell.tscn")
var cells = []
var board_size = Vector2i(3,3)
@onready var win_line = $scripts/win_line

var turn = Globals.TurnState.TURN_X

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _ready():
	for x in range(board_size.x):
		cells.append([])
		for y in range(board_size.y):
			var cell = cell_scene.instantiate()
			add_child(cell)
			cells[x].append(cell)
			cell.global_position = Vector2(75 + x*100, 250 + y*100)
			cell.clicked.connect(_on_cell_clicked)
			
	%Board.global_position = Vector2(75 + 150, 250 + 150)
	
func _on_cell_clicked(cell):
	if cell.fill_state != Globals.FillState.FILL_NONE:
		return
		
	var fill_to_use
	if turn == Globals.TurnState.TURN_X:
		fill_to_use = Globals.FillState.FILL_X
	else:
		fill_to_use = Globals.FillState.FILL_O
		
	cell.fill(fill_to_use)
		
	if turn == Globals.TurnState.TURN_X:
		turn = Globals.TurnState.TURN_O
	else:
		turn = Globals.TurnState.TURN_X
		
	check_win()

func check_win():
	var win_state = true
	var first_cell_state = Globals.FillState.FILL_NONE
	
	# Win check (horizontal)
	for y in range(board_size.y):
		win_state = true
		for x in range(board_size.x):
			var cell = cells[x][y]
			if x == 0:
				if cell.fill_state ==  Globals.FillState.FILL_NONE:
					win_state = false
					break
				first_cell_state = cell.fill_state
			else:
				if cell.fill_state != first_cell_state:
					win_state = false
					break
		if win_state == true:
			for x in range(board_size.y):
				var cell = cells[x][y]
				cell.highlight(true)
			
			
	# Win check (vertical)
	for x in range(board_size.x):
		win_state = true
		for y in range(board_size.y):
			var cell = cells[x][y]
			if y == 0:
				if cell.fill_state ==  Globals.FillState.FILL_NONE:
					win_state = false
					break
				first_cell_state = cell.fill_state
			else:
				if cell.fill_state != first_cell_state:
					win_state = false
					break
		if win_state == true:
			for y in range(board_size.y):
				var cell = cells[x][y]
				cell.highlight(true)
			
			
	# Win check (cross)
	win_state = true
	for i in range(board_size.x):
		var cell = cells[i][i]
		if i == 0:
			if cell.fill_state == Globals.FillState.FILL_NONE:
				win_state = false
				break 
			first_cell_state = cell.fill_state
		else:
			if cell.fill_state != first_cell_state:
				win_state = false
				break
				
	if win_state == true:
		for i in range(board_size.x):
				var cell = cells[i][i]
				cell.highlight(true)
	else:
		# cross 2 win check
		win_state = true
		for i in range(board_size.x):
			var cell = cells[2-i][i]
			if i == 0:
				if cell.fill_state == Globals.FillState.FILL_NONE:
					win_state = false
					break 
				first_cell_state = cell.fill_state
			else:
				if cell.fill_state != first_cell_state:
					win_state = false
					break
		if win_state == true:
			for i in range(board_size.x):
				var cell = cells[2-i][i]
				cell.highlight(true)
	# Draw check
	if win_state == false:
		var is_draw = true
		for x in range(board_size.x):
			for y in range(board_size.y):
				var cell = cells[x][y]
				if cell.fill_state == Globals.FillState.FILL_NONE:
					is_draw = false
					break
			if is_draw == false:
				break
		if is_draw == true:
			for y in range(board_size.y):
				for x in range(board_size.x):
					cells[y][x].highlight(true)
