extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed = -800.0
var hp = 0
# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation
var player
var sound
var scene
var bar

var timer
var locked = 0

var rng = RandomNumberGenerator.new()
signal enemyDeath()


func _smart_play(name,force=false):
	if not animation.is_playing() or force:
		animation.play(name)

func _get_distance_to_player(absolute=false):
	if not player == null:
		if absolute:
			return abs (player.position.x - self.position.x)
		else:
			return player.position.x - self.position.x
	else:
		return 1000		 
		
func _orientate_to_player():
	if not player == null:
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
			timer.wait_time = rng.randf_range(0,3)
			timer.start()
	
func _move():
	var decision = rng.randf()
	var orientation = 1
	if not player == null:
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
			
		decision = rng.randf()
		print_debug(decision)
		if decision > 0.7:
			_jump()
			
		
		locked = 1
		timer.wait_time = rng.randf_range(0.2,0.7)
		timer.start()

func _attack():
	var distance = _get_distance_to_player(true)
	var decision = distance - rng.randf_range(0,200)
	if decision < 0:
#		print_debug("Played")
		if not sound.playing:
			sound.play()
		_smart_play("Punch")
		
func _jump():
	if is_on_floor():
		velocity.y = jump_speed
		_smart_play("Jump")



# Called when the node enters the scene tree for the first time.
func _ready():
	animation = get_node("EnemyAnimation")
	player = get_node("../Player")
	sound = get_node("EnemySound")
	scene = get_node("../../Scene")
	bar = get_node("../Interface/EnemyHealth")
	hp = scene.enemy_start_health
	bar.max_value = hp
	bar.value = hp
	_smart_play("Punch")
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
	bar.value = hp
	if hp <= 0:
		emit_signal("enemyDeath")
		scene.enemy_start_health += 1
		queue_free()
		# spawn new enemy
		var enemy = duplicate()
		# normal y = -500
		enemy.position = Vector2(randf_range(400, -550), -500)
		get_parent().add_child(enemy)

func flip_direction():
	apply_scale(Vector2(scale.x * -1,1)) # flip
	set_position(Vector2(position.x,position.y))

func _init():
	timer = Timer.new()
	timer.wait_time = 0.25
	add_child(timer)
	timer.timeout.connect(_timeout)

func _timeout():
	locked = 0
