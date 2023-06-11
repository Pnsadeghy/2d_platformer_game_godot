extends State

class_name AirState

var set_gravity := true
var gravity_force := 1.0

func on_process(delta):
	if !super.on_process(delta): return false
	
	if entity.is_on_floor():
		state_machine.change_state(entity.idle_state)
		return false
		
	if set_gravity:
		if entity.velocity.y > 0:
			entity.velocity.y += entity.fall_gravity_scale * gravity_force * delta
		else:
			entity.velocity.y += entity.jump_gravity_scale * delta
			
	if animation_name == '':
		if entity.velocity.y > 0:
			entity.play_animation("fall")
		else:
			entity.play_animation("jump")

	return true
	
func on_exit():
	gravity_force = 1.0
