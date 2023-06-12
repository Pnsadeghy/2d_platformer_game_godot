extends AirState

class_name OnWallState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "on_wall"

func on_process(delta):
	if !super.on_process(delta): return

	if entity.jump_requested or entity.is_input_requested_other_direction():
		state_machine.change_state(entity.wall_jump_state)
		return false
	
	if !entity.is_facing_wall() or entity.horizontal_movement == 0:
		state_machine.change_state(entity.air_state)
		return false

	return true

func on_physics_process(delta):
	super.on_physics_process(delta)
	
	if entity.velocity.y > 0:
		entity.velocity.y = lerp(entity.velocity.y, entity.wall_gravity_scale, 0.5)
