extends CharacterBody2D

# The movement of the character
var speed = 100 

func _process(delta):
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		movement.x -= speed;
	if Input.is_action_pressed("ui_right"):
		movement.x += speed;
	if Input.is_action_pressed("ui_up"):
		movement.y -= speed
	if Input.is_action_pressed("ui_down"):
		movement.y += speed

	# Normalize the direction vector to ensure that the movement is at constant speed
	movement = movement.normalized()
	
	# Calculate the movementspeed
	var velocity = movement * speed
	
	# Movement of the character
	move_and_collide(velocity * delta)
