class_name State

var state_machine
var entity
var animation_name: String = ""
var is_enabled = false

func _init(machine: StateMachine, entity):
	self.entity = entity
	state_machine = machine

func on_enter():
	is_enabled = true

func on_exit():
	is_enabled = false
	
func on_process(delta):
	return true
	
func on_physics_process(delta):
	pass

func on_animation_finished():
	pass
