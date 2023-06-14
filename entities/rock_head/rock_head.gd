extends CharacterBody2D

enum TargetDirection {
	Top,
	Down,
	Right,
	Left
}

@export var move_speed := 400
@export var points: Array[TargetDirection] = []
@export var loop := false

var state_machine
var move_direction := Vector2.ZERO
var point_direction = 1
var current_point = 0

var ready_state
var move_state
var hit_state

@onready var animator: AnimatedSprite2D = $Animator
@onready var checker := $Checker
@onready var wall_checker := $Checker/WallChecker
@onready var damage_checker := $Checker/DamageChecker
@onready var hit_area := $Checker/HitArea

func _ready():

	const StateMachine = preload("res://modules/state_machine/StateMachine.gd")
	state_machine = StateMachine.new(self)
	
	animator.animation_finished.connect(state_machine.on_animation_finished)
	
	const ReadyState = preload("res://entities/rock_head/states/HeadReadyState.gd")
	const MoveState = preload("res://entities/rock_head/states/HeadMoveState.gd")
	const HitState = preload("res://entities/rock_head/states/HeadHitState.gd")
	
	ready_state = ReadyState.new(state_machine, self)
	move_state = MoveState.new(state_machine, self)
	hit_state = HitState.new(state_machine, self)
	
	state_machine.change_state(ready_state)

func _process(delta):
	state_machine.on_process(delta)
	
func _physics_process(delta):
	state_machine.on_physics_process(delta)
	move_and_slide()
	
func set_next_point():
	if point_direction == -1 and current_point == 0:
		point_direction = 1
	elif point_direction == 1 and current_point == points.size() - 1:
		if loop:
			point_direction = -1
		else:
			current_point = 0
			return
	current_point += point_direction

func set_checker_rotation():
	var deg = 0.0
	move_direction = Vector2.UP
	match points[current_point]:
		TargetDirection.Down:
			deg = 180
			move_direction = Vector2.DOWN
			pass
		TargetDirection.Right:
			deg = 90
			move_direction = Vector2.RIGHT
			pass
		TargetDirection.Left:
			move_direction = Vector2.LEFT
			deg = 270
			pass
	checker.rotation = deg_to_rad(deg)
	
func play_animation(name):
	animator.play(name)

func set_damagable(enable: bool):
	hit_area.monitorable = enable
	hit_area.monitoring = enable

func is_damage_detected():
	return damage_checker.is_colliding()
	
func is_wall_detected():
	return wall_checker.is_colliding()
	
func play_hit_animation():
	var name = "top_hit"
	match points[current_point]:
		TargetDirection.Down:
			name = "bottom_hit"
			pass
		TargetDirection.Right:
			name = "right_hit"
			pass
		TargetDirection.Left:
			name = "left_hit"
			pass
	play_animation(name)
