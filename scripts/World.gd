extends Node2D


var enemy_scene = preload("res://Enemies/enemy.tscn")

# 1280 x 1024
func _on_enemy_enemy_dead():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(randf_range(100, 1000), -20)
	add_child(enemy)
