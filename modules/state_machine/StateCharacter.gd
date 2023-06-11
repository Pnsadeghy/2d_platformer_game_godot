extends CharacterBody2D

class_name StateCharacter

# properties
@export var move_speed := 200.0
@export var jump_force := 300.0
@export var fall_gravity_scale := 980.0
@export var jump_gravity_scale := 600.0
@export var wall_gravity_scale := 100.0

# variables
var state_machine: StateMachine
var movement_x := 0.0
var facing_right := true

var jump_requested := false
var can_check_direction := true

# states
var idle_state
var move_state
var air_state
var jump_state
var hit_state
var on_wall_state
var wall_jump_state

# childs
@onready var animator: AnimatedSprite2D = $Animator
@onready var wall_checker: RayCast2D = $WallChecker

func _init():
	const StateManager = preload("res://modules/state_machine/StateMachine.gd")
	state_machine = StateManager.new(self)
	
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
	
func _ready():
	animator.animation_finished.connect(state_machine.on_animation_finished)

func _process(delta):
	state_machine.on_process(delta)
	
	if can_check_direction:
		check_flip()
	
func _physics_process(delta):
	state_machine.on_physics_process(delta)
	move_and_slide()

func play_animation(name: String):
	animator.play(name)

func set_movement_x():
	velocity.x = movement_x * move_speed
	
func is_facing_wall():
	return wall_checker.is_colliding()

func check_flip():
	if velocity.x == 0: return
	if velocity.x > 0:
		animator.flip_h = false
		wall_checker.rotation = 0
		facing_right = true
	else:
		animator.flip_h = true
		wall_checker.rotation = deg_to_rad(180)
		facing_right = false

func on_jump():
	jump_requested = false
