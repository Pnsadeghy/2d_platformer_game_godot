extends Node2D

var is_trigger = false

@onready var animator := $AnimationPlayer

func _on_trigger_area_body_entered(body):
	if body.velocity.y >= 0:
		is_trigger = true
		animator.play("trigger")

func _on_animation_player_animation_finished(anim_name):
	if is_trigger:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if is_trigger:
		queue_free()
