extends Node2D

var turn = Globals.turn_states.turn_X

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	#if Input.is_action_just_pressed("reset"):
		#get.tree().reload_current_scene()

func _ready():
	pass
