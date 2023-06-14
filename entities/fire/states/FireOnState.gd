extends State

class_name FireOnState

func _init(state_machine, entity):
	super._init(state_machine, entity)
	
	animation_name = "fire"

func on_enter():
	super.on_enter()
	entity.fire_timer.start()
	entity.set_hitarea(true)
	
func on_exit():
	super.on_exit()
	entity.set_hitarea(false)

func on_timeout():
	state_machine.change_state(entity.idle_state)
