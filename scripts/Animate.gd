extends AnimationPlayer

var timer
var locked = 0

func _smart_play(name,force=false):
	if not self.is_playing() or force:
		self.play(name)

func _init():
	timer = Timer.new()
	timer.wait_time = 0.75
	add_child(timer)
	timer.timeout.connect(_timeout)
	
 
func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		_smart_play("Walk")
	if Input.is_action_pressed("key_attack_one") and not locked:
		_smart_play("Punch",true)
		locked = 1
		timer.start()
	if Input.is_action_pressed("ui_right"):
		_smart_play("Walk_Back")
	if Input.is_action_pressed("ui_up"):
		_smart_play("Jump")
	if not self.is_playing():
		self.play("Idle")
		
	#print (locked)

func _timeout():
	locked = 0
