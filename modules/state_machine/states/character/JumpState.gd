extends State

class_name JumpState

func on_enter():
	entity.velocity.y = -entity.jump_force
	entity.on_jump()
	
func on_process(delta):
	state_machine.change_state(entity.air_state)
	return false
