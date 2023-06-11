class_name State

var state_machine
var entity
var animation_name: String = ""

func _init(machine: StateMachine, entity):
	self.entity = entity
	state_machine = machine

func on_enter():
	pass

func on_exit():
	pass
	
func on_process(delta):
	return true
	
func on_physics_process(delta):
	pass

func on_animation_finished():
	pass
