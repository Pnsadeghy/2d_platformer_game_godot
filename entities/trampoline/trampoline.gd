extends StaticBody2D

@export var force := 800
var is_active = true

@onready var animator := $AnimatedSprite2D

func _on_hit_area_body_entered(body):
	if !is_active: return
	is_active = true
	body.velocity.y = -force
	animator.play("jump")
	
func _on_animated_sprite_2d_animation_finished():
	is_active = true
	animator.play("idle")
