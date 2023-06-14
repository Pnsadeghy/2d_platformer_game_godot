extends Node2D

@export var force := 150

func _on_force_area_body_entered(body):
	body.vertical_force = force


func _on_force_area_body_exited(body):
	body.vertical_force = 0
