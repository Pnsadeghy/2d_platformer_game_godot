extends AirState

class_name OnAirState

var jump_timer
var can_jump := false
var was_on_floor = false
var air_jump_remains := 0

func _init(state_machine, entity):
	super._init(state_machine, entity)

	jump_timer = Timer.new()
	jump_timer.name = "CayotyTimer"
	jump_timer.one_shot = true
	jump_timer.wait_time = 0.1
	entity.add_child(jump_timer)
	jump_timer.timeout.connect(on_jump_timeout)

func on_enter():
	super.on_enter()
	if was_on_floor:
		jump_timer.start()
		can_jump = true
	else:
		can_jump = false
	was_on_floor = false
	
func on_exit():
	super.on_exit()
	jump_timer.stop()

func on_process(delta):
	if !super.on_process(delta): return false

	if entity.is_facing_wall():
		if entity.jump_requested or entity.is_input_requested_other_direction():
			state_machine.change_state(entity.wall_jump_state)
			return false
		
		if entity.velocity.y > 0 and entity.horizontal_movement != 0:
			state_machine.change_state(entity.on_wall_state)
			return false
			
	if entity.jump_requested:
		if can_jump:
			state_machine.change_state(entity.jump_state)
			return false

		if check_air_jump():
			return false

	return true
	
func on_physics_process(delta):
	super.on_physics_process(delta)
	
	if entity.horizontal_movement != 0:
		entity.set_vertical_movement()
	else:
		entity.velocity.x = lerp(entity.velocity.x, 0.0, 0.1)
		
func on_jump_timeout():
	can_jump = false

func reached_ground():
	was_on_floor = true
	air_jump_remains = entity.air_jumps_amount
	
func check_air_jump():
	if air_jump_remains == 0: return false
	air_jump_remains -= 1
	state_machine.change_state(entity.air_jump_state)
	return true
