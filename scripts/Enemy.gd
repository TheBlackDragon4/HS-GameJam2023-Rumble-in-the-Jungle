extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -400.0
@export var hp = 10

signal dead()

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	move_and_slide()
	
	# Hit detection
func _on_hurtbox_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
		emit_signal("dead")
		# spawn new enemy
		var enemy = duplicate()
		# normal y = -500
		enemy.position = Vector2(randf_range(400, -550), -500)
		get_parent().add_child(enemy)
