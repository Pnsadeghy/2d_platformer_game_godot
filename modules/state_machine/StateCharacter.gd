extends CharacterBody2D

class_name StateCharacter

# properties
@export var move_speed := 200.0
@export var jump_force := 420.0
@export var fall_gravity_scale := 1500.0
@export var jump_gravity_scale := 1300.0
@export var wall_gravity_scale := 10.0
@export var air_jumps_amount := 1
@export var max_health = 3

# variables
var state_machine: StateMachine
var horizontal_movement := 0.0
var facing_right := true

var jump_requested := false
var can_check_direction := true
var current_health := 0
# states
var idle_state
var move_state
var air_state
var jump_state
var hit_state
var dead_state
var on_wall_state
var wall_jump_state
var air_jump_state

# childs
@onready var animator: AnimatedSprite2D = $Animator
@onready var wall_checker: RayCast2D = $WallChecker
@onready var one_way_checker: RayCast2D = $OneWayChecker
@onready var collision_shape := $CollisionShape

func _init():
	const StateMachine = preload("res://modules/state_machine/StateMachine.gd")
	state_machine = StateMachine.new(self)
	
	const IdleState = preload("res://modules/state_machine/states/character/IdleState.gd")
	const MoveState = preload("res://modules/state_machine/states/character/MoveState.gd")
	const AirState = preload("res://modules/state_machine/states/character/OnAirState.gd")
	const JumpState = preload("res://modules/state_machine/states/character/JumpState.gd")
	const HitState = preload("res://modules/state_machine/states/character/HitState.gd")
	const OnWallState = preload("res://modules/state_machine/states/character/OnWallState.gd")
	const WallJumpState = preload("res://modules/state_machine/states/character/WallJumpState.gd")
	const AirJumpState = preload("res://modules/state_machine/states/character/AirJumpState.gd")
	const DeadState = preload("res://modules/state_machine/states/character/DeadState.gd")
	
	idle_state = IdleState.new(state_machine, self)
	move_state = MoveState.new(state_machine, self)
	air_state = AirState.new(state_machine, self)
	jump_state = JumpState.new(state_machine, self)
	hit_state = HitState.new(state_machine, self)
	on_wall_state = OnWallState.new(state_machine, self)
	wall_jump_state = WallJumpState.new(state_machine, self)
	air_jump_state = AirJumpState.new(state_machine, self)
	dead_state = DeadState.new(state_machine, self)
	
	current_health = max_health
	
func _ready():
	animator.animation_finished.connect(state_machine.on_animation_finished)
	state_machine.change_state(idle_state)

func _process(delta):
	state_machine.on_process(delta)
	
func _physics_process(delta):
	state_machine.on_physics_process(delta)
	move_and_slide()

func play_animation(name: String):
	animator.play(name)
	
func on_jump():
	jump_requested = false
	
func on_hit(area):
	hit_state.hit_damage = area.damage
	hit_state.hit_position = area.global_position
	state_machine.change_state(hit_state)

func on_disabled():
	collision_shape.disabled = true
	
func set_vertical_movement():
	velocity.x = horizontal_movement * move_speed
	check_flip()

func is_facing_wall():
	return wall_checker.is_colliding()
	
func is_input_requested_other_direction():
	if horizontal_movement == 0: return false
	if horizontal_movement > 0: return !facing_right
	return facing_right

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
		
func check_one_way_down():
	return false

func request_down_checker():
	if !one_way_checker.is_colliding(): return false
	var collider = one_way_checker.get_collider()
	if !collider.has_method('ow_disable_collision'): return false
	collider.ow_disable_collision()
	return true
	
func on_floor_dust():
	pass
	
func on_wall_dust():
	pass

func set_wall_dust(enabled: bool):
	pass
	
