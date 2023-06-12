extends State

class_name DeadState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	animation_name = "dead"
	
func on_enter():
	super.on_enter()
	
	entity.velocity = Vector2.ZERO
	entity.on_disabled()

func on_animation_finished():
	entity.queue_free()
