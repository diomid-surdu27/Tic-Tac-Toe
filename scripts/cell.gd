extends Area2D

signal clicked(this_cell)
var fill_state = Globals.FillState.FILL_NONE

func _ready():
	%X.visible = false
	%O.visible = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		clicked.emit(self) 
		
		
func fill(new_fill_state: Globals.FillState):	
	if fill_state == Globals.FillState.FILL_NONE:
		fill_state = new_fill_state
		
		if fill_state == Globals.FillState.FILL_X:
			%X.visible = true
		elif fill_state == Globals.FillState.FILL_O:
			%O.visible = true
			
func change_color(new_color: Color):
	%X.modulate = new_color
	%O.modulate = new_color
	
func highlight(enable: bool):
	if enable == true:
		change_color(Color.SEA_GREEN)
	else:
		change_color(Color.BLACK)
