extends State

class_name FireHitState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	
	animation_name = "hit"
	
func on_animation_finished():
	super.on_animation_finished()
	
	state_machine.change_state(entity.fire_state)
