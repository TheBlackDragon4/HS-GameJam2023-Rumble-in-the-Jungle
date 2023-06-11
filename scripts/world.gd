extends Node2D

@export var enemy_start_health = 1

func _ready():
	set_process(true)
	$Interface/Retry.hide()
	
	var random = RandomNumberGenerator.new()
	var scene = random.randf()
	
	if scene <= 0.5:
		$Background/Jungle.hide()
		$Background/Jungle/JungleAudio.play()
	else:
		$Background/Jungle2.hide()
		$Background/Jungle2/JungleAudio2.play()
	
	

func _process(delta):
	# option to exit the game
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()


func _on_player_player_dead():
	$Interface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("key_retry") and $Interface/Retry.visible:
		get_tree().reload_current_scene()
