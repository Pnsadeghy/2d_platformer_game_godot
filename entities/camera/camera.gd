extends Camera2D

@onready var animator := $Animator

var is_shaking := false

# Called when the node enters the scene tree for the first time.
func _ready():
	CameraHelper.camera_shake.connect(on_camera_shake)
	CameraHelper.camera_shake_start.connect(on_camera_shake_start)
	CameraHelper.camera_shake_end.connect(on_camera_shake_end)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_camera_shake():
	if is_shaking: return
	animator.play("shake")

func _on_animator_animation_finished(anim_name):
	animator.play("normal")
	
func on_camera_shake_start():
	is_shaking = true
	animator.play("shake_repeat")

func on_camera_shake_end():
	is_shaking = false
	animator.play("normal")
