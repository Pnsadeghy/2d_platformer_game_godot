extends State

class_name RockHeadMoveState

var damage_detected := false
var blink_timer

func _init(state_machine, entity):
	super._init(state_machine, entity)
	
	blink_timer = Timer.new()
	blink_timer.wait_time = 1
	blink_timer.name = "BlinkTimer"
	blink_timer.one_shot = false
	entity.add_child(blink_timer)
	blink_timer.timeout.connect(on_blink)
	
	animation_name = "idle"

func on_enter():
	super.on_enter()
	damage_detected = false
	blink_timer.start()
	
func on_exit():
	super.on_exit()
	blink_timer.stop()

func on_process(delta):
	super.on_process(delta)
	
	if !damage_detected and entity.is_damage_detected():
		damage_detected = true
		entity.set_damagable(true)
		
	if entity.is_wall_detected():
		state_machine.change_state(entity.hit_state)
		
func on_physics_process(delta):
	super.on_physics_process(delta)
	
	var move_velocity = entity.velocity
	if move_velocity.length() < entity.move_speed:
		move_velocity += entity.move_direction * entity.move_speed * delta
	entity.velocity = move_velocity
		
func on_blink():
	entity.play_animation("blink")
