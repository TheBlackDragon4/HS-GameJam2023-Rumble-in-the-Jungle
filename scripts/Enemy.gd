extends Area2D

@export var speed = 300.0
@export var jump_speed = -400.0
@export var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.y += 5
	pass


	# Hit detection
func _on_hurtbox_hurt(damage):
	hp -= damage
	print("took damage")
	if hp <= 0:
		print("dead")
		queue_free()
		# spawn new enemy
		var enemy = duplicate()
		enemy.position = Vector2(randf_range(100, 900), -50)
		print("spawn")
		get_parent().add_child(enemy)
