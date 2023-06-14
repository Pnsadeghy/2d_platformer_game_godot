extends State

class_name FireIdleState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	
	animation_name = "idle"
	
func on_detected():
	if !is_enabled: return
	state_machine.change_state(entity.hit_state)
