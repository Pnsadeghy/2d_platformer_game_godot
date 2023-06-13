extends OnAirState

class_name AirJumpState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "air_jump"

func on_enter():
	super.on_enter()
	entity.on_jump()
	entity.velocity.y = -entity.jump_force
	entity.on_floor_dust()

func on_animation_finished():
	state_machine.change_state(entity.air_state)
