extends Node2D

var cell_scene = preload("res://scenes/cell.tscn")
var cells = []
var board_size = Vector2i(3,3)

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
