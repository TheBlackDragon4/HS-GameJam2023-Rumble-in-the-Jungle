extends Node2D

var isPaused = false

func _ready():
	set_process(true)

func _process(delta):
	# option to exit the game
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
	if Input.is_action_pressed("key_pause"):
		if isPaused == false:
			_pause_game()

# will be used to change the scene. So we will se a grey screen
func _pause_game():
	isPaused = true
	get_tree().paused = true
	get_tree().change_scene_to_file("res://PauseScene.tscn")	

#func _resume_game():
#	isPaused = false
#	get_tree().paused = false
