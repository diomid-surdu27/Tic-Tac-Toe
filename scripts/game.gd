extends Node2D

var turn = Globals.TurnState.TURN_X

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _ready():
	$Cell.clicked.connect(_on_cell_clicked)
	$Cell2.clicked.connect(_on_cell_clicked)
	$Cell3.clicked.connect(_on_cell_clicked)
	$Cell4.clicked.connect(_on_cell_clicked)
	$Cell5.clicked.connect(_on_cell_clicked)
	$Cell6.clicked.connect(_on_cell_clicked)
	$Cell7.clicked.connect(_on_cell_clicked)
	$Cell8.clicked.connect(_on_cell_clicked)
	$Cell9.clicked.connect(_on_cell_clicked)
#Logday 39
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
