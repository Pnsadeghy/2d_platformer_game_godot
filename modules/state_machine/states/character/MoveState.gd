extends GroundState

class_name MoveState

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.movement_x == 0:
		state_machine.change_state(entity.idle_state)
		return false
		
	entity.set_movement_x()
	
	return true
