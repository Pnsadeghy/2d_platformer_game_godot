extends Node2D

enum FirstDirection {
	clock = 1,
	reverse = -1
}

@export var rotator: Node
@export var follow_point: Marker2D
@export var follower: Node

@export var min_deg := 0
@export var max_deg := 0

@export var speed := 1.0
@export var first_direction := FirstDirection.clock

var rotate_direction = 1

func _ready():
	rotate_direction = first_direction

func _physics_process(delta):
	
	var rotation_deg = rad_to_deg(rotator.rotation) + 90
	if (min_deg != 0 and rotation_deg < min_deg) or (max_deg != 0 and rotation_deg > max_deg):
		rotate_direction *= -1
	
	rotator.rotate(speed * delta * rotate_direction)
	
	follower.global_position = follow_point.global_position
