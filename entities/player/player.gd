extends StateCharacter

class_name Player

var idle_state
var move_state
var air_state
var jump_state
var hit_state
var on_wall_state
var wall_jump_state

@onready var jump_timer := $JumpTimer

func _init():
	super._init()
	
	const IdleState = preload("res://modules/state_machine/states/character/IdleState.gd")
	const MoveState = preload("res://modules/state_machine/states/character/MoveState.gd")
	const AirState = preload("res://modules/state_machine/states/character/OnAirState.gd")
	const JumpState = preload("res://modules/state_machine/states/character/JumpState.gd")
	const HitState = preload("res://modules/state_machine/states/character/HitState.gd")
	const OnWallState = preload("res://modules/state_machine/states/character/OnWallState.gd")
	const WallJumpState = preload("res://modules/state_machine/states/character/WallJumpState.gd")
	
	idle_state = IdleState.new(state_machine, self)
	move_state = MoveState.new(state_machine, self)
	air_state = AirState.new(state_machine, self)
	jump_state = JumpState.new(state_machine, self)
	hit_state = HitState.new(state_machine, self)
	on_wall_state = OnWallState.new(state_machine, self)
	wall_jump_state = WallJumpState.new(state_machine, self)

	state_machine.change_state(idle_state)

func _process(delta):
	super._process(delta)
	
	if Input.is_action_pressed("jump") and !jump_requested:
		Input.action_release("jump")
		jump_requested = true
		if !is_on_floor():
			jump_timer.start()
	
	movement_x = Input.get_axis("left", "right")

func on_jump():
	super.on_jump()
	jump_timer.stop()
		
func _on_jump_timer_timeout():
	jump_requested = false
