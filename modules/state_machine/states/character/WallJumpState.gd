extends AirState

class_name WallJumpState

enum Status {
	Check,
	Jump
}

var timer: Timer
var status: Status

const CHECK_TIMEOUT = 0.1
const JUMP_TIMEOUT = 0.5

func _init(state_machine, entity):
	super._init(state_machine, entity)

	timer = Timer.new()
	timer.name = "WallJumpTimer"
	timer.one_shot = true
	entity.add_child(timer)
	timer.timeout.connect(on_timeout)
	animation_name = "on_wall"

func on_enter():
	status = Status.Check
	timer.wait_time = CHECK_TIMEOUT
	timer.start()

func on_physics_process(delta):
	super.on_physics_process(delta)
	
	if status == Status.Check:
		if entity.jump_requested and entity.is_input_requested_other_direction():
			on_jump()
		else:
			entity.velocity.y = 0

func on_timeout():
	if status == Status.Jump:
		entity.air_state.gravity_force = 2
	entity.set_vertical_movement()
	state_machine.change_state(entity.air_state)

func on_exit():
	timer.stop()

func on_jump():
	status = Status.Jump
	entity.velocity.x = entity.move_speed
	if entity.facing_right:
		entity.velocity.x *= -1
	entity.check_flip()
	entity.velocity.y = -entity.jump_force
	entity.on_jump()
	timer.wait_time = JUMP_TIMEOUT
	timer.start()
	entity.play_animation("jump")
