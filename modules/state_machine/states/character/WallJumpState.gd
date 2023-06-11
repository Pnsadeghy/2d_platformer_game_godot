extends AirState

class_name WallJumpState

var timer
var can_change_state := true

func _init(state_machine, entity):
	super._init(state_machine, entity)

	timer = Timer.new()
	timer.name = "WallJumpTimer"
	timer.one_shot = true
	timer.wait_time = 0.4
	entity.add_child(timer)
	timer.timeout.connect(on_timeout)

func on_enter():
	entity.velocity.x = entity.move_speed
	if entity.facing_right:
		entity.velocity.x *= -1
	entity.velocity.y = -entity.jump_force
	entity.on_jump()
	timer.start()
	can_change_state = false

func on_process(delta):
	if !super.on_process(delta): return false
	
	if can_change_state:
		entity.air_state.gravity_force = 2
		state_machine.change_state(entity.air_state)
		return false
	
	return true

func on_timeout():
	can_change_state = true
	
func on_exit():
	timer.stop()
