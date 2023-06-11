extends Label

var score = 0

func _on_enemy_enemy_death():
	score += 1
	text = "Score: %s" % score

