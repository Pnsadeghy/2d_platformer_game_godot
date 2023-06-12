extends State

class_name RockHeadHitState

func on_enter():
	super.on_enter()
	
	entity.play_hit_animation()
	
func on_animation_finished():
	super.on_animation_finished()
	
	entity.set_next_point()
	state_machine.change_state(entity.ready_state)
