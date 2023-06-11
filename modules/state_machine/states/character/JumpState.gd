extends State

class_name JumpState

func on_enter():
	super.on_enter()
	
	entity.on_jump()
	
func on_physics_process(delta):
	super.on_physics_process(delta)
	
	entity.velocity.y = -entity.jump_force
	state_machine.change_state(entity.air_state)
