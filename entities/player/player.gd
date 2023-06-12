extends StateCharacter

class_name Player

@onready var jump_timer := $JumpTimer

func _process(delta):
	if Input.is_action_pressed("jump") and !jump_requested:
		Input.action_release("jump")
		jump_requested = true
		if !is_on_floor():
			jump_timer.start()
	
	horizontal_movement = Input.get_axis("left", "right")
	
	super._process(delta)	

func on_jump():
	super.on_jump()
	jump_timer.stop()

func _on_jump_timer_timeout():
	jump_requested = false
