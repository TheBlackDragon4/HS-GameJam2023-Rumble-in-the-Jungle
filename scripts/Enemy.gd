extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -400.0
@export var hp = 10
@onready var player = get_tree().get_nodes_in_group("player")[0]
var playerPos = 0

signal dead()

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation

func _smart_play(name,force=false):
	if not animation.is_playing() or force:
		animation.play(name)


var timer
var locked = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = get_node("EnemyAnimation")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_smart_play("Idle")
#	player = get_tree().get_nodes_in_group("player")[0]
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
		enemy.position = Vector2(randf_range(-550, 400), -500)
		get_parent().add_child(enemy)


func _init():
	timer = Timer.new()
	timer.wait_time = 0.75
	add_child(timer)
	timer.timeout.connect(_timeout)

func _timeout():
	locked = 0
