extends GroundState

class_name IdleState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "idle"

func on_enter():
	entity.velocity = Vector2.ZERO
	
func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.movement_x != 0:
		state_machine.change_state(entity.move_state)
		return false
	
	return true
