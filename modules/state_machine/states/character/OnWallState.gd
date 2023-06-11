extends AirState

class_name OnWallState

var animation_set := false

func on_enter():
	super.on_enter()
	animation_set = false

func on_process(delta):
	if !super.on_process(delta): return
	
	if !entity.is_facing_wall():
		state_machine.change_state(entity.air_state)
		return false
		
	if entity.jump_requested:
		state_machine.change_state(entity.wall_jump_state)
		return false
		
	if !animation_set and entity.wall_distance() <= 10:
		animation_set = true
		entity.play_animation("on_wall")

func on_physics_process(delta):
	super.on_physics_process(delta)
	
	if entity.velocity.y > 0:
		entity.velocity.y = lerp(entity.velocity.y, entity.wall_gravity_scale, 0.5)
