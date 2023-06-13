extends GroundState

class_name MoveState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "move"
	
func on_enter():
	super.on_enter()
	entity.on_floor_dust()

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.horizontal_movement == 0:
		state_machine.change_state(entity.idle_state)
		return false
	
	return true

func on_physics_process(delta):
	super.on_physics_process(delta)
	
	entity.set_vertical_movement()
