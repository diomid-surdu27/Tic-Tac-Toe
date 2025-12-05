extends Area2D

signal clicked(this_cell)
var fill_state = Globals.fill_states.fill_empty

func _ready():
	%X.visible = false
	%O.visible = false



func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		clicked.emit(self) 
		
		
func fill(new_fill):	
	if fill_state == Globals.fill_states.fill_empty:
		fill_state = new_fill
		
		if fill_state == fill_state.fill_X:
			%X.visible = true
		elif fill_state == Globals.fill_states.fill_O:
			%O.visible = true
