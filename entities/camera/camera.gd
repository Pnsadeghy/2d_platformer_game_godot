extends Camera2D

@onready var animator := $Animator

# Called when the node enters the scene tree for the first time.
func _ready():
	CameraHelper.camera_shake.connect(on_camera_shake)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_camera_shake():
	animator.play("shake")

func _on_animator_animation_finished(anim_name):
	animator.play("normal")
