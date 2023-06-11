class_name Hurtbox extends Area2D

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

# Area overlap
func _on_area_entered(area):
	# is area in attack group
	if area.is_in_group("attack"):
		# if dmg = 0 dont do shit cause if then crash
		if not area.get("damage") == null:
			# disable hurtbox
			collision.call_deferred("set_disabled", true)
			# start timer
			disableTimer.start()
			# calculate dmg
			var damage = area.damage
			# send signal to enemy/player
			emit_signal("hurt", damage)

func _on_disable_timer_timeout():
	collision.call_deferred("set_disabled", false)
