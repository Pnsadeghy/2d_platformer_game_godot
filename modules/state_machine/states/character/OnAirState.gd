extends AirState

class_name OnAirState

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.is_facing_wall():
		state_machine.change_state(entity.on_wall_state)
		return false

	return true
	
func on_physics_process(delta):
	super.on_physics_process(delta)
	
	if entity.horizontal_movement != 0:
		entity.set_vertical_movement()
	else:
		entity.velocity.x = lerp(entity.velocity.x, 0.0, 0.05)

