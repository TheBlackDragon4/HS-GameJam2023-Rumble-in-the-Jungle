
extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -400.0
@export var hp = 10

signal playerDead

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	move_and_slide()
	
	if Input.is_action_just_pressed("ui_down"):
		flip_direction()

func _on_hurtbox_hurt(damage):
	hp -= damage
	print("hit")
	if hp <= 0:
		print(hp)
		queue_free()
		emit_signal("playerDead")

func flip_direction():
	apply_scale(Vector2(scale.x * -1,1)) # flip
	set_position(Vector2(position.x, position.y))

#func update_health():
#	var healthbar = %Interface/PlayerHealth
#	healthbar.value = hp
	
