extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -400.0
@export var hp = 10
# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_flip = 0

var animation
var player

var timer
var locked = 0

var rng = RandomNumberGenerator.new()


func _smart_play(name,force=false):
	if not animation.is_playing() or force:
		animation.play(name)

func _get_distance_to_player(absolute=false):
	if absolute:
		return abs (player.position.x - self.position.x)
	else:
		return player.position.x - self.position.x
		
func _orientate_to_player():
	if _get_distance_to_player() > 0:
		if self.scale.y == -1:
			flip_direction()
	else:
		if self.scale.y == 1:
			flip_direction()
			
func _idle():
	var decision = rng.randf()
	if not locked:
		if decision > 0.9:
			velocity.x = 0
			_smart_play("Idle")
			locked = 1
			timer.wait_time = rng.randf_range(0,5)
			timer.start()
	
func _move():
	var decision = rng.randf()
	var orientation = 1
	if player.position.x > self.position.x:
		orientation = 1
	else:
		orientation = -1
	if not locked:
		if decision > 0.4:
			velocity.x = speed * orientation
			_smart_play("Walk")
		else:
			velocity.x = speed * -1 * orientation
			_smart_play("Walk_Back")
		locked = 1
		timer.wait_time = rng.randf_range(0.2,0.7)
		timer.start()

func _attack():
	var distance = _get_distance_to_player(true)
	var decision = distance - rng.randf_range(0,200)
	print_debug(decision)
	if decision < 0:
		_smart_play("Punch")

		


# Called when the node enters the scene tree for the first time.
func _ready():
	animation = get_node("EnemyAnimation")
	player = get_node("../Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#_smart_play("Idle")
	_orientate_to_player()
	_idle()
	_move()
	_attack()

	pass

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	move_and_slide()
	
	# Hit detection
func _on_hurtbox_hurt(damage):
	hp -= damage
	print("took damage")
	if hp <= 0:
		print("dead")
		queue_free()
		# spawn new enemy
		var enemy = duplicate()
		# normal y = -500
		enemy.position = Vector2(randf_range(400, -550), -500)
		print("spawn")
		get_parent().add_child(enemy)

func flip_direction():
	apply_scale(Vector2(scale.x * -1,1)) # flip
	set_position(Vector2(position.x + move_flip,position.y))
	move_flip = move_flip * -1

func _init():
	timer = Timer.new()
	timer.wait_time = 0.25
	add_child(timer)
	timer.timeout.connect(_timeout)

func _timeout():
	locked = 0
