extends State

class_name GroundState

func on_enter():
	super.on_enter()
	entity.air_state.was_on_floor = true

func on_process(delta):
	super.on_process(delta)
	
	if entity.jump_requested:
		state_machine.change_state(entity.jump_state)
		return false
	
	if !entity.is_on_floor():
		state_machine.change_state(entity.air_state)
		return false
	
	return true
