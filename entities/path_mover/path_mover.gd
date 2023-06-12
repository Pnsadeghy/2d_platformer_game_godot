extends Path2D

@export var speed := 10
@onready var follower := $Follower

func _process(delta):
	var ratio = follower.progress_ratio + (speed * delta) / 100
	if ratio > 100:
		ratio = 0
	follower.progress_ratio = ratio
