extends Node2D

var isPaused = false

func _ready():
	set_process(true)

func _process(delta):
	# option to exit the game
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()

