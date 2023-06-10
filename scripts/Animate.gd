extends AnimationPlayer

func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		self.play("Walk")
	else:
		self.stop()
