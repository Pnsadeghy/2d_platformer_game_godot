extends Area2D

signal on_collect

@export var point := 10

var is_collected = false

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(on_body_entered)
	animator.animation_finished.connect(on_animation_finished)	
	
func on_body_entered(body):
	if is_collected: return
	is_collected = true
	monitoring = false
	monitorable = false
	animator.play("collect")
	on_collect.emit()

func on_animation_finished():
	queue_free()
	


