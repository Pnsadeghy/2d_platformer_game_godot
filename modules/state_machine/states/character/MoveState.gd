extends GroundState

class_name MoveState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "move"

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.movement_x == 0:
		state_machine.change_state(entity.idle_state)
		return false
		
	entity.set_movement_x()
	
	return true
