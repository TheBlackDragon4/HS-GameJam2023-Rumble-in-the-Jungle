extends Node2D


var enemy_scene = preload("res://Enemies/enemy.tscn")

# 1280 x 1024
#func _on_enemy_enemy_dead():
#	# waits till queue is done
#	print("received signal")
#	call_deferred("_spawn_enemy")
#
#
#func _spawn_enemy():
#	var enemy = enemy_scene.instantiate()
#	enemy.position = Vector2(randf_range(100, 900), -20)
#	print("spawn")
#	add_child(enemy)
