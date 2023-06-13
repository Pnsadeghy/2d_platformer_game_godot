extends GroundState

class_name IdleState

var was_on_floor := false

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "idle"

func on_enter():
	super.on_enter()
	entity.velocity = Vector2.ZERO
	if !was_on_floor:
		entity.on_floor_dust()
		was_on_floor = true
	
func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.horizontal_movement != 0:
		state_machine.change_state(entity.move_state)
		return false
	
	return true
