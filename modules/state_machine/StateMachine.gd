class_name StateMachine

var entity = null
var current_state: State = null

func _init(entity):
	self.entity = entity
	
func change_state(new_state: State):
	if new_state == current_state: return
	
	if current_state != null:
		current_state.on_exit()
	
	current_state = new_state
	current_state.on_enter()
	
	if current_state.animation_name != "":
		entity.play_animation(current_state.animation_name)
		
func on_process(delta):
	if current_state:
		current_state.on_process(delta)
	
func on_physics_process(delta):
	if current_state:
		current_state.on_physics_process(delta)
	
func on_animation_finished():
	current_state.on_animation_finished()
