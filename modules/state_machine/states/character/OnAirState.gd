extends AirState

class_name OnAirState

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.is_facing_wall():
		state_machine.change_state(entity.on_wall_state)
		return false
	if entity.movement_x != 0:
		entity.set_movement_x()
	else:
		entity.velocity.x = lerp(entity.velocity.x, 0.0, 0.01)

	return true
