extends Node2D

var turn = Globals.TurnState.TURN_X

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _ready():
	pass
#Logday 39
