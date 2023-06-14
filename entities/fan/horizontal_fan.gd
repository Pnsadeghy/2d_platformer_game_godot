extends Node2D

@export var force = 180

func _on_force_area_body_entered(body):
	body.horizontal_force = force

func _on_force_area_body_exited(body):
	body.horizontal_force = 0
