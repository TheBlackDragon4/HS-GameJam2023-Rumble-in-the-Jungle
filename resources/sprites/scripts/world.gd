extends Node2D

func _ready():
	set_process(true)
	$Interface/Retry.hide()
	

func _process(delta):
	# option to exit the game
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()


func _on_player_player_dead():
	$Interface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("key_retry") and $Interface/Retry.visible:
		get_tree().reload_current_scene()
