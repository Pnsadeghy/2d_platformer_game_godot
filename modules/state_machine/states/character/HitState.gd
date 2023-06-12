extends State

class_name HisState

var hit_position := Vector2.ZERO
var hit_damage := 0

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "hit"
	
func on_enter():
	super.on_enter()
	
	entity.current_health -= hit_damage
	
	CameraHelper.camera_shake.emit()
	
	if entity.current_health <= 0:
		state_machine.change_state(entity.dead_state)
		return
	
	var direction = hit_position.direction_to(entity.global_position)
	direction.x *= entity.move_speed
	direction.y *= entity.jump_force
	entity.velocity = direction

func on_animation_finished():
	if entity.is_on_floor():
		state_machine.change_state(entity.idle_state)
	else:
		state_machine.change_state(entity.air_state)
