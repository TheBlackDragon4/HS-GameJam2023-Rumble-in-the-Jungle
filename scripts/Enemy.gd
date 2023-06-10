extends Node


@export var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.
	

func _on_hurtbox_hurt(damage):
	hp -= damage
	print("took damage")
	if hp <= 0:
		queue_free()
		print("dead")
