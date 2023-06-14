extends State

class_name HeadReadyState

var timer

func _init(state_machine, entity):
	super._init(state_machine, entity)
	
	animation_name = "idle"
	
	timer = Timer.new()
	timer.wait_time = 0.5
	timer.name = "ReadyTimer"
	timer.one_shot = true
	entity.add_child(timer)
	timer.timeout.connect(on_ready)
	
func on_ready():
	state_machine.change_state(entity.move_state)

func on_enter():
	super.on_enter()
	timer.start()
	
	entity.velocity = Vector2.ZERO
	
	entity.set_checker_rotation()
	entity.set_damagable(false)

func on_exit():
	super.on_exit()
	
	timer.stop()
