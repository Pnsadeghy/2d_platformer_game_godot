extends Node2D

enum Status {
	Off,
	Active,
	Wait
}

@export var speed := 10
@export var point_delay := 0.0
@export var start_delay := 0.0
@export var follower: Node
@export var loop = false

var points = []
var current_point = 0
var point_direction = 1
var current_status : Status
var direction := Vector2.ZERO

@onready var point_delay_timer := $PointDelay

func _ready():
	for child in get_children():
		if child is Marker2D:
			points.append(child)
	
	if point_delay > 0:
		point_delay_timer.wait_time = point_delay
		point_delay_timer.timeout.connect(on_delay_timout)
		
	if start_delay > 0:
		active_start_delay()
	else:
		current_status = Status.Active
		
	set_point(1)
	
func active_start_delay():
	current_status = Status.Wait
	await get_tree().create_timer(start_delay).timeout
	current_status = Status.Active
		
func _physics_process(delta):
	
	if current_status == Status.Active:
		if is_reached_active_point():
			change_point()
		else:
			follower.global_position += direction * speed * delta
	
func is_reached_active_point():
	return points[current_point].global_position.distance_to(follower.global_position) < 1
	
func change_point():
	if !loop:
		if point_direction == 1:
			if current_point == points.size() - 1:
				point_direction = -1
		elif current_point == 0:
				point_direction = 1
	elif current_point == points.size() - 1:
		current_point = -1

	set_point(current_point + point_direction)
	
	if point_delay > 0:
		current_status = Status.Wait
		point_delay_timer.start()

func set_point(point):
	current_point = point
	direction = follower.global_position.direction_to(points[current_point].global_position)
		
func on_delay_timout():
	current_status = Status.Active
