extends StateCharacter

class_name Player

@onready var jump_timer := $JumpTimer
@onready var foot_dust := $FootDust
@onready var wall_dust := $WallDust

func _process(delta):
	if Input.is_action_pressed("jump") and !jump_requested and !Input.is_action_pressed("down"):
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

func check_one_way_down():
	if !Input.is_action_pressed("down") or !Input.is_action_pressed("jump"): return false
	return request_down_checker()

func on_floor_dust():
	foot_dust.restart()
	
func on_wall_dust():
	wall_dust.restart()

func set_wall_dust(enabled: bool):
	pass

func check_flip():
	super.check_flip()
	if facing_right:
		wall_dust.position.x = -abs(wall_dust.position.x)
	else:
		wall_dust.position.x = abs(wall_dust.position.x)
