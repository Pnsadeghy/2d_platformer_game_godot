extends AnimatableBody2D

@onready var colission := $CollisionShape2D

func ow_disable_collision():
	colission.disabled = true
	await get_tree().create_timer(0.5).timeout
	colission.disabled = false
